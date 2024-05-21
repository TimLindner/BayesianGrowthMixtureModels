# README ####
# closing the sections provides an overview of this R script.

# how to use this R script? before running a simulation case section, always run
# the preparation section.

# required file for simulation case 15 section from SimulationStudyData/Model3
# folder:
# SimulationModel_Model3Baseline.stan

# required file for simulation case 16 section from SimulationStudyData/Model3
# folder:
# SimulationModel_Model3MultipleClasses.stan

# required file for simulation case 17 section from SimulationStudyData/Model3
# folder:
# SimulationModel_Model3MultipleClasses.stan

# required file for simulation case 17 version 2 section from
# SimulationStudyData/Model3 folder:
# SimulationModel_Model3MultipleClasses.stan

# required file for simulation case 18 section from SimulationStudyData/Model3
# folder:
# SimulationModel_Model3MultipleClasses.stan

# required file for simulation case 19 section from SimulationStudyData/Model3
# folder:
# SimulationModel_Model3MultipleClasses.stan

# a note on the R code:
# if beta_1_sim is a scalar and z_sim is a vector of size N, then
# beta_1_sim[z_sim] is also a vector of size N. furthermore, if X is a N times T
# matrix, then beta_1_sim[z_sim] * X is a also a N times T matrix (i.e.,
# beta_1_sim[z_sim] is multiplied element-wisely with X in column-major order).

# a note on the R code:
# if beta_1_sim is a scalar and Z_sim is a N times T matrix, then
# beta_1_sim[Z_sim] is a vector of size N * T; where Z_sim is supplied to
# beta_1_sim in column-major order. furthermore, if X is a N times T matrix,
# then beta_1_sim[Z_sim] * X is a also a N times T matrix (i.e.,
# beta_1_sim[Z_sim] is multiplied element-wisely with X in column-major order).


# preparation ####
# set working directory
setwd("C:/Users/Diiim/Documents/GitHub/BayesianGMMs/SimulationStudyData")

# clean workspace
rm(list = ls())

# clean garbage
gc()

# set decimals to digits instead of scientific
options(scipen = 999)

# load packages
library(openxlsx)
library(extraDistr)
library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)


# simulation case 1 ####
# number of individuals
N <- 50

# number of time periods
no_periods <- 10

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated constant
beta_0_sim <- 10

# simulated linear trend component
beta_1_sim <- 1

# simulated standard deviation for Y_obs Normal distributions
sigma_sim <- 0.75

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)

# number of simulation runs
R <- 5

# simulation runs
for (r in 1:R) {
  
  # simulated means for Y_obs Normal distributions
  M_sim <- beta_0_sim + beta_1_sim * X  # vectorization over n and t
  
  # Y_obs
  for (t in 1:no_periods) {
    Y_obs[,t] <- rnorm(n = N, mean = M_sim[,t], sd = sigma_sim)
    # vectorization over n
  }
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model1/SimCase1_Yobs_SimRun", r, ".xlsx", sep = ""))
  
}


# simulation case 2 ####
# number of individuals
N <- 200

# number of time periods
no_periods <- 10

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated mixture proportions
lambda_sim <- c(0.3,0.7)

# simulated constants
beta_0_sim <- c(-5,10)

# simulated linear trend components
beta_1_sim <- c(-0.5,1)

# simulated standard deviations for Y_obs Normal distributions
sigma_sim <- c(0.25,0.75)

# simulated means for Y_obs Normal distributions
M_sim <- matrix(data = 0, nrow = N, ncol = no_periods)

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)

# number of simulation runs
R <- 5

