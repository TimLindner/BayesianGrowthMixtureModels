data {
  
  // number of individuals
  int<lower=2> N;
  
  // number of time periods
  int<lower=2> T;
  
  // observed dependent variable ( simulated or actual data )
  matrix[N,T] Y_obs;
  
  // time periods
  matrix[N,T] X;
  
  // mean hyperparameter for Normal prior of constant
  real beta_0_prior_mu;
  
  // SD hyperparameter for Normal prior of constant
  real<lower=0> beta_0_prior_sigma;
  
  // mean hyperparameter for Normal prior of linear trend component
  real beta_1_prior_mu;
  
  // SD hyperparameter for Normal prior of linear trend component
  real<lower=0> beta_1_prior_sigma;
  
  // SD hyperparameter for Normal prior of SD for Y Normal distributions
  real<lower=0> sigma_prior_sigma;
  
}


parameters {
  
  // constant
  real beta_0;
  
  // linear trend component
  real beta_1;
  
  // standard deviation for Y Normal distributions
  real<lower=0> sigma;
  
}


model {
  
  // prior for beta_0
  beta_0 ~ normal(beta_0_prior_mu,beta_0_prior_sigma);
  
  // prior for beta_1
  beta_1 ~ normal(beta_1_prior_mu,beta_1_prior_sigma);
  
  // prior for sigma
  sigma ~ normal(0,sigma_prior_sigma);
  
  // means for Y_obs Normal distributions
  vector[N] mu;
  
  // likelihood
  for (t in 1:T) {
    mu = beta_0 + beta_1 * col(X,t);  // vectorization
    Y_obs[,t] ~ normal(mu,sigma);  // vectorization
  }
  
}


generated quantities {
  
  // predicted dependent variable
  array[N,T] real Y_pred;
  for (n in 1:N) {
    row_vector[T] mu;  // means for Y_pred Normal distributions
    mu = beta_0 + beta_1 * X[n];  // vectorization
    Y_pred[n] = normal_rng(mu, sigma);  // vectorization
  }
  
}


