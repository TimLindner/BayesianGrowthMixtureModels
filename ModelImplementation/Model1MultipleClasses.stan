data {
  
  // number of individuals
  int N;
  
  // number of time periods
  int T;
  
  // observed dependent variable ( simulated or actual data )
  matrix[N,T] Y_obs;
  
  // time periods
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
  matrix<lower=0,upper=1>[N,C] Pi;
  
}


transformed parameters {
  
  // means for Normal distributions
  matrix[C,T] MU;
  for (c in 1:C) {
    MU[c] = beta_0[c] + beta_1[c] * p;
  }
  
  // log transformation for phi
  matrix[N,C] log_Pi;
  for (n in 1:N) {
    for (c in 1:C) {
     log_Pi[n,c] = log(Pi[n,c]); 
    }
  }
  
}


model {
  
  // prior distributions for beta_0
  beta_0 ~ normal(0,1);
  
  // prior distributions for beta_1
  beta_1 ~ normal(0,1);
  
  // prior distributions for sigma
  sigma ~ normal(0,1);
  
  // prior distributions for Pi
  for (n in 1:N) {
    Pi[n,1] ~ uniform(0,1);
    for (c in 2:C) {
      Pi[n,c] ~ uniform(0,Pi[n,c-1]);
    }
  }
  
  // likelihood function
  row_vector[C] lp;
  for (n in 1:N) {
    for (t in 1:T) {
      lp = log_Pi[n];
      for (c in 1:C) {
        lp[c] += normal_lpdf(Y_obs[n,t] | MU[c,t], sigma[c]);
      }
      target += log_sum_exp(lp);
    }
  }
  
}


generated quantities {
  
  // predicted dependent variable
  matrix[N,T] Y_pred;
  
  // simulations
  for (n in 1:N) {
    for (t in 1:T) {
      for (c in 1:C) {
        Y_pred[n,t] += Pi[n,c] * normal_rng(MU[c,t], sigma[c]);
      }
    }
  }
  
}


