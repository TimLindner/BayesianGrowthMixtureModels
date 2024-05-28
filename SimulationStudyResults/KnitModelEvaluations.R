# README ####
# closing the sections provides an overview of this R script.

# how to use this R script? before running a model section, always run the
# preparation section.

# required file for model 1 baseline - sim case 1 Yobs section from
# SimulationStudyResults/Model1 folder:
# Model1Baseline_SimCase1_Yobs_SimRunr_Eval.Rmd

# required file for model 1 two classes - sim case 2 Yobs section from
# SimulationStudyResults/Model1 folder:
# Model1TwoClasses_SimCase2_Yobs_SimRunr_Eval.Rmd

# required file for model 1 three classes - sim case 5 Yobs section from
# SimulationStudyResults/Model1 folder:
# Model1ThreeClasses_SimCase5_Yobs_SimRunr_Eval.Rmd

# required file for model 2 baseline - sim case 8 Yobs section from
# SimulationStudyResults/Model2 folder:
# Model2Baseline_SimCase8_Yobs_SimRunr_Eval.Rmd

# required file for model 2 two classes - sim case 9 Yobs section from
# SimulationStudyResults/Model2 folder:
# Model2TwoClasses_SimCase9_Yobs_SimRunr_Eval.Rmd

# required file for model 2 three classes - sim case 12 Yobs section from
# SimulationStudyResults/Model2 folder:
# Model2ThreeClasses_SimCase12_Yobs_SimRunr_Eval.Rmd

# required file for model 3 baseline - sim case 15 Yobs section from
# SimulationStudyResults/Model3 folder:
# Model3Baseline_SimCase15_Yobs_SimRunr_Eval.Rmd

# required file for
# model 1 two classes ident err - sim case 16 Yobslog section from
# SimulationStudyResults/Model1 folder:
# Model1TwoClasses_IdentErr_Dataset16_Yobslog_SimRunr_Eval.Rmd

# required file for model 3 two classes - sim case 16 Yobs section from
# SimulationStudyResults/Model3 folder:
# Model3TwoClasses_Dataset16_Yobs_SimRunr_Eval.Rmd

# required file for
# model 1 two classes ident err - sim case 17 Yobslog section from
# SimulationStudyResults/Model1 folder:
# Model1TwoClasses_IdentErr_Dataset17_Yobslog_SimRunr_Eval.Rmd

# required file for model 3 two classes - sim case 17 Yobs section from
# SimulationStudyResults/Model3 folder:
# Model3TwoClasses_Dataset17_Yobs_SimRunr_Eval.Rmd

# required file for
# model 1 two classes ident err - sim case 18 Yobslog section from
# SimulationStudyResults/Model1 folder:
# Model1TwoClasses_IdentErr_Dataset18_Yobslog_SimRunr_Eval.Rmd

# required file for model 3 two classes - sim case 18 Yobs section from
# SimulationStudyResults/Model3 folder:
# Model3TwoClasses_Dataset18_Yobs_SimRunr_Eval.Rmd

# required file for
# model 1 three classes ident err - sim case 19 Yobslog section from
# SimulationStudyResults/Model1 folder:
# Model1ThreeClasses_IdentErr_Dataset19_Yobslog_SimRunr_Eval.Rmd

# required file for model 3 three classes - sim case 19 Yobs section from
# SimulationStudyResults/Model3 folder:
# Model3ThreeClasses_Dataset19_Yobs_SimRunr_Eval.Rmd

# required file for model 5 two classes - sim case 29 Yobs section from
# SimulationStudyResults/Model5 folder:
# Model5TwoClasses_Dataset29_Yobs_SimRunr_Eval.Rmd

# required file for model 5 three classes - sim case 32 Yobs section from
# SimulationStudyResults/Model5 folder:
# Model5ThreeClasses_Dataset32_Yobs_SimRunr_Eval.Rmd


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


