// README
// a note on the Stan code:
// data structures are best traversed in the order in which they are stored.
// in Stan, matrices store their data in column-major order, and
// arrays store their data in row-major order.

// a note on the Stan code:
// the result of a vectorized log probability mass function
// is equivalent to the sum of the evaluations on each element;
// e.g., real poisson_log_lpmf(ints y_obs | reals theta).


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
  
  // mean hyperparameters for Normal prior of constants
  vector[C] beta_0_prior_mu;
  
  // SD hyperparameters for Normal prior of constants
  vector<lower=0>[C] beta_0_prior_sigma;
  
  // mean hyperparameters for Normal prior of linear trend components
  vector[C] beta_1_prior_mu;
  
  // SD hyperparameters for Normal prior of linear trend components
  vector<lower=0>[C] beta_1_prior_sigma;
  
}


transformed data {
  
  // hyperparameter for Dirichlet prior of mixture proportions
  vector<lower=0>[C] alpha;
  alpha = rep_vector(1,C);
  
}


parameters {
  
  // mixture proportions
  simplex[C] lambda;
  
  // constants
  ordered[C] beta_0;
  
  // linear trend components
  row_vector[C] beta_1;
  
}


transformed parameters {
  
  // log likelihood
  array[N] vector[C] L;
  for (n in 1:N) {
    L[n] = log(lambda);  // log transform lambda, vectorization
    for (c in 1:C) {
      row_vector[T] theta;  // log rates for Y_obs Normal distributions
      mu = beta_0[c] + beta_1[c] * X[n];  // vectorization
      L[n,c] += poisson_log_lpmf(Y_obs[n] | theta);  // vectorization
    }
  }
  
}


model {
  
  // prior for lambda
  lambda ~ dirichlet(alpha);  // vectorization
  
  // prior for beta_0
  beta_0 ~ normal(beta_0_prior_mu,beta_0_prior_sigma);  // vectorization
  
  // prior for beta_1
  beta_1 ~ normal(beta_1_prior_mu,beta_1_prior_sigma);  // vectorization
  
  // log likelihood
  for (n in 1:N) {
    target += log_sum_exp(L[n]);
  }
  
}


generated quantities {
  
  // class memberships
  array[N] int z;
  for (n in 1:N) {
    z[n] = categorical_logit_rng(L[n]);
  }
  
  // predicted dependent variable
  array[N,T] int Y_pred;
  for (n in 1:N) {
    row_vector[T] mu;  // log rates for Y_pred Normal distributions
    mu = beta_0[z[n]] + beta_1[z[n]] * X[n];  // vectorization
    Y_pred[n] = poisson_log_rng(theta);  // vectorization
  }
  
}


