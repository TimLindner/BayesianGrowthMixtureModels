// README
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
  alpha_lambda = rep_vector(1,C);
  
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
    L[n] = log(lambda);  // log transform lambda, vectorization over c
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
  beta_0 ~ normal(mu_beta_0,sigma_beta_0);  // vectorization over c
  
  // prior for beta_1
  beta_1 ~ normal(mu_beta_1,sigma_beta_1);  // vectorization over c
  
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


