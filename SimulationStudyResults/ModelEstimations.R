# README ####
# closing the sections provides an overview of this R script.

# how to use this R script?
# firstly, run the preparation section.
# secondly, run one or several model sections; in any order.

# required files for model 1 baseline - dataset 1 section:
# Dataset1_Yobs_Run1.xlsx
# Dataset1_Yobs_Run2.xlsx
# Dataset1_Yobs_Run3.xlsx
# Dataset1_Yobs_Run4.xlsx
# Dataset1_Yobs_Run5.xlsx
# Model1Baseline.stan

# required files for model 1 two classes - dataset 2 section:
# Dataset2_Yobs.xlsx
# Model1MultipleClasses_beta0ordered.stan

# required files for model 1 two classes - dataset 3 section:
# Dataset3_Yobs.xlsx
# Model1MultipleClasses_beta0ordered.stan

# required files for model 1 two classes - dataset 4 section:
# Dataset4_Yobs.xlsx
# Model1MultipleClasses_beta0ordered.stan

# required files for model 1 three classes - dataset 5 section:
# Dataset5_Yobs.xlsx
# Model1MultipleClasses_beta0ordered.stan

# required files for model 1 three classes - dataset 6 section:
# Dataset6_Yobs.xlsx
# Model1MultipleClasses_beta0beta1ordered.stan

# required files for model 3 baseline - dataset 15 section:
# Dataset15_Yobs.xlsx
# Model3Baseline.stan

# required files for model 1 two classes - dataset 16 section:
# Dataset16_Yobslog.xlsx
# Model1MultipleClasses_beta0ordered.stan

# required files for model 3 two classes - dataset 16 section:
# Dataset16_Yobs.xlsx
# Model3MultipleClasses_beta0ordered.stan


# preparation ####
# set working directory
setwd("C:/Users/Diiim/Documents/GitHub/BayesianGMMs")

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


# model 1 baseline - dataset 1 - Yobs ####
# SD hyperparameter for Normal prior of constant
sigma_beta_0 <- 10

# mean hyperparameter for Normal prior of linear trend component
mu_beta_1 <- 0

# SD hyperparameter for Normal prior of linear trend component
sigma_beta_1 <- 1

# SD hyperparameter for Normal prior of SD for Y Normal distributions
sigma_sigma <- 1

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

# number of estimation runs
R <- 5

# estimation runs
for (r in 1:R) {
  
  # load observed dependent variable
  Y_obs <- data.frame(read_excel(
    paste("SimulationStudyData/Dataset1_Yobs_Run", r, ".xlsx", sep = ""),
    sheet = "Sheet 1"))
  
  # number of individuals
  N <- dim(Y_obs)[1]
  
  # number of time periods
  no_periods <- dim(Y_obs)[2]
  
  # explanatory variable
  time_periods <- 0:(no_periods-1)
  X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)
  
  # mean hyperparameter for Normal prior of constant
  mu_beta_0 <- mean(Y_obs[,1])
  
  job::job({
    
    # estimate model
    m_fit <- sampling(m,
                      data = list(N = N,
                                  T = no_periods,
                                  Y_obs = Y_obs,
                                  X = X,
                                  mu_beta_0 = mu_beta_0,
                                  sigma_beta_0 = sigma_beta_0,
                                  mu_beta_1 = mu_beta_1,
                                  sigma_beta_1 = sigma_beta_1,
                                  sigma_sigma = sigma_sigma),
                      chains = chains,
                      iter = iter,
                      warmup = warmup,
                      init = init,
                      algorithm = algorithm)
    
    # save model fit
    saveRDS(m_fit, paste(
      "SimulationStudyResults/Model1/Model1Baseline_Dataset1_Yobs_Run",
      r,
      ".rds",
      sep = ""))
    
  })
  
}


# model 1 two classes - dataset 2 - Yobs ####
# number of latent classes
C <- 2

