// README
// data structures are best traversed in the order in which they are stored.
// matrices store their data in column-major order.
// arrays store their data in row-major order.

// the result of a vectorized log probability density function
// is equivalent to the sum of the evaluations on each element;
// e.g., real normal_lpdf(reals y | reals mu, reals sigma).


data {
  
  // number of latent classes
  int<lower=2> C;
  
  // number of individuals
  int<lower=2> N;
  
  // number of time periods
  int<lower=2> T;
  
  // observed dependent variable ( simulated or actual data )
  matrix[N,T] Y_obs;
  
  // time periods
  matrix[N,T] X;
  
}


transformed data {
  
  // hyperparameters of prior for mixture proportions
  vector[C] alpha;
  alpha = rep_vector(1,C);
  
}


parameters {
  
  // mixture proportions
  simplex[C] lambda;
  
  // constants
  row_vector[C] beta_0;
  
  // linear trend components
  ordered[C] beta_1;
  
  // standard deviations for Y_obs Normal distributions
  vector<lower=0>[C] sigma;
  
}

transformed parameters {
  
  // means for Y_obs Normal distributions
  array[C] matrix[N,T] M;
  for (c in 1:C) {
    for (t in 1:T) {
      M[c,,t] = beta_0[c] + beta_1[c] * col(X,t);  // vectorization
    }
  }
  
  // log transform lambda
  vector[C] lambda_log;
  lambda_log = log(lambda);  // vectorization
  
  // log posterior
  array[N] vector[C] lp;
  for (n in 1:N) {
    lp[n] = lambda_log;  // vectorization
    for (c in 1:C) {
      lp[n,c] += normal_lpdf(Y_obs[n] | M[c,n], sigma[c]);  // vectorization
    }
  }
  
}


model {
  
  // prior for mixture proportions
  lambda ~ dirichlet(alpha);  // vectorization
  
  // prior for beta_0
  beta_0 ~ normal(0,5);  // vectorization
  
  // prior for beta_1
  beta_1 ~ normal(0,1);  // vectorization
  
  // prior for sigma
  sigma ~ normal(0,1);  // vectorization
  
  // log posterior
  for (n in 1:N) {
    target += log_sum_exp(lp[n]);
  }
  
}


generated quantities {
  
  // class memberships
  array[N] int z;
  for (n in 1:N) {
    z[n] = categorical_logit_rng(lp[n]);
  }
  
  // predicted dependent variable
  array[N,T] real Y_pred;
  for (n in 1:N) {
    for (t in 1:T) {
      Y_pred[n] = normal_rng(M[z[n],n], sigma[z[n]]);  // vectorization
    }
  }
  
}


