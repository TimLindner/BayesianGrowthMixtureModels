// README
// poisson_log_rng(theta_sim) returns a one-dimensional array of ints. thus,
// Y_obs is declared as a two-dimensional array of ints.

// data structures are best traversed in the order in which they are stored; a
// two-dimensional array is stored in row-major order. thus, Y_obs is traversed
// in row-major order.

// if indexing of row vectors is needed, it is best to declare an array of row
// vectors. thus, X is declared as an one-dimensional array of row vectors.


data {
  
  // number of individuals
  int<lower=1> N;
  
  // number of time periods
  int<lower=2> T;
  
  // explanatory variable
  array[N] row_vector[T] X;
  
  // simulated constant
  real beta_0_sim;
  
  // simulated linear trend component
  real beta_1_sim;
  
  
  
}


generated quantities {
  
  // observed dependent variable
  array[N,T] int Y_obs;
  for (n in 1:N) {
    // simulated log rates for Y_obs PoissonLog distributions
    row_vector[T] theta_sim;
    theta_sim = beta_0_sim + beta_1_sim * X[n];  // vectorization over t
    Y_obs[n] = poisson_log_rng(theta_sim);  // vectorization over t
  }
  
}


