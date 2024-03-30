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

# observed dependent variable
Y_obs <- Y_sim  # # change Y_sim to Y_act for actual data

# Model-specific NUTS parameter
m1_base_init <- "random"

job::job({
  
  m1_base_fit <- sampling(m1_base,
                          data = list(N = N,
                                      T = no_periods,
                                      Y_obs = Y_obs,
                                      X = X),
                          chains = chains,
                          iter = iter,
                          warmup = warmup,
                          init = m1_base_init,
                          algorithm = algorithm)
  
  # save m1_base_fit
  saveRDS(m1_base_fit,
          "SimulationStudyResults/Model1Baseline_Fit.rds")
  
})


# model 1 multiple classes - estimation ####
# computation with NUTS in STAN
m1_mult <- stan_model("ModelImplementation/Model1MultipleClasses.stan")

# observed dependent variable
Y_obs <- Y_sim  # change Y_sim to Y_act for actual data

# number of latent classes
C <- 2

# model-specific NUTS parameter
init <- "random"

# alpha parameter for Dirichlet pdfs,
# which serve as prior distributions for mixture proportions
alpha <- rep(3, times = C)

job::job({
  
  m1_mult_fit <- sampling(m1_mult,
                          data = list(N = N,
                                      T = no_periods,
                                      Y_obs = Y_obs,
                                      X = X,
                                      C = C,
                                      alpha = alpha),
                          chains = chains,
                          iter = iter,
                          warmup = warmup,
                          init = init,
                          algorithm = algorithm)
  
  # save m1_mult_fit
  saveRDS(m1_mult_fit,
          "SimulationStudyResults/Model1TwoClasses_Fit.rds")
  
})


