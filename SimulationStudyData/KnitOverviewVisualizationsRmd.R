# README
# required file from SimulationStudyData folder:
# Overview.Rmd

# CTR + ALT + R runs the entire R script


# set working directory
setwd("C:/Users/Diiim/Documents/GitHub/BayesianGMMs/SimulationStudyData")

# clean workspace
rm(list = ls())

# clean garbage
gc()

# set decimals to digits instead of scientific
options(scipen = 999)

# load packages
library(rmarkdown)

# knit Overview.Rmd
rmarkdown::render("OverviewVisualizations.Rmd", envir = new.env())