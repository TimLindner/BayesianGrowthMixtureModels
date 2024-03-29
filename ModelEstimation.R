# closing the sections provides an overview of the script


# preparation ####
# set working directory
setwd("C:/Users/Diiim/Documents/ResearchAssistance/ModelImplementation")

# clean workspace
rm(list = ls())

# clean garbage
gc()

# set decimals to digits instead of scientific
options(scipen = 999)

# load packages
library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)


# model 1 baseline - estimation ####
# computation with NUTS in STAN
m1_base <- stan_model("Model1Baseline.stan")

job::job({
  
  fit_m1_base <- sampling(m1_base,
                          data = list(N = N,
                                      T = no_periods,
                                      Y_obs = Y_sim,
                                      X = X),
                          chains = 4,  # default
                          iter = 2000,  # default
                          warmup = floor(iter/2),  # default
                          init = "random",
                          algorithm = "NUTS")
  
  # save fit_m1_base
  saveRDS(fit_m1_base,
          "Fit_Model1Baseline.rds")
  
})


# model 1 multiple classes - estimation ####
# computation with NUTS in STAN
m1_mult <- stan_model("Model1MultipleClasses.stan")

# number of latent classes
C <- 2

# alpha parameter for Dirichlet distributions,
# which serve as prior distributions for mixture proportions
alpha <- rep(3, times = C)

job::job({
  
  fit_m1_mult <- sampling(m1_mult,
                          data = list(N = N,
                                      T = no_periods,
                                      Y_obs = Y_sim,
                                      X = X,
                                      C = C,
                                      alpha = alpha),
                          chains = 4,  # default
                          iter = 2000,  # default
                          warmup = floor(iter/2),  # default
                          init = "random",
                          algorithm = "NUTS")
  
  # save fit_m1_mult
  saveRDS(fit_m1_mult,
          "Fit_Model1TwoClasses.rds")
  
})


