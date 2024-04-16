# closing the sections provides an overview of the script


# README ####
# how to use this file?
# firstly, run the preparation section.
# secondly, run one or several model sections ( in any order ).

# required files for model 1 baseline - dataset 1 section:
# Dataset1_Yobs.xlsx
# Model1Baseline.stan

# required files for model 1 two classes - dataset 2 section:
# Dataset2_Yobs.xlsx
# Model1MultipleClasses.stan

# required files for model 1 two classes - dataset 3 section:
# Dataset3_Yobs.xlsx
# Model1MultipleClasses.stan

# required files for model 1 two classes - dataset 4 section:
# Dataset4_Yobs.xlsx
# Model1MultipleClasses.stan

# required files for model 1 three classes - dataset 5 section:
# Dataset5_Yobs.xlsx
# Model1MultipleClasses.stan

# required files for model 1 three classes - dataset 6 section:
# Dataset6_Yobs.xlsx
# Model1MultipleClasses.stan


# preparation ####
# set working directory
setwd("C:/Users/Diiim/Documents/GitHub/BayesianGMM")

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


# model 1 baseline - dataset 1 ####
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

# mean hyperparameter for Normal prior of constant
beta_0_prior_mu <- mean(Y_obs[,1])

# SD hyperparameter for Normal prior of constant
beta_0_prior_sigma <- 10

# mean hyperparameter for Normal prior of linear trend component
beta_1_prior_mu <- 0

# SD hyperparameter for Normal prior of linear trend component
beta_1_prior_sigma <- 1

# SD hyperparameter for Normal prior of SD for Y Normal distributions
sigma_prior_sigma <- 1

# load model
m <- stan_model("ModelImplementations/Model1Baseline.stan")

# sampler: number of chains
chains <- 4

# sampler: number of iterations per chain
iter <- 2000

# sampler: number of warmup iterations per chain
warmup <- floor(iter/2)

# sampler: initial values for parameters
init <- "random"

# sampler: algorithm
algorithm <- "NUTS"

