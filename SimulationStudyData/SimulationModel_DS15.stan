data {
  
  // number of individuals
  int<lower=2> N;
  
  // number of time periods
  int<lower=2> T;
  
  // time periods
  matrix[N,T] X;
  
  // simulated constant
  real beta_0_sim;
  
  // simulated linear trend component
  real beta_1_sim;
  
  
  
}


generated quantities {
  
  // observed dependent variable
  array[N,T] int Y_obs;
  for (n in 1:N) {
    row_vector[T] theta;  // log rates for Y_obs PoissonLog distributions
    theta = beta_0_sim + beta_1_sim * X[n];
    // vectorization
    
    Y_obs[n] = poisson_log_rng(theta);  // vectorization
  }
  
}


