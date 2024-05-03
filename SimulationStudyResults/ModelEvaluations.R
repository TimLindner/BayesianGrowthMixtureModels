# README ####
# closing the sections provides an overview of this R script.

# how to use this R script?
# firstly, run the preparation section.
# secondly, run one or several model sections; in any order.

# required file for model 1 baseline - dataset 1 section:
# Model1Baseline_Dataset1_Yobs_Runr.Rmd


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
library(rmarkdown)


# model 1 baseline - dataset 1 - Yobs ####
# number of estimation runs
R <- 5

for (r in 1:R) {
  
  # knit Model1Baseline_Dataset1_Yobs_Runr.Rmd with input r
  job::job({
    
    rmarkdown::render("Model1/Model1Baseline_Dataset1_Yobs_Runr.Rmd",
                      output_file = paste("Model1Baseline_Dataset1_Yobs_Run",
                                          r,
                                          sep = ""))
    
  })
  
}


