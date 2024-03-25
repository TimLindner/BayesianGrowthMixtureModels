# closing the sections provides an overview of the script


# preparation ####
# set working directory
setwd("C:/Users/Diiim/Documents/ResearchAssistance")

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
m1_base <- stan_model("ModelImplementatation/Model1Baseline.stan")

job::job({
  
  fit_m1_base <- sampling(m1_base,
                          data = list(N = N,
                                      T = number_of_periods,
                                      Y_obs = Y_sim,
                                      p = p),
                          chains = 4,  # default
                          iter = 2000,  # default
                          warmup = floor(iter/2),  # default
                          init = "random",
                          algorithm = "NUTS")
  
  # save fit_m1_base
  saveRDS(fit_m1_base,
          "fit_m1_base.rds")
  
})


# model 1 multiple classes - estimation ####
# computation with NUTS in STAN
m1_mult <- stan_model("ModelImplementatation/Model1MultipleClasses.stan")

# number of latent classes
C <- 2

job::job({
  
  fit_m1_mult <- sampling(m1_mult,
                          data = list(N = N,
                                      T = number_of_periods,
                                      Y_obs = Y_sim,
                                      p = p,
                                      C = C),
                          chains = 4,  # default
                          iter = 2000,  # default
                          warmup = floor(iter/2),  # default
                          init = "random",
                          algorithm = "NUTS")
  
  # save fit_m1_mult
  saveRDS(fit_m1_mult,
          "fit_m1_mult.rds")
  
})


