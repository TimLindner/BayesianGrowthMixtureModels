# closing the sections provides an overview of the script


# README ####
# required files:
# Model1Baseline_Ysim.xlsx ( to load Y_sim for model 1 baseline )
# Model1TwoClasses_Ysim.xlsx ( to load Y_sim for model 1 two classes )


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


# model 1 baseline ####
# number of individuals
# uncomment the next line to run the line
#N <- 200

# number of time periods
# uncomment the next line to run the line
#no_periods <- 10

# time periods
# uncomment the following lines to run the lines
#time_periods <- 0:(no_periods-1)
#X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated constant
# uncomment the next line to run the line
#beta_0_sim <- 6

# simulated linear trend component
# uncomment the next line to run the line
#beta_1_sim <- 1

# simulated means for Normal distributions
# uncomment the following lines to run the lines
#M_sim <- matrix(data = 0, nrow = N, ncol = no_periods) 
#for (t in 1:no_periods) {
  #for (n in 1:N) {
    #M_sim[n,t] <- beta_0_sim + beta_1_sim * X[n,t]
  #}
#}

# simulated standard deviation for Normal distributions
# uncomment the next line to run the line
#sigma_sim <- 0.75

# observed dependent variable
# uncomment the following lines to run the lines
#Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)
#for (t in 1:no_periods) {
  #for (n in 1:N) {
    #Y_obs[n,t] <- rnorm(1, mean = M_sim[n,t], sd = sigma_sim)
  #}
#}

# save Y_obs ( transformed to data frame beforehand )
# uncomment the next line to run the line
#write.xlsx(data.frame(Y_obs), "Model1Baseline_Yobs.xlsx")

# load observed dependent variable
Y_obs <- data.frame(read_excel("Model1Baseline_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)


# model 1 two classes ####
# number of simulated classes
# uncomment the next line to run the line
#C_sim <- 2

# number of individuals
# uncomment the next line to run the line
#N <- 400

# number of time periods
# uncomment the next line to run the line
#no_periods <- 10

# time periods
# uncomment the following lines to run the lines
#time_periods <- 0:(no_periods-1)
#X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)

# simulated mixture proportions step 1
# uncomment the following lines to run the lines
#Pi_sim <- matrix(data = 0, nrow = N, ncol = C_sim)
#for (n in 1:round(N/2)) {
  #Pi_sim[n,] <- c(0.9,0.1)
#}

# simulated mixture proportions step 2
# uncomment the following lines to run the lines
#for (n in (round(N/2)+1):N) {
  #Pi_sim[n,] <- c(0.1,0.9)
#}

# simulated constants
# uncomment the next line to run the line
#beta_0_sim <- c(-5,6)

# simulated linear trend components
# uncomment the next line to run the line
#beta_1_sim <- c(-0.5,1)

# simulated means for Normal distributions step 1
# uncomment the following lines to run the lines
# M_sim_mtx <- matrix(data = 0, nrow = N, ncol = no_periods)
# M_sim <- list()
#for (c in 1:C_sim) {
  #M_sim[[c]] <- M_sim_mtx
#}

# simulated means for Normal distributions step 2
# uncomment the following lines to run the lines
#for (c in 1:C_sim) {
  #for (t in 1:no_periods) {
    #for (n in 1:N) {
      #M_sim[[c]][n,t] <- beta_0_sim[c] + beta_1_sim[c] * X[n,t]
    #}
  #}
#}

# simulated standard deviations for Normal distributions
# uncomment the next line to run the line
#sigma_sim <- c(0.25,0.75)

# observed dependent variable
# uncomment the following lines to run the lines
#Y_obs <- matrix(data = 0, nrow = N, ncol = no_periods)
#for (c in 1:C_sim) {
  #for (t in 1:no_periods) {
    #for (n in 1:N) {
      #Y_obs[n,t] <-
        #Y_obs[n,t]+Pi_sim[n,c]*rnorm(n=1,mean=M_sim[[c]][n,t],sd=sigma_sim)
    #}
  #}
#}

# save Y_obs ( transformed to data frame beforehand )
# uncomment the next line to run the line
#write.xlsx(data.frame(Y_obs), "Model1TwoClasses_Yobs.xlsx")

# load observed dependent variable
Y_obs <- data.frame(read_excel("Model1TwoClasses_Yobs.xlsx",
                               sheet = "Sheet 1"))

# number of individuals
N <- dim(Y_obs)[1]

# number of time periods
no_periods <- dim(Y_obs)[2]

# time periods
time_periods <- 0:(no_periods-1)
X <- matrix(data = time_periods, nrow = N, ncol = no_periods, byrow = TRUE)


