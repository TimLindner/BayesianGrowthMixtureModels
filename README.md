> Please note that this repository is work in progress :hammer:

### To-do checklist
- [ ] In the introduction, indicate what is the goal of this repository
- [ ] Include R reference plus R packages used
- [ ] Create a test to check for newer versions of packages and bonus to have it in a CI
- [ ] Rework model 1 - simulation cases 2, 3, 4, 5, 6, and 7
- [ ] Rework model 3 - simulation case 16
- [ ] Normal vs Poisson (model comparison: Bayes factor, RMSE 90% CI)
- [ ] Quadratic trend components
- [ ] Softmax regressions (PCAs might be required before)
- [ ] Time-varying transition matrices

### Introduction
Hi there :sunglasses: My name is Tim, and this repository contains my work on Bayesian growth mixture models (or GMMs for short) including hidden Markov chains and softmax regressions for representing latent class memberships. The work has been developed in cooperation with Dr. Nalan Basturk as part of my research assistantance in econometrics at Maastricht University.

### Work developed
Placeholder

### Software used
* Except for the implementations of the GMMs, all operations have been performed using R (R Core Team, 2022)
* The GMMs have been implemented using Stan and estimated using the No-U-Turn Sampler (or NUTS for short) via RStan — the R interface to Stan (Hoffman & Gelman, 2014; Stan Development Team, n.d.; Stan Development Team, 2024)
* In the context of parameter initializations for the NUTS, the R Stats Package has been used to apply Hartigan and Wong's (1979) K-means clustering algorithm with maximum ten iterations and two random sets (R Core Team and contributors worldwide, 2022)

### Structure of repository
* :page_facing_up: ModelSpecifications
* :file_folder: ModelImplementations
* :file_folder: SimulationStudyData
* :file_folder: SimulationStudyResults

### Future work
Define and implement a strategy for setting the hyperparameters listed below so that label switching is prevented. However, the hyperparameters are not allowed to be informative regarding classes.
* SD hyperparameters for Normal prior of constants
* SD hyperparameters for Normal prior of linear trend components
* SD hyperparameters for Normal prior of SDs for Normal distributions of dependent variable

### Software references
* R Core Team. (2022). *R: A Language and Environment for Statistical Computing* (Version 4.2.2) [R package]. The R Project for Statistical Computing.
* R Core Team and contributors worldwide. (2022). *The R Stats Package* (Version 4.2.2) [R package]. The R Project for Statistical Computing.
* Stan Development Team. (2024). *RStan — the R interface to Stan* (Version 2.32.6) [R package]. The R Project for Statistical Computing.

### References
* Hartigan, J. A. and Wong, M. A. (1979). Algorithm AS 136: A K-means clustering algorithm. *Applied Statistics*, *28*(1), 100-108.
* Hoffman, M. D. and Gelman, A. (2014). The No-U-Turn Sampler: Adaptively Setting Path Lengths in Hamiltonian Monte Carlo. *Journal of Machine Learning Research*, *15*, 1593-1623. 
* Stan Development Team. (n.d.). *Stan Documentation Version 2.34*. Stan. https://mc-stan.org/docs/


