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
library(readxl)


# model 1 general ####
# number of individuals
N <- 30

# number of time periods
no_periods <- 10

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)


# model 1 baseline ####
# constant
beta_0_sim <- 5

# linear trend component
beta_1_sim <- 0.5

# means for Normal distributions
# uncomment the following lines to run the lines
#M_sim <- matrix(data = 0, nrow = N, ncol = no_periods) 
#for (t in 1:no_periods) {
  #for (n in 1:N) {
    #M_sim[n,t] <- beta_0_sim + beta_1_sim * X[n,t]
  #}
#}

# standard deviation for Normal distributions
sigma_sim <- 0.75

# simulated dependent variable
# uncomment the following lines to run the lines
#Y_sim <- matrix(data = 0, nrow = N, ncol = no_periods)
#for (t in 1:no_periods) {
  #for (n in 1:N) {
    #Y_sim[n,t] <- rnorm(1, mean = M_sim[n,t], sd = sigma_sim)
  #}
#}

# save Y_sim ( transformed to data frame beforehand )
# uncomment the next line to run the line
#write.xlsx(data.frame(Y_sim), "Model1Baseline_Ysim.xlsx")

# load Y_sim
Y_sim <- data.frame(read_excel("Model1Baseline_Ysim.xlsx",
                               sheet = "Sheet 1"))


# model 1 two classes ####
# number of latent classes
C <- 2

# constants
beta_0_sim <- c(-5,6)

# linear trend components
beta_1_sim <- c(-0.5,1)

# means for Normal distributions step 1
# uncomment the following lines to run the lines
#M_sim_mtx <- matrix(data = 0, nrow = N, ncol = no_periods)
#M_sim <- list()
#for (c in 1:C) {
  #M_sim[[c]] <- M_sim_mtx
#}

# means for Normal distributions step 2
# uncomment the following lines to run the lines
#for (c in 1:C) {
  #for (t in 1:no_periods) {
    #for (n in 1:N) {
      #M_sim[[c]][n,t] <- beta_0_sim[c] + beta_1_sim[c] * X[n,t]
    #}
  #}
#}

# standard deviation for Normal distributions
sigma_sim <- c(0.25,0.75)

# mixture proportions step 1
Pi_sim <- matrix(data = 0, nrow = N, ncol = C)
for (n in 1:round(N/2)) {
  Pi_sim[n,] <- c(0.9,0.1)
}

# mixture proportions step 2
for (n in (round(N/2)+1):N) {
  Pi_sim[n,] <- c(0.1,0.9)
}

# simulated dependent variable
# uncomment the following lines to run the lines
#Y_sim <- matrix(data = 0, nrow = N, ncol = no_periods)
#for (c in 1:C) {
  #for (t in 1:no_periods) {
    #for (n in 1:N) {
      #Y_sim[n,t] <-
        #Y_sim[n,t]+Pi_sim[n,c]*rnorm(n=1,mean=M_sim[[c]][n,t],sd=sigma_sim)
    #}
  #}
#}

# save Y_sim ( transformed to data frame beforehand )
# uncomment the next line to run the line
#write.xlsx(data.frame(Y_sim), "Model1TwoClasses_Ysim.xlsx")

# load Y_sim
Y_sim <- data.frame(read_excel("Model1TwoClasses_Ysim.xlsx",
                               sheet = "Sheet 1"))


