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

# number of time periods
no_periods <- 10

# time periods
time_periods <- 0:(no_periods - 1)
X <- matrix(time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# transform X to vector in column-major order
x_vec <- c(X)


# model 1 baseline ####
# constant
beta_0_sim <- 2

# linear trend
beta_1_sim <- 1

# means for Normal distributions
mu_sim <- beta_0_sim + beta_1_sim * x_vec

# size of mu_sim
mu_sim_size <- length(mu_sim)

# standard deviation for Normal distributions
sigma_sim <- 0.5

# simulated dependent variable
y_sim <- rnorm(n = mu_sim_size, mean = mu_sim, sd = sigma_sim)

# transform y_sim to matrix in column-major order
Y_sim <- matrix(y_sim, nrow = N)

# save Y_sim ( transformed to data frame beforehand )
write.xlsx(data.frame(Y_sim), "Model1_Baseline_Ysim.xlsx")

# load Y_sim
Y_sim <- read_excel("Model1_Baseline_Ysim.xlsx",
                    sheet = "Sheet 1")


# model 1 two classes ####
# number of latent classes
C <- 2

# constants
beta_0 <- c(-5,5)

# linear trends
beta_1 <- c(-0.5,1)

# standard deviations for Normal distributions
sigma <- c(0.25,0.75)

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

# save Y_sim ( transformed to data frame beforehand )
write.xlsx(data.frame(Y_sim), "Model1_TwoClasses_Ysim.xlsx")

# load Y_sim
Y_sim <- read_excel("Model1_TwoClasses_Ysim.xlsx",
                    sheet = "Sheet 1")


