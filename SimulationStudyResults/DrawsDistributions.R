# README ####
# closing the sections provides an overview of this R script.

# how to use this R script?
# firstly, run the preparation section.
# secondly, run one or several distribution sections; in any order.

# required file for Dirichlet distribution section from
# SimulationStudyResults/Model5 folder:
# DrawsDirichletDistribution.stan


# preparation ####
# set working directory
setwd("C:/Users/Diiim/Documents/GitHub/BayesianGMMs/SimulationStudyResults")

# clean workspace
rm(list = ls())

# clean garbage
gc()

# set decimals to digits instead of scientific
options(scipen = 999)

# load packages
library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)


# Dirichlet distribution ####
# parameters
alpha <- c(1,1)

# number of latent classes
C <- length(alpha)

# load model
sim_m <- stan_model("DrawsDirichletDistribution.stan")

# simulate data
sim_m_fit <- sampling(sim_m,
                      data = list(C = C,
                                  alpha = alpha),
                      chains = 1,
                      iter = 10,
                      algorithm = "Fixed_param")

# extract simulated data
sim_m_fit_data <- rstan::extract(sim_m_fit)

# draws
sim_m_fit_data$draws