# model 1 baseline - sim case 1 Yobs ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model1Baseline_SimCase1_Yobs_SimRunr_Eval.Rmd with input r
    rmarkdown::render("Model1/Model1Baseline_SimCase1_Yobs_SimRunr_Eval.Rmd",
                      envir = new.env(),
                      output_file = paste("Model1Baseline_SimCase1_Yobs_SimRun",
                                          r,
                                          "_Eval",
                                          sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 1 two classes - sim case 2 Yobs ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model1TwoClasses_SimCase2_Yobs_SimRunr_Eval.Rmd with input r
    rmarkdown::render("Model1/Model1TwoClasses_SimCase2_Yobs_SimRunr_Eval.Rmd",
                      envir = new.env(),
                      output_file =
                        paste("Model1TwoClasses_SimCase2_Yobs_SimRun",
                              r,
                              "_Eval",
                              sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 1 three classes - sim case 5 Yobs ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model1ThreeClasses_SimCase5_Yobs_SimRunr_Eval.Rmd with input r
    rmarkdown::render(
      "Model1/Model1ThreeClasses_SimCase5_Yobs_SimRunr_Eval.Rmd",
      envir = new.env(),
      output_file = paste(
        "Model1ThreeClasses_SimCase5_Yobs_SimRun", r, "_Eval", sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 2 baseline - sim case 8 Yobs ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model2Baseline_SimCase8_Yobs_SimRunr_Eval.Rmd with input r
    rmarkdown::render("Model2/Model2Baseline_SimCase8_Yobs_SimRunr_Eval.Rmd",
                      envir = new.env(),
                      output_file = paste("Model2Baseline_SimCase8_Yobs_SimRun",
                                          r,
                                          "_Eval",
                                          sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 2 two classes - sim case 9 Yobs ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model2TwoClasses_SimCase9_Yobs_SimRunr_Eval.Rmd with input r
    rmarkdown::render("Model2/Model2TwoClasses_SimCase9_Yobs_SimRunr_Eval.Rmd",
                      envir = new.env(),
                      output_file =
                        paste("Model2TwoClasses_SimCase9_Yobs_SimRun",
                              r,
                              "_Eval",
                              sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 2 three classes - sim case 12 Yobs ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model2ThreeClasses_SimCase12_Yobs_SimRunr_Eval.Rmd with input r
    rmarkdown::render(
      "Model2/Model2ThreeClasses_SimCase12_Yobs_SimRunr_Eval.Rmd",
      envir = new.env(),
      output_file = paste(
        "Model2ThreeClasses_SimCase12_Yobs_SimRun", r, "_Eval", sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 3 baseline - sim case 15 Yobs ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model3Baseline_SimCase15_Yobs_SimRunr_Eval.Rmd with input r
    rmarkdown::render("Model3/Model3Baseline_SimCase15_Yobs_SimRunr_Eval.Rmd",
                      envir = new.env(),
                      output_file = paste(
                        "Model3Baseline_SimCase15_Yobs_SimRun",
                        r,
                        "_Eval",
                        sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 1 two classes ident err - sim case 16 Yobslog ####
# number of evaluation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model1TwoClasses_IdentErr_SimCase16_Yobslog_SimRunr_Eval.Rmd with
    # input r
    rmarkdown::render(
      "Model1/Model1TwoClasses_IdentErr_SimCase16_Yobslog_SimRunr_Eval.Rmd",
      envir = new.env(),
      output_file =
        paste("Model1TwoClasses_IdentErr_SimCase16_Yobslog_SimRun",
              r,
              "_Eval",
              sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 3 two classes - sim case 16 Yobs ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model3TwoClasses_SimCase16_Yobs_SimRunr_Eval.Rmd with input r
    rmarkdown::render("Model3/Model3TwoClasses_SimCase16_Yobs_SimRunr_Eval.Rmd",
                      envir = new.env(),
                      output_file =
                        paste("Model3TwoClasses_SimCase16_Yobs_SimRun",
                              r,
                              "_Eval",
                              sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 1 two classes ident err - sim case 17 Yobslog ####
# number of evaluation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model1TwoClasses_IdentErr_SimCase17_Yobslog_SimRunr_Eval.Rmd with
    # input r
    rmarkdown::render(
      "Model1/Model1TwoClasses_IdentErr_SimCase17_Yobslog_SimRunr_Eval.Rmd",
      envir = new.env(),
      output_file =
        paste("Model1TwoClasses_IdentErr_SimCase17_Yobslog_SimRun",
              r,
              "_Eval",
              sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 3 two classes - sim case 17 Yobs ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model3TwoClasses_SimCase17_Yobs_SimRunr_Eval.Rmd with input r
    rmarkdown::render("Model3/Model3TwoClasses_SimCase17_Yobs_SimRunr_Eval.Rmd",
                      envir = new.env(),
                      output_file =
                        paste("Model3TwoClasses_SimCase17_Yobs_SimRun",
                              r,
                              "_Eval",
                              sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 1 two classes ident err - sim case 18 Yobslog ####
# number of evaluation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model1TwoClasses_IdentErr_SimCase18_Yobslog_SimRunr_Eval.Rmd with
    # input r
    rmarkdown::render(
      "Model1/Model1TwoClasses_IdentErr_SimCase18_Yobslog_SimRunr_Eval.Rmd",
      envir = new.env(),
      output_file =
        paste("Model1TwoClasses_IdentErr_SimCase18_Yobslog_SimRun",
              r,
              "_Eval",
              sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 3 two classes - sim case 18 Yobs ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model3TwoClasses_SimCase18_Yobs_SimRunr_Eval.Rmd with input r
    rmarkdown::render("Model3/Model3TwoClasses_SimCase18_Yobs_SimRunr_Eval.Rmd",
                      envir = new.env(),
                      output_file =
                        paste("Model3TwoClasses_SimCase18_Yobs_SimRun",
                              r,
                              "_Eval",
                              sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 1 three classes ident err - sim case 19 Yobslog ####
# number of evaluation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model1ThreeClasses_IdentErr_SimCase19_Yobslog_SimRunr_Eval.Rmd with
    # input r
    rmarkdown::render(
      "Model1/Model1ThreeClasses_IdentErr_SimCase19_Yobslog_SimRunr_Eval.Rmd",
      envir = new.env(),
      output_file =
        paste("Model1ThreeClasses_IdentErr_SimCase19_Yobslog_SimRun",
              r,
              "_Eval",
              sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 3 three classes - sim case 19 Yobs ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model3ThreeClasses_SimCase19_Yobs_SimRunr_Eval.Rmd with input r
    rmarkdown::render(
      "Model3/Model3ThreeClasses_SimCase19_Yobs_SimRunr_Eval.Rmd",
      envir = new.env(),
      output_file =
        paste("Model3ThreeClasses_SimCase19_Yobs_SimRun",
              r,
              "_Eval",
              sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 5 two classes - sim case 29 Yobs ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model5TwoClasses_SimCase29_Yobs_SimRunr_Eval.Rmd with input r
    rmarkdown::render("Model5/Model5TwoClasses_SimCase29_Yobs_SimRunr_Eval.Rmd",
                      envir = new.env(),
                      output_file =
                        paste("Model5TwoClasses_SimCase29_Yobs_SimRun",
                              r,
                              "_Eval",
                              sep = ""))
    
  }
  
}, title = "evaluation runs")


# model 5 three classes - sim case 32 Yobs ####
# number of estimation runs
R <- 5

job::job({
  
  for (r in 1:R) {
    
    # knit Model5ThreeClasses_SimCase32_Yobs_SimRunr_Eval.Rmd with input r
    rmarkdown::render(
      "Model5/Model5ThreeClasses_SimCase32_Yobs_SimRunr_Eval.Rmd",
      envir = new.env(),
      output_file = paste(
        "Model5ThreeClasses_SimCase32_Yobs_SimRun", r, "_Eval", sep = ""))
    
  }
  
}, title = "evaluation runs")


