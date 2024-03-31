data {
  
  // number of individuals
  int N;
  
  // number of time periods
  int T;
  
  // observed dependent variable ( simulated or actual data )
  matrix[N,T] Y_obs;
  
  // time periods
  matrix[N,T] X;
  
  // number of latent classes
  int C;
  
  // alpha parameter for Dirichlet pdfs,
  // which serve as prior distributions for mixture proportions
  vector[C] alpha;
  
}



parameters {
  
  // constants
  row_vector[C] beta_0;
  
  // linear trend components
  row_vector[C] beta_1;
  
  // standard deviations for Normal pdfs
  row_vector<lower=0>[C] sigma;
  
  // mixture proportions
  array[N] simplex[C] Pi;
  
}


transformed parameters {
  
  // means for Normal pdfs
  array[C] matrix[N,T] M;
  for (c in 1:C) {
    for (t in 1:T) {
      for (n in 1:N) {
        M[c,n,t] = beta_0[c] + beta_1[c] * X[n,t];
      }
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
  
  // prior for Pi
  Pi ~ dirichlet(alpha);
  
  // likelihood step 1
  vector[C] lp;  // log posterior
  for (t in 1:T) {
    for (n in 1:N) {
      lp = log(Pi[n]);  // log transform Pi
      for (c in 1:C) {
        lp += normal_lpdf(Y_obs[n,t] | M[c,n,t], sigma[c]);
      }
    }
    target += log_sum_exp(lp);
  }
  
}


generated quantities {
  
  // predicted dependent variable
  matrix[N,T] Y_pred;
  Y_pred = rep_matrix(0, N, T);
  for (c in 1:C) {
    for (t in 1:T) {
      for (n in 1:N) {
        Y_pred[n,t] += Pi[n,c] * normal_rng(M[c,n,t], sigma[c]);
      }
    }
  }
  
}

