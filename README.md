> Please note that this repository is work in progress
### To-do list
* In the introduction, indicate what is the goal of this repository
* Include which version of R is used

### Introduction
Hi there :sunglasses: My name is Tim, and this repository contains my work on Bayesian growth mixture models (or GMMs for short) including hidden Markov chains and softmax regressions for representing latent class memberships. The work has been developed in cooperation with Dr. Nalan Basturk as part of my research assistantance in econometrics at Maastricht University.

### Work developed
Placeholder

### Statistical computation
* The GMMs have been implemented and estimated using Stan and the No-U-Turn Sampler (or NUTS for short) via RStan — the R interface to Stan (Hoffman & Gelman, 2014; Stan Development Team, n.d.; Stan Development Team, 2024)
* In the context of parameter initializations for the NUTS, the R Stats Package has been used to apply Hartigan and Wong's (1979) K-means clustering algorithm with maximum ten iterations and two random sets (R Core Team and contributors worldwide, 2022)

### Structure of repository
* :file_folder: ModelImplementations
* :file_folder: SimulationStudyData
* :file_folder: SimulationStudyResults
* :page_facing_up: ModelSpecifications

### Future work
Define a strategy for setting the following hyperparameters so that label switching is prevented: $\boldsymbol{\sigma}_{\beta_0}$, $\boldsymbol{\sigma}_{\beta_1}$, and $\boldsymbol{\sigma}_{\sigma}$. However, the hyperparameters are not allowed to be informative regarding classes.

### References
* Hartigan, J. A. and Wong, M. A. (1979). Algorithm AS 136: A K-means clustering algorithm. *Applied Statistics*, *28*(1), 100-108.
* Hoffman, M. D. and Gelman, A. (2014). The No-U-Turn Sampler: Adaptively Setting Path Lengths in Hamiltonian Monte Carlo. *Journal of Machine Learning Research*, *15*, 1593-1623. 
* R Core Team and contributors worldwide. (2022). *The R Stats Package* (Version 4.2.2) [R package]. The R Project for Statistical Computing.
* Stan Development Team. (n.d.). *Stan Documentation Version 2.34*. Stan. https://mc-stan.org/docs/
* Stan Development Team. (2024). *RStan — the R interface to Stan* (Version 2.32.6) [R package]. The R Project for Statistical Computing.

