// README
// poisson_log_rng(theta_n) returns a one-dimensional array of ints. thus,
// Y_pred is declared as a two-dimensional array of ints.

// data structures are best traversed in the order in which they are stored; a
// two-dimensional array is stored in row-major order. thus, Y_pred is traversed
// in row-major order.

// if indexing of row vectors is needed, it is best to declare an array of row
// vectors. thus, X is declared as an one-dimensional array of row vectors.
// however, since vectors cannot be constrained to containing ints only, Y_obs
// is declared as a two-dimensional array of ints.

// the result of a vectorized log probability mass function is equivalent to the
// sum of the evaluations on each element. thus,
// poisson_log_lpmf(Y_obs[n] | theta_n) returns a real.


data {
  
  // number of latent classes
  int<lower=2> C;
  
  // number of individuals
  int<lower=2> N;
  
  // number of time periods
  int<lower=2> T;
  
  // observed dependent variable (simulated or actual data)
  array[N,T] int<lower=0> Y_obs;
  
  // explanatory variable
  array[N] row_vector[T] X;
  
  // mean hyperparameters for Normal prior of constants
  vector[C] mu_beta_0;
  
  // SD hyperparameters for Normal prior of constants
  vector<lower=0>[C] sigma_beta_0;
  
  // mean hyperparameters for Normal prior of linear trend components
  vector[C] mu_beta_1;
  
  // SD hyperparameters for Normal prior of linear trend components
  vector<lower=0>[C] sigma_beta_1;
  
}


transformed data {
  
  // hyperparameters for Dirichlet prior of mixture proportions
  vector<lower=0>[C] alpha_lambda;
  alpha_lambda = rep_vector(1, C);
  
}


parameters {
  
  // mixture proportions
  simplex[C] lambda;
  
  // constants
  row_vector[C] beta_0;
  
  // linear trend components
  ordered[C] beta_1;
  
}


transformed parameters {
  
  // log lambda
  vector[C] log_lambda;
  log_lambda = log(lambda);
  
  // log likelihood
  array[N] vector[C] L;
  for (n in 1:N) {
    L[n] = log_lambda;
    for (c in 1:C) {
      row_vector[T] theta;  // log rates for Y_obs PoissonLog distributions
      theta = beta_0[c] + beta_1[c] * X[n];  // vectorization over t
      L[n,c] += poisson_log_lpmf(Y_obs[n] | theta);  // vectorization over t
    }
  }
  
}


model {
  
  // prior for lambda
  lambda ~ dirichlet(alpha_lambda);  // vectorization over c
  
  // prior for beta_0
  beta_0 ~ normal(mu_beta_0, sigma_beta_0);  // vectorization over c
  
  // prior for beta_1
  beta_1 ~ normal(mu_beta_1, sigma_beta_1);  // vectorization over c
  
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
    row_vector[T] theta;  // log rates for Y_pred PoissonLog distributions
    theta = beta_0[z[n]] + beta_1[z[n]] * X[n];  // vectorization over t
    Y_pred[n] = poisson_log_rng(theta);  // vectorization over t
  }
  
}