# simulation runs
for (r in 1:R) {
  
  # simulated class memberships
  z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization over n
  
  # save z_sim (transform to data frame beforehand)
  write.xlsx(data.frame(z_sim),
             paste("Model1/SimCase2_zsim_SimRun", r, ".xlsx", sep = ""))
  
  # M_sim
  M_sim <- beta_0_sim[z_sim] + beta_1_sim[z_sim] * X
  # vectorization over n and t
  
  # Y_obs
  for (t in 1:no_periods) {
    Y_obs[,t] <- rnorm(n = N, mean = M_sim[,t], sd = sigma_sim[z_sim])
    # vectorization over n
  }
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model1/SimCase2_Yobs_SimRun", r, ".xlsx", sep = ""))
  
}


# simulation case 3 NOTES ####
# overlapping constants
# constants 2, 3
# trends -0.5, 1


# simulation case 4 NOTES ####
# intersecting trends
# constants -5, 10
# trends 1, -2

# simulation case 5 ####
# number of individuals
N <- 200

# number of time periods
no_periods <- 10

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated mixture proportions
lambda_sim <- c(0.3,0.2,0.5)

# simulated constants
beta_0_sim <- c(-5,2.5,10)

# simulated linear trend components
beta_1_sim <- c(-0.5,0.5,1)

# simulated standard deviations for Y_obs Normal distributions
sigma_sim <- c(0.25,0.5,0.75)

# simulated means for Y_obs Normal distributions
M_sim <- matrix(data = 0, nrow = N, ncol = no_periods)

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)

# number of simulation runs
R <- 5

# simulation runs
for (r in 1:R) {
  
  # simulated class memberships
  z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization over n
  
  # save z_sim (transform to data frame beforehand)
  write.xlsx(data.frame(z_sim),
             paste("Model1/SimCase5_zsim_SimRun", r, ".xlsx", sep = ""))
  
  # M_sim
  M_sim <- beta_0_sim[z_sim] + beta_1_sim[z_sim] * X
  # vectorization over n and t
  
  # Y_obs
  for (t in 1:no_periods) {
    Y_obs[,t] <- rnorm(n = N, mean = M_sim[,t], sd = sigma_sim[z_sim])
    # vectorization over n
  }
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model1/SimCase5_Yobs_SimRun", r, ".xlsx", sep = ""))
  
}


# simulation case 6 NOTES ####
# intersecting trends
# constants 1.5, 2.5, 3.5
# trends -0.5, 0.5, 1


# simulation case 8 ####
# number of individuals
N <- 50

# number of time periods
no_periods <- 10

# explanatory variables
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# X squared
X_squared <- X^2  # vectorization over n and t

# simulated constant
beta_0_sim <- 10

# simulated linear trend component
beta_1_sim <- 1

# simulated quadratic trend component
beta_2_sim <- -0.1

# simulated standard deviation for Y_obs Normal distributions
sigma_sim <- 0.75

# simulated means for Y_obs Normal distributions
M_sim <- matrix(data = 0, nrow = N, ncol = no_periods)

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)

# number of simulation runs
R <- 5

# simulation runs
for (r in 1:R) {
  
  # M_sim
  M_sim <- beta_0_sim + beta_1_sim * X + beta_2_sim * X_squared
  # vectorization over n and t
  
  # Y_obs
  for (t in 1:no_periods) {
    Y_obs[,t] <- rnorm(n = N, mean = M_sim[,t], sd = sigma_sim)
    # vectorization over n
  }
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model2/SimCase8_Yobs_SimRun", r, ".xlsx", sep = ""))
  
}


# simulation case 9 ####
# number of individuals
N <- 200

# number of time periods
no_periods <- 10

# explanatory variables
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# X squared
X_squared <- X^2  # vectorization over n and t

# simulated mixture proportions
lambda_sim <- c(0.3,0.7)

# simulated constants
beta_0_sim <- c(-5,10)

# simulated linear trend components
beta_1_sim <- c(-0.5,1)

# simulated quadratic trend components
beta_2_sim <- c(0.2,-0.1)

# simulated standard deviations for Y_obs Normal distributions
sigma_sim <- c(0.25,0.75)

