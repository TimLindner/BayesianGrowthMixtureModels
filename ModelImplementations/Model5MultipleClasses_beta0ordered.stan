// README
// normal_rng(mu_n, sigma[Z[n]]) returns a one-dimensional array of reals. thus,
// Y_pred is declared as a two-dimensional array of reals.

// data structures are best traversed in the order in which they are stored; a
// two-dimensional array is stored in row-major order. thus, Y_pred is traversed
// in row-major order.

// if indexing of row vectors is needed, it is best to declare an array of row
// vectors. thus, X is declared as an one-dimensional array of row vectors.


data {
  
  // number of latent classes
  int<lower=2> C;
  
  // number of individuals
  int<lower=2> N;
  
  // number of time periods
  int<lower=2> T;
  
  // observed dependent variable (simulated or actual data)
  array[N,T] real Y_obs;
  
  // explanatory variable
  array[N] row_vector[T] X;
  
  // hyperparameters for Dirichlet prior of transition matrix
  array[C] vector[C] A_Psi;
  
  // mean hyperparameters for Normal prior of constants
  vector[C] mu_beta_0;
  
  // SD hyperparameters for Normal prior of constants
  vector<lower=0>[C] sigma_beta_0;
  
  // mean hyperparameters for Normal prior of linear trend components
  vector[C] mu_beta_1;
  
  // SD hyperparameters for Normal prior of linear trend components
  vector<lower=0>[C] sigma_beta_1;
  
  // SD hyperparameters for Normal prior of SDs for Y Normal distributions
  vector<lower=0>[C] sigma_sigma;
  
}


transformed data {
  
  // hyperparameters for Dirichlet prior of initial mixture proportions
  vector<lower=0>[C] alpha_omega;
  alpha_omega = rep_vector(1, C);
  
}


parameters {
  
  // initial mixture proportions
  simplex[C] omega;
  
  // transition matrix
  array[C] simplex[C] Psi;
  
  // constants
  ordered[C] beta_0;
  
  // linear trend components
  row_vector[C] beta_1;
  
  // standard deviations for Y Normal distributions
  row_vector<lower=0>[C] sigma;
  
}


transformed parameters {
  
  // mixture proportions
  array[T] simplex[C] Lambda;
  Lambda[1] = omega;
  for (t in 2:T) {
    for (c in 1:C) {
      Lambda[t,c] = Lambda[t-1,1] * Psi[1,c];
      for (k in 2:C) {
        Lambda[t,c] = Lambda[t,c] + Lambda[t-1,k] * Psi[k,c];
      }
    }
  }
  
  // log transform Lambda
  array[T] vector[C] log_Lambda;
  for (t in 1:T) {
    log_Lambda[t] = log(Lambda[t]);  # vectorization over c
  }
  
  // log likelihood
  array[N,T] vector[C] L;
  for (n in 1:N) {
    for (t in 1:T) {
      L[n,t] = log_Lambda[t];
      for (c in 1:C) {
        real mu; // mean for Y_obs Normal distribution
        mu = beta_0[c] + beta_1[c] * X[n,t];
        L[n,t,c] += normal_lpdf(Y_obs[n,t] | mu, sigma[c]);
      }
    }
  }
  
}


model {
  
  // prior for omega
  omega ~ dirichlet(alpha_omega);  // vectorization over c
  
  // prior for Psi
  Psi ~ dirichlet(A_Psi);  // vectorization over c
  
  // prior for beta_0
  beta_0 ~ normal(mu_beta_0, sigma_beta_0);  // vectorization over c
  
  // prior for beta_1
  beta_1 ~ normal(mu_beta_1, sigma_beta_1);  // vectorization over c
  
  // prior for sigma
  sigma ~ normal(0, sigma_sigma);  // vectorization over c
  
  // log likelihood
  for (n in 1:N) {
    for (t in 1:T) {
      target += log_sum_exp(L[n,t]);
    }
  }
  
}


generated quantities {
  
  // class memberships
  array[N,T] int Z;
  for (n in 1:N) {
    for (t in 1:T) {
      Z[n,t] = categorical_logit_rng(L[n,t]);
    }
  }
  
  // predicted dependent variable
  array[N,T] real Y_pred;
  for (n in 1:N) {
    row_vector[T] beta_0_n; // constants for n
    row_vector[T] beta_1_n; // linear trend components for n
    for (t in 1:T) {
      beta_0_n[t] = beta_0[Z[n,t]];
      beta_1_n[t] = beta_1[Z[n,t]];
    }
    row_vector[T] mu;  // means for Y_pred Normal distributions
    mu = beta_0_n + beta_1_n .* X[n];  // vectorization over t
    Y_pred[n] = normal_rng(mu, sigma[Z[n]]);  // vectorization over t
  }
  
}


