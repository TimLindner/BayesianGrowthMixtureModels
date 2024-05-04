// README
// poisson_log_rng(theta_n) returns a one-dimensional array of ints. thus, Y_obs
// is declared as a two-dimensional array of ints.

// data structures are best traversed in the order in which they are stored; a
// two-dimensional array is stored in row-major order. thus, Y_pred is traversed
// in row-major order.

// if indexing of row vectors is needed, it is best to declare an array of row
// vectors. thus, X is declared as an one-dimensional array of row vectors.


data {
  
  // number of latent classes
  int<lower=2> C;
  
  // number of individuals
  int<lower=2> N;
  
  // number of time periods
  int<lower=2> T;
  
  // explanatory variable
  array[N] row_vector[T] X;
  
  // simulated mixture proportions
  simplex[C] lambda_sim;
  
  // simulated constants
  row_vector[C] beta_0_sim;
  
  // simulated linear trend components
  row_vector[C] beta_1_sim;
  
  
  
}


generated quantities {
  
  // simulated class memberships
  array[N] int z_sim;
  for (n in 1:N) {
    z_sim[n] = categorical_rng(lambda_sim);
  }
  
  // observed dependent variable
  array[N,T] int Y_obs;
  for (n in 1:N) {
    // log rates for Y_obs PoissonLog distributions of n
    row_vector[T] theta_n;
    theta_n = beta_0_sim[z_sim[n]] + beta_1_sim[z_sim[n]] * X[n];
    // vectorization over t
    
    Y_obs[n] = poisson_log_rng(theta_n);  // vectorization over t
  }
  
}