job::job({
  
  # estimate model
  m_fit <- sampling(m,
                    data = list(N = N,
                                T = no_periods,
                                Y_obs = Y_obs,
                                X = X,
                                beta_0_prior_mu = beta_0_prior_mu,
                                beta_0_prior_sigma = beta_0_prior_sigma,
                                beta_1_prior_mu = beta_1_prior_mu,
                                beta_1_prior_sigma = beta_1_prior_sigma,
                                sigma_prior_sigma = sigma_prior_sigma),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model1Baseline_Dataset1_Fit1.rds")
  
})


# model 1 two classes - dataset 2 ####
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

# mean hyperparameter for Normal prior of constant
k_means <- kmeans(Y_obs[,1],  # K-means clustering
                  centers = C,
                  iter.max = 10,
                  nstart = 2,
                  algorithm = "Hartigan-Wong")
beta_0_prior_mu <- sort(k_means$centers)

# SD hyperparameters for Normal prior of constants
beta_0_prior_sigma <- c(1,1)

# mean hyperparameters for Normal prior of linear trend components
beta_1_prior_mu <- c(0,0)

# SD hyperparameters for Normal prior of linear trend components
beta_1_prior_sigma <- c(1,1)

# SD hyperparameters for Normal prior of SDs for Y Normal distributions
sigma_prior_sigma <- c(0.5,0.5)

# load model
m <- stan_model("ModelImplementations/Model1MultipleClasses_beta0ordered.stan")

# sampler: number of chains
chains <- 4

# sampler: number of iterations per chain
iter <- 2000

# sampler: number of warmup iterations per chain
warmup <- floor(iter/2)

# sampler: initial values for parameters
init <- "random"

# sampler: algorithm
algorithm <- "NUTS"

job::job({
  
  # estimate model
  m_fit <- sampling(m,
                    data = list(C = C,
                                N = N,
                                T = no_periods,
                                Y_obs = Y_obs,
                                X = X,
                                beta_0_prior_mu = beta_0_prior_mu,
                                beta_0_prior_sigma = beta_0_prior_sigma,
                                beta_1_prior_mu = beta_1_prior_mu,
                                beta_1_prior_sigma = beta_1_prior_sigma,
                                sigma_prior_sigma = sigma_prior_sigma),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model1TwoClasses_Dataset2_Fit1.rds")
  
})


# model 1 two classes - dataset 3 ####
# number of latent classes
C <- 2

# load observed dependent variable
Y_obs <- data.frame(read_excel("SimulationStudyData/Dataset3_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# mean hyperparameter for Normal prior of constant
k_means <- kmeans(Y_obs[,1],  # K-means clustering
                  centers = C,
                  iter.max = 10,
                  nstart = 2,
                  algorithm = "Hartigan-Wong")
beta_0_prior_mu <- sort(k_means$centers)

# SD hyperparameters for Normal prior of constants
beta_0_prior_sigma <- c(1,1)

# mean hyperparameters for Normal prior of linear trend components
beta_1_prior_mu <- c(0,0)

# SD hyperparameters for Normal prior of linear trend components
beta_1_prior_sigma <- c(1,1)

# SD hyperparameters for Normal prior of SDs for Y Normal distributions
sigma_prior_sigma <- c(0.5,0.5)

# load model
m <- stan_model("ModelImplementations/Model1MultipleClasses_beta0ordered.stan")

# sampler: number of chains
chains <- 4

# sampler: number of iterations per chain
iter <- 2000

# sampler: number of warmup iterations per chain
warmup <- floor(iter/2)

# sampler: initial values for parameters
init <- "random"

# sampler: algorithm
algorithm <- "NUTS"

job::job({
  
  # estimate model
  m_fit <- sampling(m,
                    data = list(C = C,
                                N = N,
                                T = no_periods,
                                Y_obs = Y_obs,
                                X = X,
                                beta_0_prior_mu = beta_0_prior_mu,
                                beta_0_prior_sigma = beta_0_prior_sigma,
                                beta_1_prior_mu = beta_1_prior_mu,
                                beta_1_prior_sigma = beta_1_prior_sigma,
                                sigma_prior_sigma = sigma_prior_sigma),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model1TwoClasses_Dataset3_Fit1.rds")
  
})


# model 1 two classes - dataset 4 ####
# number of latent classes
C <- 2

# load observed dependent variable
Y_obs <- data.frame(read_excel("SimulationStudyData/Dataset4_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# mean hyperparameter for Normal prior of constant
k_means <- kmeans(Y_obs[,1],  # K-means clustering
                  centers = C,
                  iter.max = 10,
                  nstart = 2,
                  algorithm = "Hartigan-Wong")
beta_0_prior_mu <- sort(k_means$centers)

# SD hyperparameters for Normal prior of constants
beta_0_prior_sigma <- c(1,1)

# mean hyperparameters for Normal prior of linear trend components
beta_1_prior_mu <- c(0,0)

# SD hyperparameters for Normal prior of linear trend components
beta_1_prior_sigma <- c(1,1)

# SD hyperparameters for Normal prior of SDs for Y Normal distributions
sigma_prior_sigma <- c(0.5,0.5)

# load model
m <- stan_model("ModelImplementations/Model1MultipleClasses_beta0ordered.stan")

# sampler: number of chains
chains <- 4

# sampler: number of iterations per chain
iter <- 2000

# sampler: number of warmup iterations per chain
warmup <- floor(iter/2)

# sampler: initial values for parameters
init <- "random"

# sampler: algorithm
algorithm <- "NUTS"

job::job({
  
  # estimate model
  m_fit <- sampling(m,
                    data = list(C = C,
                                N = N,
                                T = no_periods,
                                Y_obs = Y_obs,
                                X = X,
                                beta_0_prior_mu = beta_0_prior_mu,
                                beta_0_prior_sigma = beta_0_prior_sigma,
                                beta_1_prior_mu = beta_1_prior_mu,
                                beta_1_prior_sigma = beta_1_prior_sigma,
                                sigma_prior_sigma = sigma_prior_sigma),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model1TwoClasses_Dataset4_Fit1.rds")
  
})


# model 1 three classes - dataset 5 ####
# number of latent classes
C <- 3

# load observed dependent variable
Y_obs <- data.frame(read_excel("SimulationStudyData/Dataset5_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# mean hyperparameter for Normal prior of constant
k_means <- kmeans(Y_obs[,1],  # K-means clustering
                  centers = C,
                  iter.max = 10,
                  nstart = 2,
                  algorithm = "Hartigan-Wong")
beta_0_prior_mu <- sort(k_means$centers)

# SD hyperparameters for Normal prior of constants
beta_0_prior_sigma <- c(0.5,0.5,0.5)

# mean hyperparameters for Normal prior of linear trend components
beta_1_prior_mu <- c(0,0,0)

# SD hyperparameters for Normal prior of linear trend components
beta_1_prior_sigma <- c(1,1,1)

# SD hyperparameters for Normal prior of SDs for Y Normal distributions
sigma_prior_sigma <- c(0.5,0.5,0.5)

# load model
m <- stan_model("ModelImplementations/Model1MultipleClasses_beta0ordered.stan")

# sampler: number of chains
chains <- 4

# sampler: number of iterations per chain
iter <- 2000

# sampler: number of warmup iterations per chain
warmup <- floor(iter/2)

# sampler: initial values for parameters
init <- list()
for (ch in 1:chains) {
  init[[ch]] <- list(beta_0 = beta_0_prior_mu)
}

# sampler: algorithm
algorithm <- "NUTS"

job::job({
  
  # estimate model
  m_fit <- sampling(m,
                    data = list(C = C,
                                N = N,
                                T = no_periods,
                                Y_obs = Y_obs,
                                X = X,
                                beta_0_prior_mu = beta_0_prior_mu,
                                beta_0_prior_sigma = beta_0_prior_sigma,
                                beta_1_prior_mu = beta_1_prior_mu,
                                beta_1_prior_sigma = beta_1_prior_sigma,
                                sigma_prior_sigma = sigma_prior_sigma),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model1ThreeClasses_Dataset5_Fit1.rds")
  
})


# model 1 three classes - dataset 6 ####
# number of latent classes
C <- 3

# load observed dependent variable
Y_obs <- data.frame(read_excel("SimulationStudyData/Dataset6_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# mean hyperparameter for Normal prior of constant
k_means <- kmeans(Y_obs[,1],  # K-means clustering
                  centers = C,
                  iter.max = 10,
                  nstart = 2,
                  algorithm = "Hartigan-Wong")
beta_0_prior_mu <- sort(k_means$centers)

# SD hyperparameters for Normal prior of constants
beta_0_prior_sigma <- c(0.5,0.5,0.5)

# mean hyperparameters for Normal prior of linear trend components
beta_1_prior_mu <- c(0,0,0)

# SD hyperparameters for Normal prior of linear trend components
beta_1_prior_sigma <- c(1,1,1)

# SD hyperparameters for Normal prior of SDs for Y Normal distributions
sigma_prior_sigma <- c(0.5,0.5,0.5)

# load model
m <- stan_model(
  "ModelImplementations/Model1MultipleClasses_beta0beta1ordered.stan"
  )

# sampler: number of chains
chains <- 4

# sampler: number of iterations per chain
iter <- 2000

# sampler: number of warmup iterations per chain
warmup <- floor(iter/2)

# sampler: initial values for parameters
init <- "random"

# sampler: algorithm
algorithm <- "NUTS"

job::job({
  
  # estimate model
  m_fit <- sampling(m,
                    data = list(C = C,
                                N = N,
                                T = no_periods,
                                Y_obs = Y_obs,
                                X = X,
                                beta_0_prior_mu = beta_0_prior_mu,
                                beta_0_prior_sigma = beta_0_prior_sigma,
                                beta_1_prior_mu = beta_1_prior_mu,
                                beta_1_prior_sigma = beta_1_prior_sigma,
                                sigma_prior_sigma = sigma_prior_sigma),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model1ThreeClasses_Dataset6_Fit1.rds")
  
})