# load observed dependent variable
Y_obs <- data.frame(read_excel("SimulationStudyData/Dataset2_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# mean hyperparameters for Normal prior of constants
k_means <- kmeans(Y_obs[,1],  # K-means clustering
                  centers = C,
                  iter.max = 10,
                  nstart = 2,
                  algorithm = "Hartigan-Wong")
mu_beta_0 <- sort(k_means$centers)

# SD hyperparameters for Normal prior of constants
sigma_beta_0 <- c(1,1)

# mean hyperparameters for Normal prior of linear trend components
mu_beta_1 <- c(0,0)

# SD hyperparameters for Normal prior of linear trend components
sigma_beta_1 <- c(1,1)

# SD hyperparameters for Normal prior of SDs for Y Normal distributions
sigma_sigma <- c(0.5,0.5)

# load model
m <- stan_model("ModelImplementations/Model5MultipleClasses_beta0ordered.stan")

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
                                mu_beta_0 = mu_beta_0,
                                sigma_beta_0 = sigma_beta_0,
                                mu_beta_1 = mu_beta_1,
                                sigma_beta_1 = sigma_beta_1,
                                sigma_sigma = sigma_sigma),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model1TwoClasses_Dataset2_Fit1.rds")
  
})


# model 1 two classes - dataset 3 - Yobs ####
# number of latent classes
C <- 2

# load observed dependent variable
Y_obs <- data.frame(read_excel("SimulationStudyData/Dataset3_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# mean hyperparameters for Normal prior of constants
k_means <- kmeans(Y_obs[,1],  # K-means clustering
                  centers = C,
                  iter.max = 10,
                  nstart = 2,
                  algorithm = "Hartigan-Wong")
mu_beta_0 <- sort(k_means$centers)

# SD hyperparameters for Normal prior of constants
sigma_beta_0 <- c(1,1)

# mean hyperparameters for Normal prior of linear trend components
mu_beta_1 <- c(0,0)

# SD hyperparameters for Normal prior of linear trend components
sigma_beta_1 <- c(1,1)

# SD hyperparameters for Normal prior of SDs for Y Normal distributions
sigma_sigma <- c(0.5,0.5)

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
                                mu_beta_0 = mu_beta_0,
                                sigma_beta_0 = sigma_beta_0,
                                mu_beta_1 = mu_beta_1,
                                sigma_beta_1 = sigma_beta_1,
                                sigma_sigma = sigma_sigma),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model1TwoClasses_Dataset3_Fit1.rds")
  
})


# model 1 two classes - dataset 4 - Yobs ####
# number of latent classes
C <- 2

# load observed dependent variable
Y_obs <- data.frame(read_excel("SimulationStudyData/Dataset4_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# mean hyperparameters for Normal prior of constants
k_means <- kmeans(Y_obs[,1],  # K-means clustering
                  centers = C,
                  iter.max = 10,
                  nstart = 2,
                  algorithm = "Hartigan-Wong")
mu_beta_0 <- sort(k_means$centers)

# SD hyperparameters for Normal prior of constants
sigma_beta_0 <- c(1,1)

# mean hyperparameters for Normal prior of linear trend components
mu_beta_1 <- c(0,0)

# SD hyperparameters for Normal prior of linear trend components
sigma_beta_1 <- c(1,1)

# SD hyperparameters for Normal prior of SDs for Y Normal distributions
sigma_sigma <- c(0.5,0.5)

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
                                mu_beta_0 = mu_beta_0,
                                sigma_beta_0 = sigma_beta_0,
                                mu_beta_1 = mu_beta_1,
                                sigma_beta_1 = sigma_beta_1,
                                sigma_sigma = sigma_sigma),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model1TwoClasses_Dataset4_Fit1.rds")
  
})


# model 1 three classes - dataset 5- Yobs ####
# number of latent classes
C <- 3