# simulated means for Y_obs Normal distributions
M_sim <- matrix(data = 0, nrow = N, ncol = no_periods)

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)

# number of simulation runs
R <- 5

# simulation runs
for (r in 1:R) {
  
  # simulated class memberships
  z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization over n
  
  # save Z_sim (transform to data frame beforehand)
  write.xlsx(data.frame(z_sim),
             paste("Model2/SimCase9_zsim_SimRun", r, ".xlsx", sep = ""))
  
  # M_sim
  M_sim <-
    beta_0_sim[z_sim] + beta_1_sim[z_sim] * X + beta_2_sim[z_sim] * X_squared
  # vectorization over n and t
  
  # Y_obs
  for (t in 1:no_periods) {
    Y_obs[,t] <- rnorm(n = N, mean = M_sim[,t], sd = sigma_sim[z_sim])
    # vectorization over n
  }
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model2/SimCase9_Yobs_SimRun", r, ".xlsx", sep = ""))
  
}


# simulation case 15 ####
# number of individuals
N <- 50

# number of time periods
no_periods <- 10

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated constant
beta_0_sim <- 5

# simulated linear trend component
beta_1_sim <- 0.1

# load simulation model
sim_m <- stan_model("Model3/SimulationModel_Model3Baseline.stan")

# number of simulation runs
R <- 5

# simulation runs
for (r in 1:R) {

  # simulate data
  sim_m_fit <- sampling(sim_m,
                        data = list(C = C,
                                    N = N,
                                    T = no_periods,
                                    X = X,
                                    beta_0_sim = beta_0_sim,
                                    beta_1_sim = beta_1_sim),
                        chains = 1,
                        iter = 1,
                        algorithm = "Fixed_param")
  
  # extract simulated data
  sim_m_fit_data <- rstan::extract(sim_m_fit)
  
  # observed dependent variable
  Y_obs <- sim_m_fit_data$Y_obs[1,,]
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model3/SimCase15_Yobs_SimRun", r, ".xlsx", sep = ""))
  
}

 # vectorization M ?
# simulation case 16 ####
# number of latent classes
C <- 2

# number of individuals
N <- 200

# number of time periods
no_periods <- 10

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated mixture proportions
lambda_sim <- c(0.3,0.7)

# simulated constants
beta_0_sim <- c(1,5)

# simulated linear trend components
beta_1_sim <- c(0.4,0.1)

# load simulation model
sim_m <- stan_model("Model3/SimulationModel_Model3MultipleClasses.stan")

# number of simulation runs
R <- 100

# simulation runs
for (r in 6:R) {
  
  # simulate data
  sim_m_fit <- sampling(sim_m,
                        data = list(C = C,
                                    N = N,
                                    T = no_periods,
                                    X = X,
                                    lambda_sim = lambda_sim,
                                    beta_0_sim = beta_0_sim,
                                    beta_1_sim = beta_1_sim),
                        chains = 1,
                        iter = 1,
                        algorithm = "Fixed_param")
  
  # extract simulated data
  sim_m_fit_data <- rstan::extract(sim_m_fit)
  
  # simulated class memberships
  z_sim <- sim_m_fit_data$z_sim[1,]
  
  # save z_sim (transform to data frame beforehand)
  write.xlsx(data.frame(z_sim),
             paste("Model3/SimCase16_zsim_SimRun", r, ".xlsx", sep = ""))
  
  # observed dependent variable
  Y_obs <- sim_m_fit_data$Y_obs[1,,]
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model3/SimCase16_Yobs_SimRun", r, ".xlsx", sep = ""))
  
  # log transform Y_obs
  Y_obs[Y_obs==0] <- 1  # vectorization over n and t
  Y_obs_log <- log(Y_obs)  # vectorization over n and t
  
  # save Y_obs_log (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs_log),
             paste("Model3/SimCase16_Yobslog_SimRun", r, ".xlsx", sep = ""))
  
}


