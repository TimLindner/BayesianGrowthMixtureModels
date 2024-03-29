data {
  
  // number of individuals
  int N;
  
  // number of time periods
  int T;
  
  // observed dependent variable ( simulated or actual data )
  array[T] vector[N] Y_obs;
  
  // time periods
  array[T] vector[N] X;
  
}


parameters {
  
  // constant
  real beta_0;
  
  // linear trend
  real beta_1;
  
  // standard deviation for Normal pdfs
  real<lower=0> sigma;
  
}


transformed parameters {
  
  // means for Normal pdfs
  array[T] vector[N] M;
  for (t in 1:T) {
    M[t] = beta_0 + beta_1 * X[t];
  }
  
}


model {
  
  // prior for beta_0
  beta_0 ~ normal(0,5);
  
  // prior for beta_1
  beta_1 ~ normal(0,1);
  
  // prior for sigma
  sigma ~ normal(0,1);
  
  // likelihood
  for (t in 1:T) {
    Y_obs[t] ~ normal(M[t],sigma);
  }
  
}


generated quantities {
  
  // predicted dependent variable
  array[N,T] real Y_pred;
  for (t in 1:T) {
    Y_pred[,t] = normal_rng(M[t], sigma);
  }
  
}


