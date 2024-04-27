# closing the sections provides an overview of the script


# README ####
# how to use this file?
# firstly, run the preparation section.
# secondly, run one or several dataset sections; in any order.

# required file for dataset 15 section:
# SimulationModel_DS15.stan

# required file for dataset 16 section:
# SimulationModel_DS16.stan


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


# dataset 1 - model 1 baseline ####
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
for (n in 1:N) {
  mu <- beta_0_sim + beta_1_sim * X[n,]
  # simulated means for Y_obs Normal distributions, vectorization over t
  
  Y_obs[n,] <- rnorm(n = no_periods, mean = mu, sd = sigma_sim)
  # vectorization over t
}

# save Y_obs (transform to data frame beforehand)
write.xlsx(data.frame(Y_obs), "Dataset1_Yobs.xlsx")


# dataset 2 - model 1 two classes - no overlaps between classes ####
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
z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization

# save z_sim (transform to data frame beforehand)
write.xlsx(data.frame(z_sim), "Dataset2_zsim.xlsx")

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


# dataset 3 - model 1 two classes - overlapping constants ####
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
z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization

# save z_sim (transform to data frame beforehand)
write.xlsx(data.frame(z_sim), "Dataset3_zsim.xlsx")

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


# dataset 4 - model 1 two classes - intersecting trends ####
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
z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization

# save z_sim (transform to data frame beforehand)
write.xlsx(data.frame(z_sim), "Dataset4_zsim.xlsx")

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


# dataset 5 - model 1 three classes - no overlaps between classes ####
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
z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization

# save z_sim (transform to data frame beforehand)
write.xlsx(data.frame(z_sim), "Dataset5_zsim.xlsx")

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


# dataset 6 - model 1 three classes - overlapping constants ####
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
z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization

# save z_sim (transform to data frame beforehand)
write.xlsx(data.frame(z_sim), "Dataset6_zsim.xlsx")

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


# dataset 15 - model 3 baseline ####
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
sim_m <- stan_model("SimulationModel_DS15.stan")

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
write.xlsx(data.frame(Y_obs), "Dataset15_Yobs.xlsx")


# dataset 16 - model 3 two classes - no overlaps between classes ####
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
sim_m <- stan_model("SimulationModel_DS16.stan")

job::job({
  
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
  
})

# extract simulated data
sim_m_fit_data <- rstan::extract(sim_m_fit)

# simulated class memberships
z_sim <- sim_m_fit_data$z_sim[1,]

# save z_sim (transform to data frame beforehand)
write.xlsx(data.frame(z_sim), "Dataset16_zsim.xlsx")

# observed dependent variable
Y_obs <- sim_m_fit_data$Y_obs[1,,]

# save Y_obs (transform to data frame beforehand)
write.xlsx(data.frame(Y_obs), "Dataset16_Yobs.xlsx")

# log transform Y_obs
Y_obs[Y_obs==0] <- 1
Y_obs_log <- log(Y_obs)

# save Y_obs_log (transform to data frame beforehand)
write.xlsx(data.frame(Y_obs_log), "Dataset16_Yobslog.xlsx")


