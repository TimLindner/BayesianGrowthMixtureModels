# closing the sections provides an overview of the script


# preparation ####
# set working directory
setwd("C:/Users/Diiim/Documents/ResearchAssistance/DataSimulation")

# clean workspace
rm(list = ls())

# clean garbage
gc()

# set decimals to digits instead of scientific
options(scipen = 999)

# load packages
library(openxlsx)
library(readxl)


# model 1 general ####
# number of individuals
N <- 30

# time periods
p <- 0:9

# number of time periods
number_of_periods <- length(p)


# model 1 baseline ####
# constant
beta_0 <- -2

# linear trend
beta_1 <- -0.5

# standard deviation for Normal distributions
sigma <- 1

# simulated dependent variable
Y_sim <- matrix(data = 0, nrow = N, ncol = number_of_periods)
for (n in 1:N) {
  for (t in 1:number_of_periods) {
    mu <- beta_0 + beta_1 * p[t]  # means for Normal distributions
    Y_sim[n,t] <- rnorm(n = 1, mean = mu, sd = sigma)
  }
}

# save simulated dependent variable
write.xlsx(Y_sim, "Model1_Baseline_Y.xlsx")

# load simulated dependent variable
Y_sim <- read_excel("DataSimulation/Model1_TwoClasses_Y.xlsx",
                    sheet = "Sheet 1")


# model 1 two classes ####
# number of latent classes
C <- 2

# constants
beta_0 <- c(-2,2)

# linear trends
beta_1 <- c(-0.5,0.5)

# standard deviations for Normal distributions
sigma <- c(1,1)

# mixture proportions
Pi <- matrix(data = NA, nrow = N, ncol = C)
for (n in 1:round(N/2)) {
  Pi[n,] <- c(0.9,0.1)
}
for (n in (round(N/2)+1):N) {
  Pi[n,] <- c(0.1,0.9)
}

# simulated dependent variable
Y_sim <- matrix(data = 0, nrow = N, ncol = number_of_periods)
for (n in 1:N) {
  for (t in 1:number_of_periods) {
    for (c in 1:C) {
      mu <- beta_0[c] + beta_1[c] * p[t]  # means for Normal distributions
      Y_sim[n,t] <-
        Y_sim[n,t] + Pi[n,c] * rnorm(n = 1, mean = mu, sd = sigma[c])
    }
  }
}

# save simulated dependent variable
write.xlsx(Y_sim, "Model1_TwoClasses_Y.xlsx")

# load simulated dependent variable
Y_sim <- read_excel("DataSimulation/Model1_TwoClasses_Y.xlsx",
                    sheet = "Sheet 1")


