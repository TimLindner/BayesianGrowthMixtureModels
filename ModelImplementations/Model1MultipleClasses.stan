// README
// a note on the Stan code:
// data structures are best traversed in the order in which they are stored.
// in Stan, matrices store their data in column-major order, and
// arrays store their data in row-major order.

// a note on the Stan code:
// the result of a vectorized log probability density function
// is equivalent to the sum of the evaluations on each element;
// e.g., real normal_lpdf(reals y | reals mu, real sigma).


data {
  
  // number of latent classes
  int<lower=2> C;
  
  // number of individuals
  int<lower=2> N;
  
  // number of time periods
  int<lower=2> T;
  
  // observed dependent variable ( simulated or actual data )
  matrix[N,T] Y_obs;
  
  // time periods
  matrix[N,T] X;
  
  // mean hyperparameters for Normal prior of constants
  vector<lower=0>[C] beta_0_prior_mu;
  
  // SD hyperparameters for Normal prior of constants
  vector<lower=0>[C] beta_0_prior_sigma;
  
  // mean hyperparameters for Normal prior of linear trend components
  vector<lower=0>[C] beta_1_prior_mu;
  
  // SD hyperparameters for Normal prior of linear trend components
  vector<lower=0>[C] beta_1_prior_sigma;
  
  // SD hyperparameters for Normal prior of SDs for Y Normal distributions
  vector<lower=0>[C] sigma_prior_sigma;
  
}


transformed data {
  
  // hyperparameter for Dirichlet prior of mixture proportions
  vector<lower=0>[C] alpha;
  alpha = rep_vector(1,C);
  
}


parameters {
  
  // mixture proportions
  simplex[C] lambda;
  
  // constants
  row_vector[C] beta_0;
  
  // linear trend components
  ordered[C] beta_1;
  
  // standard deviations for Y Normal distributions
  row_vector<lower=0>[C] sigma;
  
}


transformed parameters {
  
  // log likelihood
  array[N] vector[C] L;
  for (n in 1:N) {
    L[n] = log(lambda);  // log transform lambda, vectorization
    for (c in 1:C) {
      row_vector[T] mu;  // means for Y_obs Normal distributions
      mu = beta_0[c] + beta_1[c] * X[n];  // vectorization
      L[n,c] += normal_lpdf(Y_obs[n] | mu, sigma[c]);  // vectorization
    }
  }
  
}


model {
  
  // prior for lambda
  lambda ~ dirichlet(alpha);  // vectorization
  
  // prior for beta_0
  beta_0 ~ normal(beta_0_prior_mu,beta_0_prior_sigma);  // vectorization
  
  // prior for beta_1
  beta_1 ~ normal(beta_1_prior_mu,beta_1_prior_sigma);  // vectorization
  
  // prior for sigma
  sigma ~ normal(0,sigma_prior_sigma);  // vectorization
  
  // log likelihood
  for (n in 1:N) {
    target += log_sum_exp(L[n]);
  }
  
}


generated quantities {
  
  // class memberships
  array[N] int z;
  for (n in 1:N) {
    z[n] = categorical_logit_rng(L[n]);
  }
  
  // predicted dependent variable
  array[N,T] real Y_pred;
  for (n in 1:N) {
    row_vector[T] mu;  // means for Y_pred Normal distributions
    mu = beta_0[z[n]] + beta_1[z[n]] * X[n];  // vectorization
    Y_pred[n] = normal_rng(mu, sigma[z[n]]);  // vectorization
  }
  
}


