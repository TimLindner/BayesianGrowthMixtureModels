data {
  
  // number of individuals
  int N;
  
  // number of time periods
  int T;
  
  // observed dependent variable ( simulated or actual data )
  array[T] vector[N] Y_obs;
  
  // time periods
  array[T] vector[N] X;
  
  // number of latent classes
  int C;
  
  // alpha parameter for Dirichlet distributions,
  // which serve as prior distributions for mixture proportions
  vector[C] alpha;
  
}



parameters {
  
  // constants
  row_vector[C] beta_0;
  
  // linear trends
  row_vector[C] beta_1;
  
  // standard deviations for Normal distributions
  row_vector<lower=0>[C] sigma;
  
  // mixture proportions
  array[N] simplex[C] Pi;
  
}


transformed parameters {
  
  // means for Normal distributions
  array[T,C] vector[N] M;
  for (t in 1:T) {
    for (c in 1:C) {
      M[t,c] = beta_0[c] + beta_1[c] * X[t];
    }
  }
  
  // transpose Pi
  array[C] vector[N] Pi_transp;
  for (c in 1:C) {
    for (n in 1:N) {
      Pi_transp[c,n] = Pi[n,c];
    }
  }
  
  // log transform Pi_transp
  array[C] vector[N] Pi_log;
  for (c in 1:C) {
    Pi_log[c] = log(Pi_transp[c]);
  }
  
  
}


model {
  
  // prior distributions for beta_0
  beta_0 ~ normal(0,5);
  
  // prior distributions for beta_1
  beta_1 ~ normal(0,1);
  
  // prior distributions for sigma
  sigma ~ normal(0,1);
  
  // prior distributions for Pi
  Pi ~ dirichlet(alpha);
  
  // likelihood function step 1
  array[T] matrix[N,C] lp;  // log posterior
  for (t in 1:T) {
    for (c in 1:C) {
      lp[t,,c] = Pi_log[c] + normal_lpdf(Y_obs[t] | M[t,c], sigma[c]);
    }
  }
  
  // likelihood function step 2
  for (t in 1:T) {
    for (n in 1:N) {
      target += log_sum_exp(lp[t,n]);
    }
  }
  
}


generated quantities {
  
  // temp variables
  array[N] real temp_arr;
  vector[N] temp_vec;
  
  // predicted dependent variable
  array[T] vector[N] Y_pred;
  for (t in 1:T) {
    for (c in 1:C) {
      temp_arr = normal_rng(M[t,c],sigma[c]);
      temp_vec = to_vector(temp_arr);  // transform temp_arr to column vector
      Y_pred[t] += Pi_transp[c] + temp_vec;
    }
  }
  
}