# simulation case 17 ####
# number of latent classes
C <- 2

# number of individuals
N <- 200

# number of time periods
no_periods <- 10

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated mixture proportions
lambda_sim <- c(0.3,0.7)

# simulated constants
beta_0_sim <- c(4.75,5)

# simulated linear trend components
beta_1_sim <- c(0.05,0.1)

# load simulation model
sim_m <- stan_model("Model3/SimulationModel_Model3MultipleClasses.stan")

# number of simulation runs
R <- 100

# simulation runs
for (r in 1:R) {
  
  # simulate data
  sim_m_fit <- sampling(sim_m,
                        data = list(C = C,
                                    N = N,
                                    T = no_periods,
                                    X = X,
                                    lambda_sim = lambda_sim,
                                    beta_0_sim = beta_0_sim,
                                    beta_1_sim = beta_1_sim),
                        chains = 1,
                        iter = 1,
                        algorithm = "Fixed_param")
  
  # extract simulated data
  sim_m_fit_data <- rstan::extract(sim_m_fit)
  
  # simulated class memberships
  z_sim <- sim_m_fit_data$z_sim[1,]
  
  # save z_sim (transform to data frame beforehand)
  write.xlsx(data.frame(z_sim),
             paste("Model3/SimCase17_zsim_SimRun", r, ".xlsx", sep = ""))
  
  # observed dependent variable
  Y_obs <- sim_m_fit_data$Y_obs[1,,]
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model3/SimCase17_Yobs_SimRun", r, ".xlsx", sep = ""))
  
  # log transform Y_obs
  Y_obs[Y_obs==0] <- 1  # vectorization over n and t
  Y_obs_log <- log(Y_obs)  # vectorization over n and t
  
  # save Y_obs_log (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs_log),
             paste("Model3/SimCase17_Yobslog_SimRun", r, ".xlsx", sep = ""))
  
}


# simulation case 17 version 2 ####
# number of latent classes
C <- 2

# number of individuals
N <- 200

# number of time periods
no_periods <- 10

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated mixture proportions
lambda_sim <- c(0.3,0.7)

# simulated constants
beta_0_sim <- c(4.75,5)

# simulated linear trend components
beta_1_sim <- c(0.05,0.07)

# load simulation model
sim_m <- stan_model("Model3/SimulationModel_Model3MultipleClasses.stan")

# number of simulation runs
R <- 5

# simulation runs
for (r in 1:R) {
  
  # simulate data
  sim_m_fit <- sampling(sim_m,
                        data = list(C = C,
                                    N = N,
                                    T = no_periods,
                                    X = X,
                                    lambda_sim = lambda_sim,
                                    beta_0_sim = beta_0_sim,
                                    beta_1_sim = beta_1_sim),
                        chains = 1,
                        iter = 1,
                        algorithm = "Fixed_param")
  
  # extract simulated data
  sim_m_fit_data <- rstan::extract(sim_m_fit)
  
  # simulated class memberships
  z_sim <- sim_m_fit_data$z_sim[1,]
  
  # save z_sim (transform to data frame beforehand)
  write.xlsx(data.frame(z_sim),
             paste("Model3/SimCase17v2_zsim_SimRun", r, ".xlsx", sep = ""))
  
  # observed dependent variable
  Y_obs <- sim_m_fit_data$Y_obs[1,,]
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model3/SimCase17v2_Yobs_SimRun", r, ".xlsx", sep = ""))
  
  # log transform Y_obs
  Y_obs[Y_obs==0] <- 1  # vectorization over n and t
  Y_obs_log <- log(Y_obs)  # vectorization over n and t
  
  # save Y_obs_log (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs_log),
             paste("Model3/SimCase17v2_Yobslog_SimRun", r, ".xlsx", sep = ""))
  
}


# simulation case 18 ####
# number of latent classes
C <- 2

