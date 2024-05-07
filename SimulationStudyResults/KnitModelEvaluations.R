# README ####
# closing the sections provides an overview of this R script.

# how to use this R script?
# firstly, run the preparation section.
# secondly, run one or several model sections; in any order.

# required file for model 1 baseline - dataset 1 - Yobs - runs 1,...,5 section
# from SimulationStudyResults/Model1 folder:
# Model1Baseline_Dataset1_Yobs_Runr.Rmd

# required file for
# model 1 two classes - ident err - dataset 17 - Yobs - Yobs - runs 1,...,5
# section from SimulationStudyResults/Model1 folder:
# Model1TwoClasses_IdentErr_Dataset17_Yobslog_Runr.Rmd

# required file for
# model 3 two classes - dataset 17 - Yobs - Yobs - runs 1,...,5 section from
# SimulationStudyResults/Model3 folder:
# Model3TwoClasses_Dataset17_Yobs_Runr.Rmd

# required file for model 5 two classes - dataset 29 - Yobs - runs 1,...,5
# section from SimulationStudyResults/Model5 folder:
# Model5TwoClasses_Dataset29_Yobs_Runr.Rmd


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


# model 1 baseline - dataset 1 - Yobs - runs 1,...,5 ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model1TwoClasses_Dataset1_Yobs_Runr.Rmd with input r
    rmarkdown::render("Model1/Model1Baseline_Dataset1_Yobs_Runr.Rmd",
                      envir = new.env(),
                      output_file = paste("Model1Baseline_Dataset1_Yobs_Run",
                                          r,
                                          sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 1 two classes - ident err - dataset 17 - Yobslog - runs 1,...,5 ####
# number of evaluation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model1TwoClasses_IdentErr_Dataset17_Yobslog_Runr.Rmd with input r
    rmarkdown::render(
      "Model1/Model1TwoClasses_IdentErr_Dataset17_Yobslog_Runr.Rmd",
      envir = new.env(),
      output_file =
        paste("Model1TwoClasses_IdentErr_Dataset17_Yobslog_Run", r, sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 3 two classes - dataset 17 - Yobs - runs 1,...,5 ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model3TwoClasses_Dataset17_Yobs_Runr.Rmd with input r
    rmarkdown::render("Model3/Model3TwoClasses_Dataset17_Yobs_Runr.Rmd",
                      envir = new.env(),
                      output_file = paste(
                        "Model3TwoClasses_Dataset17_Yobs_Run", r, sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 5 two classes - dataset 29 - Yobs - runs 1,...,5 ####
# number of estimation runs
R <- 5

# used to save output file
paste_part_1 <- "Model5TwoClasses_Dataset29_Yobs_Run"

job::job({
  
  for (r in 1:R) {
    
    # knit Model5TwoClasses_Dataset29_Yobs_Runr.1.Rmd with input r
    rmarkdown::render("Model5/Model5TwoClasses_Dataset29_Yobs_Runr.Rmd",
                      envir = new.env(),
                      output_file = paste(
                        "Model5TwoClasses_Dataset29_Yobs_Run", r, sep = ""))
    
  }
  
}, title = "evaluation runs")

