// README
// data structures are best traversed in the order in which they are stored.
// matrices store their data in column-major order.
// arrays store their data in row-major order.


data {
  
  // number of individuals
  int<lower=2> N;
  
  // number of time periods
  int<lower=2> T;
  
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
  
  // standard deviation for Y_obs Normal distributions
  real<lower=0> sigma;
  
}


transformed parameters {
  
  // means for Y_obs Normal distributions
  matrix[N,T] M;
  for (t in 1:T) {
    M[,t] = beta_0 + beta_1 * col(X,t);  // vectorization
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
    Y_obs[,t] ~ normal(col(M,t),sigma);  // vectorization
  }
  
}


generated quantities {
  
  // predicted dependent variable
  array[N,T] real Y_pred;
  for (n in 1:N) {
    Y_pred[n] = normal_rng(M[n], sigma);  // vectorization
  }
  
}