# number of individuals
N <- 200

# number of time periods
no_periods <- 10

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated mixture proportions
lambda_sim <- c(0.3,0.7)

# simulated constants
beta_0_sim <- c(1,5)

# simulated linear trend components
beta_1_sim <- c(0.4,-0.2)

# load simulation model
sim_m <- stan_model("Model3/SimulationModel_Model3MultipleClasses.stan")

# number of simulation runs
R <- 5

# simulation runs
for (r in 1:R) {
  
  # simulate data
  sim_m_fit <- sampling(sim_m,
                        data = list(C = C,
                                    N = N,
                                    T = no_periods,
                                    X = X,
                                    lambda_sim = lambda_sim,
                                    beta_0_sim = beta_0_sim,
                                    beta_1_sim = beta_1_sim),
                        chains = 1,
                        iter = 1,
                        algorithm = "Fixed_param")
  
  # extract simulated data
  sim_m_fit_data <- rstan::extract(sim_m_fit)
  
  # simulated class memberships
  z_sim <- sim_m_fit_data$z_sim[1,]
  
  # save z_sim (transform to data frame beforehand)
  write.xlsx(data.frame(z_sim),
             paste("Model3/SimCase18_zsim_SimRun", r, ".xlsx", sep = ""))
  
  # observed dependent variable
  Y_obs <- sim_m_fit_data$Y_obs[1,,]
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model3/SimCase18_Yobs_SimRun", r, ".xlsx", sep = ""))
  
  # log transform Y_obs
  Y_obs[Y_obs==0] <- 1  # vectorization over n and t
  Y_obs_log <- log(Y_obs)  # vectorization over n and t
  
  # save Y_obs_log (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs_log),
             paste("Model3/SimCase18_Yobslog_SimRun", r, ".xlsx", sep = ""))
  
}


# simulation case 19 ####
# number of latent classes
C <- 3

# number of individuals
N <- 250

# number of time periods
no_periods <- 10

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated mixture proportions
lambda_sim <- c(0.3,0.2,0.5)

# simulated constants
beta_0_sim <- c(1,3,5)

# simulated linear trend components
beta_1_sim <- c(0.4,0.25,0.1)

# load simulation model
sim_m <- stan_model("Model3/SimulationModel_Model3MultipleClasses.stan")

# number of simulation runs
R <- 5

# simulation runs
for (r in 1:R) {
  
  # simulate data
  sim_m_fit <- sampling(sim_m,
                        data = list(C = C,
                                    N = N,
                                    T = no_periods,
                                    X = X,
                                    lambda_sim = lambda_sim,
                                    beta_0_sim = beta_0_sim,
                                    beta_1_sim = beta_1_sim),
                        chains = 1,
                        iter = 1,
                        algorithm = "Fixed_param")
  
  # extract simulated data
  sim_m_fit_data <- rstan::extract(sim_m_fit)
  
  # simulated class memberships
  z_sim <- sim_m_fit_data$z_sim[1,]
  
  # save z_sim (transform to data frame beforehand)
  write.xlsx(data.frame(z_sim),
             paste("Model3/SimCase19_zsim_SimRun", r, ".xlsx", sep = ""))
  
  # observed dependent variable
  Y_obs <- sim_m_fit_data$Y_obs[1,,]
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model3/SimCase19_Yobs_SimRun", r, ".xlsx", sep = ""))
  
  # log transform Y_obs
  Y_obs[Y_obs==0] <- 1  # vectorization over n and t
  Y_obs_log <- log(Y_obs)  # vectorization over n and t
  
  # save Y_obs_log (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs_log),
             paste("Model3/SimCase19_Yobslog_SimRun", r, ".xlsx", sep = ""))
  
}


# simulation case 29 ####
# number of latent classes
C <- 2

# number of individuals
N <- 200

# number of time periods
no_periods <- 10

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated initial mixture proportions
omega_sim <- c(0.3,0.7)

