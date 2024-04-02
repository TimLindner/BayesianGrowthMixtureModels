# closing the sections provides an overview of the script

# README ####
# before model estimation,
# run DataSimulation.R ( preparation section plus respective model section )
# or TerrorismData.R

# required files:
# Model1Baseline.stan ( to load model for model 1 baseline )
# Model1MultipleClasses.stan ( to load model for model 1 multiple classes )


# preparation ####
# set working directory
setwd("C:/Users/Diiim/Documents/ResearchAssistance")

# load packages
library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)


# NUTS parameters ####
# choose NUTS as algorithm
algorithm <- "NUTS"

# number of chains
chains <- 4  # default

# number of iterations per chain
iter <- 2000  # default

# number of warmup iterations per chain
warmup <- floor(iter/2)  # default


# model 1 baseline ####
# load model
m <- stan_model("ModelImplementation/Model1Baseline.stan")

# model-specific NUTS parameter
init <- "random"

job::job({
  
  # estimate model
  m_fit <- sampling(m,
                    data = list(N = N,
                                T = no_periods,
                                Y_obs = Y_obs,
                                X = X),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResult/Model1Baseline_Fit.rds")
  
})


# model 1 multiple classes ####
# load model
m <- stan_model("ModelImplementation/Model1MultipleClasses.stan")

# number of latent classes
C <- 2

# alpha parameter for Dirichlet distributions,
# which serve as prior distributions for mixture proportions
alpha <- rep(1, times = C)

# model-specific NUTS parameter
init <- "random"

job::job({
  
  # estimate model
  m_fit <- sampling(m,
                    data = list(C = C,
                                alpha = alpha,
                                T = no_periods,
                                Y_obs = Y_obs,
                                X = X),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResult/Model1TwoClasses_Fit_TEST.rds")
  
})


