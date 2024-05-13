// README
// poisson_log_rng(theta) returns a one-dimensional array of ints. thus, Y_pred
// is declared as a two-dimensional array of ints.

// data structures are best traversed in the order in which they are stored; a
// two-dimensional array is stored in row-major order. thus, Y_pred is traversed
// in row-major order.

// if indexing of row vectors is needed, it is best to declare an array of row
// vectors. thus, X is declared as an one-dimensional array of row vectors.
// however, since vectors cannot be constrained to containing ints only, Y_obs
// is declared as a two-dimensional array of ints.


data {
  
  // number of individuals
  int<lower=1> N;
  
  // number of time periods
  int<lower=2> T;
  
  // observed dependent variable
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


transformed parameters {
  
  // log rates for Y PoissonLog distributions
  array[N] row_vector[T] Theta;
  for (n in 1:N) {
    Theta[n] = beta_0 + beta_1 * X[n];  // vectorization over t
  }
  
}


model {
  
  // prior for beta_0
  beta_0 ~ normal(mu_beta_0, sigma_beta_0);
  
  // prior for beta_1
  beta_1 ~ normal(mu_beta_1, sigma_beta_1);
  
  // likelihood
  for (n in 1:N) {
    Y_obs[n] ~ poisson_log(Theta[n]);  // vectorization over t
  }
  
}


generated quantities {
  
  // predicted dependent variable
  array[N,T] int Y_pred;
  for (n in 1:N) {
    Y_pred[n] = poisson_log_rng(Theta[n]);  // vectorization over t
  }
  
}


