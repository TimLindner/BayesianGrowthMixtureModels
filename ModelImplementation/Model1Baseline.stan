data {
  
  // number of individuals
  int N;
  
  // number of time periods
  int T;
  
  // observed dependent variable ( simulated or actual data )
  matrix[N,T] Y_obs;
  
  // time periods
  matrix[N,T] X;
  
}


parameters {
  
  // constant
  real beta_0;
  
  // linear trend component
  real beta_1;
  
  // standard deviation for Normal pdfs
  real<lower=0> sigma;
  
}


transformed parameters {
  
  // means for Normal pdfs
  matrix[N,T] M;
  for (t in 1:T) {
    for (n in 1:N) {
      M[n,t] = beta_0 + beta_1 * X[n,t];
    }
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
    for (n in 1:N) {
      Y_obs[n,t] ~ normal(M[n,t],sigma);
    }
  }
  
}


generated quantities {
  
  // predicted dependent variable
  matrix[N,T] Y_pred;
  for (t in 1:T) {
    for (n in 1:N) {
      Y_pred[n,t] = normal_rng(M[n,t], sigma);
    }
  }
  
}


