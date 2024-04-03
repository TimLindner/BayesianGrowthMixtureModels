# closing the sections provides an overview of the script


# preparation ####
# set working directory
setwd("C:/Users/Diiim/Documents/ResearchAssistance/SimulationStudyData")

# clean workspace
rm(list = ls())

# clean garbage
gc()

# set decimals to digits instead of scientific
options(scipen = 999)

# load packages
library(openxlsx)


# model 1 baseline ####
# number of individuals
N <- 200

# number of time periods
no_periods <- 10

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated constant
beta_0_sim <- 6

# simulated linear trend component
beta_1_sim <- 1

# simulated means for Normal distributions
M_sim <- matrix(data = 0, nrow = N, ncol = no_periods) 
for (t in 1:no_periods) {
  for (n in 1:N) {
    M_sim[n,t] <- beta_0_sim + beta_1_sim * X[n,t]
  }
}

# simulated standard deviation for Normal distributions
sigma_sim <- 0.75

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)
for (t in 1:no_periods) {
  for (n in 1:N) {
    Y_obs[n,t] <- rnorm(1, mean = M_sim[n,t], sd = sigma_sim)
  }
}

# save Y_obs ( transformed to data frame beforehand )
write.xlsx(data.frame(Y_obs), "Model1Baseline_Yobs.xlsx")


# model 1 two classes ####
# number of simulated classes
C_sim <- 2

# number of individuals
N <- 400

# number of time periods
no_periods <- 10

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated mixture proportions step 1
Pi_sim <- matrix(data = 0, nrow = N, ncol = C_sim)
for (n in 1:round(N/2)) {
  Pi_sim[n,] <- c(0.9,0.1)
}

# simulated mixture proportions step 2
for (n in (round(N/2)+1):N) {
  Pi_sim[n,] <- c(0.1,0.9)
}

# simulated constants
beta_0_sim <- c(-5,6)

# simulated linear trend components
beta_1_sim <- c(-0.5,1)

# simulated means for Normal distributions step 1
M_sim_mtx <- matrix(data = 0, nrow = N, ncol = no_periods)
M_sim <- list()
for (c in 1:C_sim) {
  M_sim[[c]] <- M_sim_mtx
}

# simulated means for Normal distributions step 2
for (c in 1:C_sim) {
  for (t in 1:no_periods) {
    for (n in 1:N) {
      M_sim[[c]][n,t] <- beta_0_sim[c] + beta_1_sim[c] * X[n,t]
    }
  }
}

# simulated standard deviations for Normal distributions
sigma_sim <- c(0.25,0.75)

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)
for (c in 1:C_sim) {
  for (t in 1:no_periods) {
    for (n in 1:N) {
      Y_obs[n,t] <-
        Y_obs[n,t]+Pi_sim[n,c]*rnorm(n=1,mean=M_sim[[c]][n,t],sd=sigma_sim)
    }
  }
}

# save Y_obs ( transformed to data frame beforehand )
# uncomment the next line to run the line
write.xlsx(data.frame(Y_obs), "Model1TwoClasses_Yobs.xlsx")