# load observed dependent variable
Y_obs <- data.frame(read_excel("SimulationStudyData/Dataset5_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# mean hyperparameters for Normal prior of constants
k_means <- kmeans(Y_obs[,1],  # K-means clustering
                  centers = C,
                  iter.max = 10,
                  nstart = 2,
                  algorithm = "Hartigan-Wong")
mu_beta_0 <- sort(k_means$centers)

# SD hyperparameters for Normal prior of constants
sigma_beta_0 <- c(0.5,0.5,0.5)

# mean hyperparameters for Normal prior of linear trend components
mu_beta_1 <- c(0,0,0)

# SD hyperparameters for Normal prior of linear trend components
sigma_beta_1 <- c(1,1,1)

# SD hyperparameters for Normal prior of SDs for Y Normal distributions
sigma_sigma <- c(0.5,0.5,0.5)

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
  init[[ch]] <- list(beta_0 = mu_beta_0)
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
                                mu_beta_0 = mu_beta_0,
                                sigma_beta_0 = sigma_beta_0,
                                mu_beta_1 = mu_beta_1,
                                sigma_beta_1 = sigma_beta_1,
                                sigma_sigma = sigma_sigma),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model1ThreeClasses_Dataset5_Fit1.rds")
  
})


# model 1 three classes - dataset 6 - part one ####
# number of latent classes
C <- 3

# load observed dependent variable
Y_obs <- data.frame(read_excel("SimulationStudyData/Dataset6_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# mean hyperparameters for Normal prior of constants
mu_beta_0 <- rep(mean(Y_obs[,1]), times = C)

# SD hyperparameters for Normal prior of constants
sigma_beta_0 <- c(0.5,0.5,0.5)

# mean hyperparameters for Normal prior of linear trend components
mu_beta_1 <- c(0,0,0)

# SD hyperparameters for Normal prior of linear trend components
sigma_beta_1 <- c(0.5,0.5,0.5)

# SD hyperparameter for Normal prior of SD for Y Normal distributions
sigma_sigma <- 0.5

# load model
m <- stan_model(
  "ModelImplementations/Model1MultipleClasses_IdentErr_beta1ordered.stan")

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
                                mu_beta_0 = mu_beta_0,
                                sigma_beta_0 = sigma_beta_0,
                                mu_beta_1 = mu_beta_1,
                                sigma_beta_1 = sigma_beta_1,
                                sigma_sigma = sigma_sigma),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
})

# extract estimated data
m_fit_data <- rstan::extract(m_fit)

# posterior means for beta_0 and beta_1
beta_posterior_means <- matrix(data = 0, nrow = C, ncol = 2)
for (c in 1:C) {
  beta_posterior_means[c,1] <- mean(m_fit_data$beta_0[,c])
  beta_posterior_means[c,2] <- mean(m_fit_data$beta_1[,c])
}
beta_posterior_means <- beta_posterior_means[order(beta_posterior_means[,1]),]


# model 1 three classes - dataset 6 - part two ####
# mean hyperparameters for Normal prior of constants
rep(mean(Y_obs[,1]), times = C)

# SD hyperparameters for Normal prior of constants
sigma_beta_0 <- c(1,1,1)

# mean hyperparameters for Normal prior of linear trend components
mu_beta_1 <- c(0,0,0)

# SD hyperparameters for Normal prior of linear trend components
sigma_beta_1 <- c(1,1,1)

# SD hyperparameters for Normal prior of SDs for Y Normal distributions
sigma_sigma <- c(1,1,1)

# load model
m <- stan_model("ModelImplementations/Model1MultipleClasses_beta1ordered.stan")

# sampler: number of chains
chains <- 4

# sampler: number of iterations per chain
iter <- 2000

# sampler: number of warmup iterations per chain
warmup <- floor(iter/2)

# sampler: initial values for parameters
init <- list()
for (ch in 1:chains) {
  init[[ch]] <- list(beta_0 = beta_posterior_means[,1],
                     beta_1 = beta_posterior_means[,2])
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
                                mu_beta_0 = mu_beta_0,
                                sigma_beta_0 = sigma_beta_0,
                                mu_beta_1 = mu_beta_1,
                                sigma_beta_1 = sigma_beta_1,
                                sigma_sigma = sigma_sigma),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model1ThreeClasses_Dataset6_Fit1.rds")
  
})


