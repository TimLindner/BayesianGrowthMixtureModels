# closing the sections provides an overview of the script

# README ####
# required files for model 1 baseline:
# xlsx file containing observed dependent variable
# stan file containing model 1 baseline implementation

# required files for model 1 multiple classes:
# xlsx file containing observed dependent variable
# stan file containing model 1 multiple classes implementation


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
library(readxl)
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
# load observed dependent variable
Y_obs <- data.frame(read_excel("Model1Baseline_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

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
# number of latent classes
C <- 2

# load observed dependent variable
Y_obs <- data.frame(read_excel("Model1TwoClasses_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# load model
m <- stan_model("ModelImplementation/Model1MultipleClasses.stan")

# model-specific NUTS parameter
init <- "random"

job::job({
  
  # estimate model
  m_fit <- sampling(m,
                    data = list(C = C,
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


