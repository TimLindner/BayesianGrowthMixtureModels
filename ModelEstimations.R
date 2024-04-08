# closing the sections provides an overview of the script


# README ####
# how to use this file?
# firstly, run the preparation and NUTS parameters section.
# secondly, run one or several model sections ( in any order ).

# required files for model 1 baseline:
# Dataset1_Yobs.xlsx
# Model1Baseline.stan

# required files for model 1 multiple classes:
# one of the following datasets:
# - Dataset2_Yobs.xlsx ( default dataset )
# - Dataset3_Yobs.xlsx
# - Dataset4_Yobs.xlsx
# Model1MultipleClasses.stan


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
# algorithm
algorithm <- "NUTS"

# number of chains
chains <- 4

# number of iterations per chain
iter <- 2000

# number of warmup iterations per chain
warmup <- floor(iter/2)


# model 1 baseline ####
# load observed dependent variable
Y_obs <- data.frame(read_excel("SimulationStudyData/Dataset1_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# load model
m <- stan_model("ModelImplementations/Model1Baseline.stan")

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
          "SimulationStudyResults/Model1Baseline_Dataset1_Fit.rds")
  
})


# model 1 multiple classes ####
# number of latent classes
C <- 2

# load observed dependent variable
Y_obs <- data.frame(read_excel("SimulationStudyData/Dataset2_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# load model
m <- stan_model("ModelImplementations/Model1MultipleClasses.stan")

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
          "SimulationStudyResults/Model1TwoClasses_Dataset2_Fit.rds")
  
})


