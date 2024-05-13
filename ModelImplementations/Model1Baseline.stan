// README
// normal_rng(M[n], sigma) returns a one-dimensional array of reals. thus,
// Y_pred is declared as a two-dimensional array of reals.

// data structures are best traversed in the order in which they are stored; a
// two-dimensional array is stored in row-major order. thus, Y_pred is traversed
// in row-major order.

// if indexing of row vectors is needed, it is best to declare an array of row
// vectors. thus, Y_obs, X, and M are declared as one-dimensional arrays of row
// vectors.


data {
  
  // number of individuals
  int<lower=1> N;
  
  // number of time periods
  int<lower=2> T;
  
  // observed dependent variable
  array[N] row_vector[T] Y_obs;
  
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
  
  // SD hyperparameter for Normal prior of SD for Y Normal distributions
  real<lower=0> sigma_sigma;
  
}


parameters {
  
  // constant
  real beta_0;
  
  // linear trend component
  real beta_1;
  
  // standard deviation for Y Normal distributions
  real<lower=0> sigma;
  
}


transformed parameters {
  
  // means for Y Normal distributions
  array[N] row_vector[T] M;
  for (n in 1:N) {
    M[n] = beta_0 + beta_1 * X[n];  // vectorization over t
  }
  
}


model {
  
  // prior for beta_0
  beta_0 ~ normal(mu_beta_0, sigma_beta_0);
  
  // prior for beta_1
  beta_1 ~ normal(mu_beta_1, sigma_beta_1);
  
  // prior for sigma
  sigma ~ normal(0, sigma_sigma);
  
  // likelihood
  for (n in 1:N) {
    Y_obs[n] ~ normal(M[n], sigma);  // vectorization over t
  }
  
}


generated quantities {
  
  // predicted dependent variable
  array[N,T] real Y_pred;
  for (n in 1:N) {
    Y_pred[n] = normal_rng(M[n], sigma);  // vectorization over t
  }
  
}


