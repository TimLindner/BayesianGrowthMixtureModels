# closing the sections provides an overview of the script


# preparation ####
# set working directory
setwd("C:/Users/Diiim/Documents/ResearchAssistance")

# load packages
library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)


# NUTS parameters ####
algorithm <- "NUTS"
chains <- 4  # default
iter <- 2000  # default
warmup <- floor(iter/2)  # default


# model 1 baseline - estimation ####
# load model
m <- stan_model("ModelImplementation/Model1Baseline.stan")

# observed dependent variable
Y_obs <- Y_sim  # # change Y_sim to Y_act for actual data

# model-specific NUTS parameter
init <- "random"

job::job({
  
  # estimate model
  m_fit <- sampling(m,
                    data = list(N = N,
                                T = no_periods,
                                Y_obs = Y_obs,
                                X = X),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResult/Model1Baseline_Fit.rds")
  
})


# model 1 multiple classes - estimation ####
# load model
m <- stan_model("ModelImplementation/Model1MultipleClasses.stan")

# number of latent classes
C <- 2

# alpha parameter for Dirichlet distributions,
# which serve as prior distributions for mixture proportions
alpha <- rep(1, times = C)

# observed dependent variable
Y_obs <- Y_sim  # # change Y_sim to Y_act for actual data

# model-specific NUTS parameter
init <- "random"

job::job({
  
  # estimate model
  m_fit <- sampling(m,
                    data = list(C = C,
                                alpha = alpha,
                                T = no_periods,
                                Y_obs = Y_obs,
                                X = X),
                    chains = chains,
                    iter = iter,
                    warmup = warmup,
                    init = init,
                    algorithm = algorithm)
  
  # save model fit
  saveRDS(m_fit,
          "SimulationStudyResult/Model1TwoClasses_Fit.rds")
  
})


