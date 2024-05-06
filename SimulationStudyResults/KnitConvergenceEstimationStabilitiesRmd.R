# README
# required file from SimulationStudyResults folder:
# ConvergenceEstimationStabilities.Rmd

# CTR + ALT + R runs the entire R script


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

# knit ConvergenceEstimationStabilities.Rmd
rmarkdown::render("ConvergenceEstimationStabilities.Rmd")


