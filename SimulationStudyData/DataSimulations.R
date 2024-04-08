# closing the sections provides an overview of the script


# README ####
# how to use this file?
# firstly, run the preparation section.
# secondly, run one or several dataset sections ( in any order ).

# a note on the R code:
# data structures are best traversed in the order in which they are stored.
# in R, matrices store their data in column-major order.


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
library(extraDistr)


# dataset 1 - model 1 baseline ####
# number of individuals
N <- 50

# number of time periods
no_periods <- 10

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated constant
beta_0_sim <- 10

# simulated linear trend component
beta_1_sim <- 1

# simulated means for Y_obs Normal distributions
M_sim <- matrix(data = 0, nrow = N, ncol = no_periods) 
for (t in 1:no_periods) {
  M_sim[,t] <- beta_0_sim + beta_1_sim * X[,t]  # vectorization
}

# simulated standard deviation for Y_obs Normal distributions
sigma_sim <- 0.75

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)
for (t in 1:no_periods) {
  Y_obs[,t] <- rnorm(n = N, mean = M_sim[,t], sd = sigma_sim)  # vectorization
}

# save Y_obs ( transformed to data frame beforehand )
write.xlsx(data.frame(Y_obs), "Dataset1_Yobs.xlsx")


# dataset 2 - model 1 two classes - no overlaps between classes ####
# number of simulated classes
C <- 2

# number of individuals
N <- 200

# number of time periods
no_periods <- 10

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated mixture proportions
lambda_sim <- c(0.3,0.7)

# simulated class memberships
z_sim <- rcat(n = N, prob = lambda_sim)  # vectorization

# simulated constants
beta_0_sim <- c(-5,10)

# simulated linear trend components
beta_1_sim <- c(-0.5,1)

# simulated means for Y_obs Normal distributions
M_sim <- matrix(data = 0, nrow = N, ncol = no_periods)
for (t in 1:no_periods) {
  for (n in 1:N) {
    M_sim[n,t] <- beta_0_sim[z_sim[n]] + beta_1_sim[z_sim[n]] * X[n,t]
  }
}

# simulated standard deviations for Y_obs Normal distributions
sigma_sim <- c(0.25,0.75)

# observed dependent variable
Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)
for (t in 1:no_periods) {
  for (n in 1:N) {
    Y_obs[n,t] <- rnorm(n = 1, mean = M_sim[n,t], sd = sigma_sim)
  }
}

# save Y_obs ( transformed to data frame beforehand )
write.xlsx(data.frame(Y_obs), "Dataset2_Yobs.xlsx")


# dataset 3 - model 1 two classes - overlapping constants ####
# placeholder


# dataset 4 - model 1 two classes - intersecting trends ####
# placeholder


