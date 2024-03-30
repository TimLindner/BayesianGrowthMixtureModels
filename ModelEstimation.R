# closing the sections provides an overview of the script


# preparation ####
# set working directory
setwd("C:/Users/Diiim/Documents/ResearchAssistance")

# clean workspace
# uncomment next line to run the line
# rm(list = ls())

# clean garbage
# uncomment next line to run the line
# gc()

# set decimals to digits instead of scientific
options(scipen = 999)

# load packages
library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)


# NUTS parameters ####
algorithm <- "NUTS"
chains <- 4  # default
iter <- 2000  # default
warmup <- floor(iter/2)  # default


# model 1 baseline - estimation ####
# computation with NUTS in STAN
m1_base <- stan_model("ModelImplementation/Model1Baseline.stan")

# model-specific NUTS parameter
init <- "random"

job::job({
  
  fit_m1_base <- sampling(m1_base,
                          data = list(N = N,
                                      T = no_periods,
                                      Y_obs = Y_sim,
                                      X = X),
                          chains = chains,
                          iter = iter,
                          warmup = warmup,
                          init = init,
                          algorithm = algorithm)
  
  # save fit_m1_base
  saveRDS(fit_m1_base,
          "SimulationStudyResults/Fit_Model1Baseline.rds")
  
})


# model 1 multiple classes - estimation ####
# computation with NUTS in STAN
m1_mult <- stan_model("ModelImplementation/Model1MultipleClasses.stan")

# number of latent classes
C <- 2

# model-specific NUTS parameter
init <- "random"

# alpha parameter for Dirichlet pdfs,
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
                          chains = chains,
                          iter = iter,
                          warmup = warmup,
                          init = init,
                          algorithm = algorithm)
  
  # save fit_m1_mult
  saveRDS(fit_m1_mult,
          "SimulationStudyResults/Fit_Model1TwoClasses.rds")
  
})