# model 3 baseline - dataset 15 - Yobs ####
# load observed dependent variable
Y_obs <- data.frame(read_excel("SimulationStudyData/Dataset15_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# mean hyperparameter for Normal prior of constant
mu_beta_0 <- log(mean(Y_obs[,1]))

# SD hyperparameter for Normal prior of constant
sigma_beta_0 <- 10

# mean hyperparameter for Normal prior of linear trend component
mu_beta_1 <- 0

# SD hyperparameter for Normal prior of linear trend component
sigma_beta_1 <- 1

# load model
m <- stan_model("ModelImplementations/Model3Baseline.stan")

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
                                mu_beta_0 = mu_beta_0,
                                sigma_beta_0 = sigma_beta_0,
                                mu_beta_1 = mu_beta_1,
                                sigma_beta_1 = sigma_beta_1),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model3Baseline_Dataset15_Fit1.rds")
  
})


# model 1 two classes - dataset 16 - Yobslog ####
# number of latent classes
C <- 2

# load observed dependent variable
Y_obs_log <- data.frame(read_excel("SimulationStudyData/Dataset16_Yobslog.xlsx",
                                   sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs_log)[1]

# number of time periods
no_periods <- dim(Y_obs_log)[2]

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# mean hyperparameters for Normal prior of constants
k_means <- kmeans(Y_obs_log[,1],  # K-means clustering
                  centers = C,
                  iter.max = 10,
                  nstart = 2,
                  algorithm = "Hartigan-Wong")
mu_beta_0 <- sort(k_means$centers)

# SD hyperparameters for Normal prior of constants
sigma_beta_0 <- c(1,1)

# mean hyperparameters for Normal prior of linear trend components
mu_beta_1 <- c(0,0)

# SD hyperparameters for Normal prior of linear trend components
sigma_beta_1 <- c(1,1)

# SD hyperparameters for Normal prior of SDs for Y Normal distributions
sigma_sigma <- c(0.5,0.5)

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
                                Y_obs = Y_obs_log,
                                X = X,
                                mu_beta_0 = mu_beta_0,
                                sigma_beta_0 = sigma_beta_0,
                                mu_beta_1 = mu_beta_1,
                                sigma_beta_1 = sigma_beta_1,
                                sigma_sigma = sigma_sigma),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model1TwoClasses_Dataset16_Fit1.rds")
  
})


# model 3 two classes - dataset 16 - Yobs ####
# number of latent classes
C <- 2

# load observed dependent variable
Y_obs <- data.frame(read_excel("SimulationStudyData/Dataset16_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# load model fit for model 1 two classes dataset 16
m_fit <- readRDS("SimulationStudyResults/Model1TwoClasses_Dataset16_Fit1.rds")

# extract estimated data for model 1 two classes dataset 16
m_fit_data <- rstan::extract(m_fit)

# posterior means of beta_0 and beta_1 for model 1 two classes dataset 16
beta_posterior_means <- matrix(data = 0, nrow = C, ncol = 2)
for (c in 1:C) {
  beta_posterior_means[c,1] <- mean(m_fit_data$beta_0[,c])
  beta_posterior_means[c,2] <- mean(m_fit_data$beta_1[,c])
}
beta_posterior_means <- beta_posterior_means[order(beta_posterior_means[,1]),]

# mean hyperparameters for Normal prior of constants
mu_beta_0 <- beta_posterior_means[,1]

# SD hyperparameters for Normal prior of constants
sigma_beta_0 <- c(1,1)

# mean hyperparameters for Normal prior of linear trend components
mu_beta_1 <- c(0,0)

# SD hyperparameters for Normal prior of linear trend components
sigma_beta_1 <- c(1,1)

# load model
m <- stan_model("ModelImplementations/Model3MultipleClasses_beta0ordered.stan")

# sampler: number of chains
chains <- 4

# sampler: number of iterations per chain
iter <- 2000

# sampler: number of warmup iterations per chain
warmup <- floor(iter/2)

# sampler: initial values for parameters
init <- list()
for (ch in 1:chains) {
  init[[ch]] <- list(beta_0 = beta_posterior_means[,1],
                     beta_1 = beta_posterior_means[,2])
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
                                mu_beta_0 = mu_beta_0,
                                sigma_beta_0 = sigma_beta_0,
                                mu_beta_1 = mu_beta_1,
                                sigma_beta_1 = sigma_beta_1),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResults/Model3TwoClasses_Dataset16_Fit1.rds")
  
})


