// README
// a note on the Stan code:
// data structures are best traversed in the order in which they are stored.
// in Stan, matrices store their data in column-major order, and
// arrays store their data in row-major order.

// a note on the Stan code:
// the result of a vectorized log probability density function
// is equivalent to the sum of the evaluations on each element;
// e.g., real normal_lpdf(reals y | reals mu, real sigma).


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
  
  // hyperparameters for prior of mixture proportions
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
  
  // standard deviations for Y Normal distributions
  vector<lower=0>[C] sigma;
  
}


transformed parameters {
  
  // log posterior
  array[N] vector[C] lp;
  for (n in 1:N) {
    lp[n] = log(lambda);  // log transform lambda, vectorization
    for (c in 1:C) {
      for (t in 1:T) {
        real mu;  // means for Y_obs Normal distributions
        mu = beta_0[c] + beta_1[c] * X[n,t];
        lp[n,c] += normal_lpdf(Y_obs[n,t] | mu, sigma[c]);
      }
    }
  }
  
}


model {
  
  // prior for mixture proportions
  lambda ~ dirichlet(alpha);  // vectorization
  
  // prior for beta_0
  beta_0 ~ normal(5,10);  // vectorization
  
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
    row_vector[T] mu;  // means for Y_pred Normal distributions
    mu = beta_0[z[n]] + beta_1[z[n]] * X[n];  // vectorization
    Y_pred[n] = normal_rng(mu, sigma[z[n]]);  // vectorization
  }
  
}


