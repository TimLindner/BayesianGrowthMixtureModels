// README
// normal_rng(mu, sigma) returns a one-dimensional array of reals. thus, Y_pred
// is declared as a two-dimensional array of reals.

// data structures are best traversed in the order in which they are stored; a
// two-dimensional array is stored in row-major order. thus, Y_pred is traversed
// in row-major order.

// if indexing of row vectors is needed, it is best to declare an array of row
// vectors. thus, Y_obs and X are declared as an one-dimensional array of row
// vectors.

// the result of a vectorized log probability mass function is equivalent to the
// sum of the evaluations on each element. thus,
// normal_lpdf(Y_obs[n] | mu, sigma) returns a real.


data {
  
  // number of latent classes
  int<lower=2> C;
  
  // number of individuals
  int<lower=2> N;
  
  // number of time periods
  int<lower=2> T;
  
  // observed dependent variable (simulated or actual data)
  array[N] row_vector[T] Y_obs;
  
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
  
  // SD hyperparameter for Normal prior of SDs for Y Normal distributions
  real<lower=0> sigma_sigma;
  
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
  ordered[C] beta_0;
  
  // linear trend components
  row_vector[C] beta_1;
  
  // standard deviation for Y Normal distributions
  real<lower=0> sigma;
  
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
      row_vector[T] mu;  // means for Y_obs Normal distributions
      mu = beta_0[c] + beta_1[c] * X[n];  // vectorization over t
      L[n,c] += normal_lpdf(Y_obs[n] | mu, sigma);  // vectorization over t
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
  
  // prior for sigma
  sigma ~ normal(0, sigma_sigma);
  
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
  array[N,T] real Y_pred;
  for (n in 1:N) {
    row_vector[T] mu;  // means for Y_pred Normal distributions
    mu = beta_0[z[n]] + beta_1[z[n]] * X[n];  // vectorization over t
    Y_pred[n] = normal_rng(mu, sigma);  // vectorization over t
  }
  
}


