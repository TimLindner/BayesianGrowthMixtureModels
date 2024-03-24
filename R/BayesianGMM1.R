# closing the sections provides an overview of the script


# preparations ####
# set working directory
setwd("C:/Users/Diiim/Documents/job_uni/ResearchAssistance/STAN/Model1")

# clean workspace
rm(list = ls())

# clean garbage
gc()

# clear graphics device
# dev.off()

# set decimals to digits instead of scientific
options(scipen = 999)

# load packages
library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)


# data 1 ####
N <- 1000
period <- 0:9
number_of_periods <- length(period)


# data 2 ####
N <- 200
period <- 0:49
number_of_periods <- length(period)

# model 1.1 baseline - estimation ####
# computation with NUTS in STAN
m11 <- stan_model("Model11Baseline.stan")

iter <- 10000

job::job({
  
  fit_m11 <- sampling(m11,
                      data = list(N = N,
                                  T = number_of_periods,
                                  Y_obs = Q,
                                  period = period),
                      iter = iter)
  
  # save fit_m11
  saveRDS(fit_m11,
          "fit_m11.rds")
  
})


# model 1.2 two classes - estimation ####
# computation with NUTS in STAN
m12 <- stan_model("Model12MultipleClasses.stan")

C <- 2
iter <- 10000

job::job({
  
  fit_m12 <- sampling(m12,
                      data = list(N = N,
                                  T = number_of_periods,
                                  Y_obs = Q,
                                  period = period,
                                  C = C),
                      iter = iter)
  
  # save fit_m12
  saveRDS(fit_m12,
          "fit_m12.rds")
  
})


# model 1.3 three classes - estimation ####
# computation with NUTS in STAN
m13 <- stan_model("Model12MultipleClasses.stan")

C <- 3
iter <- 10000

job::job({
  
  fit_m13 <- sampling(m13,
                      data = list(N = N,
                                  T = number_of_periods,
                                  Y_obs = Q,
                                  period = period,
                                  C = C),
                      iter = iter)
  
  # save fit_m13
  saveRDS(fit_m13,
          "fit_m13.rds")
  
})


