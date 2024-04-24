data {
  
  // number of individuals
  int<lower=1> N;
  
  // number of time periods
  int<lower=2> T;
  
  // observed dependent variable (simulated or actual data)
  array[N,T] int<lower=0> Y_obs;
  
  // explanatory variable
  array[N] row_vector[T] X;
  
  // mean hyperparameter for Normal prior of constant
  real mu_beta_0;
  
  // SD hyperparameter for Normal prior of constant
  real<lower=0> sigma_beta_0;
  
  // mean hyperparameter for Normal prior of linear trend component
  real mu_beta_1;
  
  // SD hyperparameter for Normal prior of linear trend component
  real<lower=0> sigma_beta_1;
  
}


parameters {
  
  // constant
  real beta_0;
  
  // linear trend component
  real beta_1;
  
}


model {
  
  // prior for beta_0
  beta_0 ~ normal(mu_beta_0,sigma_beta_0);
  
  // prior for beta_1
  beta_1 ~ normal(mu_beta_1,sigma_beta_1);
  
  // log rates for Y_obs PoissonLog distributions
  row_vector[N] theta;
  
  // likelihood
  for (n in 1:N) {
    theta = beta_0 + beta_1 * X[n];  // vectorization over t
    Y_obs[n] ~ poisson_log(theta);  // vectorization over t
  }
  
}


generated quantities {
  
  // predicted dependent variable
  array[N,T] int Y_pred;
  for (n in 1:N) {
    row_vector[T] theta;  // log rates for Y_pred PoissonLog distributions
    theta = beta_0 + beta_1 * X[n];  // vectorization over t
    Y_pred[n] = poisson_log_rng(theta);  // vectorization over t
  }
  
}


