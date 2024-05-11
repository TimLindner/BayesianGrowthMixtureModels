# README ####
# closing the sections provides an overview of this R script.

# how to use this R script?
# firstly, run the preparation section.
# secondly, run one or several simulation case sections; in any order.

# required file for simulation case 15 section from SimulationStudyData/Model3
# folder:
# SimulationModel_Model3Baseline.stan

# required file for simulation case 16 section from SimulationStudyData/Model3
# folder:
# SimulationModel_Model3MultipleClasses.stan

# required file for simulation case 17 section from SimulationStudyData/Model3
# folder:
# SimulationModel_Model3MultipleClasses.stan

# required file for simulation case 18 section from SimulationStudyData/Model3
# folder:
# SimulationModel_Model3MultipleClasses.stan


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
  
  for (t in 1:no_periods) {
    Y_obs[,t] <- rnorm(n = N, mean = M_sim[,t], sd = sigma_sim)
    # vectorization over n
  }
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model1/SimCase1_Yobs_SimRun", r, ".xlsx", sep = ""))
  
}


# simulation case 2 ####
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

# simulated class memberships
z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization over n

# save z_sim (transform to data frame beforehand)
write.xlsx(data.frame(z_sim), "Model1/Dataset2_zsim.xlsx")

# simulated constants
beta_0_sim <- c(-5,10)

# simulated linear trend components
beta_1_sim <- c(-0.5,1)

# simulated standard deviations for Y_obs Normal distributions
sigma_sim <- c(0.25,0.75)

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)
for (n in 1:N) {
  mu <- beta_0_sim[z_sim[n]] + beta_1_sim[z_sim[n]] * X[n,]
  # simulated means for Y_obs Normal distributions, vectorization over t
  
  Y_obs[n,] <-
    rnorm(n = no_periods, mean = mu, sd = sigma_sim[z_sim[n]])
  # vectorization over t
}

# save Y_obs (transform to data frame beforehand)
write.xlsx(data.frame(Y_obs), "Dataset2_Yobs.xlsx")


# simulation case 3 ####
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

# simulated class memberships
z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization over n

# save z_sim (transform to data frame beforehand)
write.xlsx(data.frame(z_sim), "Model1/Dataset3_zsim.xlsx")

# simulated constants
beta_0_sim <- c(2,3)

# simulated linear trend components
beta_1_sim <- c(-0.5,1)

# simulated standard deviations for Y_obs Normal distributions
sigma_sim <- c(0.25,0.75)

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)
for (n in 1:N) {
  mu <- beta_0_sim[z_sim[n]] + beta_1_sim[z_sim[n]] * X[n,]
  # simulated means for Y_obs Normal distributions, vectorization over t
  
  Y_obs[n,] <-
    rnorm(n = no_periods, mean = mu, sd = sigma_sim[z_sim[n]])
  # vectorization over t
}

# save Y_obs (transform to data frame beforehand)
write.xlsx(data.frame(Y_obs), "Dataset3_Yobs.xlsx")


# simulation case 4 ####
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

# simulated class memberships
z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization over n

# save z_sim (transform to data frame beforehand)
write.xlsx(data.frame(z_sim), "Model1/Dataset4_zsim.xlsx")

# simulated constants
beta_0_sim <- c(-5,10)

# simulated linear trend components
beta_1_sim <- c(1,-2)

# simulated standard deviations for Y_obs Normal distributions
sigma_sim <- c(0.25,0.75)

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)
for (n in 1:N) {
  mu <- beta_0_sim[z_sim[n]] + beta_1_sim[z_sim[n]] * X[n,]
  # simulated means for Y_obs Normal distributions, vectorization over t
  
  Y_obs[n,] <-
    rnorm(n = no_periods, mean = mu, sd = sigma_sim[z_sim[n]])
  # vectorization over t
}

# save Y_obs (transform to data frame beforehand)
write.xlsx(data.frame(Y_obs), "Dataset4_Yobs.xlsx")


# simulation case 5 ####
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

# simulated class memberships
z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization over n

# save z_sim (transform to data frame beforehand)
write.xlsx(data.frame(z_sim), "Model1/Dataset5_zsim.xlsx")

# simulated constants
beta_0_sim <- c(-5,2.5,10)

# simulated linear trend components
beta_1_sim <- c(-0.5,0.5,1)

# simulated standard deviations for Y_obs Normal distributions
sigma_sim <- c(0.25,0.5,0.75)

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)
for (n in 1:N) {
  mu <- beta_0_sim[z_sim[n]] + beta_1_sim[z_sim[n]] * X[n,]
  # simulated means for Y_obs Normal distributions, vectorization over t
  
  Y_obs[n,] <-
    rnorm(n = no_periods, mean = mu, sd = sigma_sim[z_sim[n]])
  # vectorization over t
}

# save Y_obs (transform to data frame beforehand)
write.xlsx(data.frame(Y_obs), "Dataset5_Yobs.xlsx")


# simulation case 6 ####
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

# simulated class memberships
z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization over n

# save z_sim (transform to data frame beforehand)
write.xlsx(data.frame(z_sim), "Model1/Dataset6_zsim.xlsx")

# simulated constants
beta_0_sim <- c(1.5,2.5,3.5)

# simulated linear trend components
beta_1_sim <- c(-0.5,0.5,1)

# simulated standard deviations for Y_obs Normal distributions
sigma_sim <- c(0.25,0.5,0.75)

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)
for (n in 1:N) {
  # simulated means for Y_obs Normal distributions
  mu <- beta_0_sim[z_sim[n]] + beta_1_sim[z_sim[n]] * X[n,]
  # simulated means for Y_obs Normal distributions, vectorization over t
  
  Y_obs[n,] <-
    rnorm(n = no_periods, mean = mu, sd = sigma_sim[z_sim[n]])
  # vectorization over t
}

# save Y_obs (transform to data frame beforehand)
write.xlsx(data.frame(Y_obs), "Dataset6_Yobs.xlsx")


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

job::job({
  
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
  
})

# extract simulated data
sim_m_fit_data <- rstan::extract(sim_m_fit)

# observed dependent variable
Y_obs <- sim_m_fit_data$Y_obs[1,,]

# save Y_obs (transform to data frame beforehand)
write.xlsx(data.frame(Y_obs), "Model3/Dataset15_Yobs.xlsx")


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
             paste("Model3/Dataset16_zsim_Run", r, ".xlsx", sep = ""))
  
  # observed dependent variable
  Y_obs <- sim_m_fit_data$Y_obs[1,,]
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model3/Dataset16_Yobs_Run", r, ".xlsx", sep = ""))
  
  # log transform Y_obs
  Y_obs[Y_obs==0] <- 1  # vectorization over n and t
  Y_obs_log <- log(Y_obs)  # vectorization over n and t
  
  # save Y_obs_log (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs_log),
             paste("Model3/Dataset16_Yobslog_Run", r, ".xlsx", sep = ""))
  
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
  
  # M
  for (t in 1:no_periods) {
    M_sim[,t] <- beta_0_sim[Z_sim[,t]] + beta_1_sim[Z_sim[,t]] * X[,t]
    # vectorization over n
  }
  
  # Y_obs
  for (t in 1:no_periods) {
    Y_obs[,t] <- rnorm(n = N, mean = M_sim[,t], sd = sigma_sim[Z_sim[,t]])
    # vectorization over n
  }
  
  # save Y_obs (transform to data frame beforehand)
  write.xlsx(data.frame(Y_obs),
             paste("Model5/SimCase29_Yobs_SimRun", r, ".xlsx", sep = ""))
  
}


