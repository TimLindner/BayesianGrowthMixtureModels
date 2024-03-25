data {
  
  // number of individuals
  int N;
  
  // number of periods
  int T;
  
  // observed dependent variable
  matrix[N,T] Y_obs;
  
  // periods
  row_vector[T] p;
  
  // number of latent classes
  int C;
  
}


parameters {
  
  // constants
  vector[C] beta_0;
  
  // linear trends
  vector[C] beta_1;
  
  // standard deviations for Normal distributions
  vector<lower=0>[C] sigma;
  
  // mixture proportions
  array[N] simplex[C] Pi;
  
}


transformed parameters {
  
  // means for Normal distributions
  matrix[C,T] MU;
  for (c in 1:C) {
    MU[c] = beta_0[c] + beta_1[c] * p;
  }
  
  // log transformation for phi
  array[N] simplex[C] log_Pi;
  for (n in 1:N) {
    log_Pi[n] = log(Pi[n]);
  }
  
}


model {
  
  // prior for beta_0
  beta_0 ~ normal(0,1);
  
  // prior for beta_1
  beta_1 ~ normal(0,1);
  
  // prior for sigma
  sigma ~ normal(0,1);
  
  // prior for phi
  // flat , proper
  
  // likelihood function
  vector[C] lp;
  for (n in 1:N) {
    lps = log_Pi[n];
    for (t in 1:T) {
      for (c in 1:C) {
        lp[c] += normal_lpdf(Y_obs[n,t] | MU[c,t], sigma[c]);
      }
    }
    target += log_sum_exp(lp);
  }
  
}


generated quantities {
  
  // predicted dependent variable
  matrix[N,T] Y_pred;
  
  // simulations
  // tbd
  
}