# simulated transition matrix
Psi_sim <- matrix(data = 0, nrow = C, ncol = C)
Psi_sim[1,] <- c(0.99,0.01)
Psi_sim[2,] <- c(0.05,0.95)

# simulated constants
beta_0_sim <- c(-5,10)

# simulated linear trend components
beta_1_sim <- c(-0.5,1)

# simulated standard deviations for Y_obs Normal distributions
sigma_sim <- c(0.25,0.75)

# simulated means for Y_obs Normal distributions
M_sim <- matrix(data = 0, nrow = N, ncol = no_periods)

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)

# number of simulation runs
R <- 5

# simulation runs
for (r in 1:R) {
  
  # simulated class memberships
  Z_sim <- matrix(data = 0, nrow = N, ncol = no_periods)
  Z_sim[,1] <- rcat(n = N, prob = omega_sim)  # vectorization over n
  for (t in 2:no_periods) {
    Z_sim[,t] <- rcat(n = N, prob = Psi_sim[Z_sim[,t-1],])
    # vectorization over n
  }
  
  # save Z_sim (transform to data frame beforehand)
  write.xlsx(data.frame(Z_sim),
             paste("Model5/SimCase29_Zsim_SimRun", r, ".xlsx", sep = ""))
  
  # M_sim
  M_sim <- beta_0_sim[Z_sim] + beta_1_sim[Z_sim] * X
  # vectorization over n and t
  
  # Y_obs
  for (t in 1:no_periods) {
    Y_obs[,t] <- rnorm(n = N, mean = M_sim[,t], sd = sigma_sim[Z_sim[,t]])
    # vectorization over n
  }
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model5/SimCase29_Yobs_SimRun", r, ".xlsx", sep = ""))
  
}


# simulation case 32 ####
# number of latent classes
C <- 3

# number of individuals
N <- 250

# number of time periods
no_periods <- 10

# explanatory variable
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated initial mixture proportions
omega_sim <- c(0.3,0.2,0.5)

# simulated transition matrix
Psi_sim <- matrix(data = 0, nrow = C, ncol = C)
Psi_sim[1,] <- c(0.96,0.01,0.03)
Psi_sim[2,] <- c(0.01,0.97,0.02)
Psi_sim[3,] <- c(0.02,0.03,0.95)

# simulated constants
beta_0_sim <- c(-5,2.5,10)

# simulated linear trend components
beta_1_sim <- c(-0.5,0.5,1)

# simulated standard deviations for Y_obs Normal distributions
sigma_sim <- c(0.25,0.5,0.75)

# simulated means for Y_obs Normal distributions
M_sim <- matrix(data = 0, nrow = N, ncol = no_periods)

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)

# number of simulation runs
R <- 5

# simulation runs
for (r in 1:R) {
  
  # simulated class memberships
  Z_sim <- matrix(data = 0, nrow = N, ncol = no_periods)
  Z_sim[,1] <- rcat(n = N, prob = omega_sim)  # vectorization over n
  for (t in 2:no_periods) {
    Z_sim[,t] <- rcat(n = N, prob = Psi_sim[Z_sim[,t-1],])
    # vectorization over n
  }
  
  # save Z_sim (transform to data frame beforehand)
  write.xlsx(data.frame(Z_sim),
             paste("Model5/SimCase32_Zsim_SimRun", r, ".xlsx", sep = ""))
  
  # M_sim
  M_sim <- beta_0_sim[Z_sim] + beta_1_sim[Z_sim] * X
  # vectorization over n and t
  
  # Y_obs
  for (t in 1:no_periods) {
    Y_obs[,t] <- rnorm(n = N, mean = M_sim[,t], sd = sigma_sim[Z_sim[,t]])
    # vectorization over n
  }
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model5/SimCase32_Yobs_SimRun", r, ".xlsx", sep = ""))
  
}


