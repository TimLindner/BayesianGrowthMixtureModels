data {
  
  // number of individuals
  int N;
  
  // number of time periods
  int T;
  
  // observed dependent variable ( simulated or actual data )
  matrix[N,T] Y_obs;
  
  // time periods
  matrix[N,T] x_vec;
  
}


transformed data {
  
  // size of Y_obs
  int Y_obs_size;
  Y_obs_size = size(Y_obs);
  
  // transform Y_obs to column vector in column-major order
  vector[Y_obs_size] y_obs_vec;
  y_obs_vec = to_vector(Y_obs);
  
  // transform X to column vector in column-major order
  vector[Y_obs_size] x_vec;
  x_vec = to_vector(X);
  
}


parameters {
  
  // constant
  real beta_0;
  
  // linear trend
  real beta_1;
  
  // standard deviation for Normal distributions
  real<lower=0> sigma;
  
}


transformed parameters {
  
  // means for Normal distributions
  vector[Y_obs_size] mu;
  mu = beta_0 + beta_1 * x_vec;
  
}


model {
  
  // prior distribution for beta_0
  beta_0 ~ normal(0,1);
  
  // prior distribution for beta_1
  beta_1 ~ normal(0,1);
  
  // prior distribution for sigma
  sigma ~ normal(0,1);
  
  // likelihood function
  y_obs_vec ~ normal(mu,sigma);
  
}


generated quantities {
  
  // predicted dependent variable
  array[Y_obs_size] real y_pred;
  
  // prediction
  y_pred = normal_rng(mu,sigma);
  
}


