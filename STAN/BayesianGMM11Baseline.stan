// characteristics of model 1.1 baseline :

// one continuous dependent variable
// ( normally distributed ,
// errors are independent over all individuals and time periods , 
// homogeneity of variance )

// no explanatory variables

// linear trend
// ( non-stationary , deterministic )

// baseline, i.e., one latent class ( aka population )

data {
  
  // number of individuals
  int N;
  
  // number of periods
  int T;
  
  // dependent variable observed
  matrix[N,T] Y_obs;
  
  // periods
  row_vector[T] period;
  
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
  row_vector[T] mu;
  mu = beta_0 + beta_1 * period;
  
}


model {
  
  // prior for beta_0
  beta_0 ~ normal(0,1);
  
  // prior for beta_1
  beta_1 ~ normal(0,1);
  
  // prior for sigma
  sigma ~ normal(0,1);
  
  // likelihood function
  for (n in 1:N) {
    for (t in 1:T) {
      Y_obs[n,t] ~ normal(mu[t],sigma);
    }
  }
  
}


generated quantities {
  
  // dependent variable simulated
  matrix[N,T] Y_sim;
  
  // simulations
  for (n in 1:N) {
    for (t in 1:T) {
      Y_sim[n,t] = normal_rng(mu[t],sigma);
    }
  }
  
}


