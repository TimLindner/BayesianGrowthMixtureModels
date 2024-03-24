// characteristics of model 1.2 :

// one continuous dependent variable
// ( normally distributed ,
// errors are independent over all individuals and time periods , 
// homogeneity of variance )

// no explanatory variables

// linear trend
// ( non-stationary , deterministic )

// multiple latent classes ( aka sub-populations )

data {
  
  // number of individuals
  int N;
  
  // number of periods
  int T;
  
  // dependent variable observed
  matrix[N,T] Y_obs;
  
  // periods
  row_vector[T] period;
  
  // number of latent classes
  int C;
  
}


parameters {
  
  // constants
  vector[C] beta_0;
  
  // linear trends
  vector[C] beta_1;
  
  // standard deviation for Normal distributions
  vector<lower=0>[C] sigma;
  
  // probability that individual n belongs to class c
  array[N] simplex[C] phi;
  
}


transformed parameters {
  
  // means for Normal distributions
  matrix[C,T] MU;
  for (c in 1:C) {
    MU[c] = beta_0[c] + beta_1[c] * period;
  }
  
  // log transformation for phi
  array[N] simplex[C] log_phi;
  for (n in 1:N) {
    log_phi[n] = log(phi[n]);
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
    lps = log_phi[n];
    for (t in 1:T) {
      for (c in 1:C) {
        lp[c] += normal_lpdf(Y_obs[n,t] | MU[c,t], sigma[c]);
      }
    }
    target += log_sum_exp(lp);
  }
  
}


generated quantities {
  
  // dependent variable simulated
  matrix[N,T] Y_sim;
  
  // simulations
  // tbd
  
}


