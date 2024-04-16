data {
  
  // number of latent classes
  int<lower=2> C;
  
  // number of individuals
  int<lower=2> N;
  
  // number of time periods
  int<lower=2> T;
  
  // time periods
  matrix[N,T] X;
  
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
    row_vector[T] theta;  // log rates for Y_obs PoissonLog distributions
    theta = beta_0_sim[z_sim[n]] + beta_1_sim[z_sim[n]] * X[n];
    // vectorization
    
    Y_obs[n] = poisson_log_rng(theta);  // vectorization
  }
  
}


