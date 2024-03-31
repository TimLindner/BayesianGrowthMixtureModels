> Please note that this repository is work in progress
### Introduction
Hi there :sunglasses: My name is Tim, and this repository contains my work on Bayesian growth mixture models ( or GMMs for short ), including their application to country-level terrorism data. The work has been developed in cooperation with Dr. Nalan Basturk as part of my research assistantance in econometrics at Maastricht University.

### Work developed
Placeholder

### Statistical computing
The models have been implemented and estimated using Stan and its built-in No-U-Turn Sampler ( or NUTS for short ) via RStan, the R interface to Stan (Stan Development Team, n.d.; Stan Development Team, 2024).

### Repository structure
* :file_folder: ModelImplementation contains two Stan implementation files for each model specified in :page_facing_up: ModelSpecification: the implementation of a baseline model, which assumes one class ( i.e., no sub-populations ), and the implementation of a model, which assumes multiple classes.
* :file_folder: SimulationStudyData
* :file_folder: SimulationStudyResult
* :page_facing_up: ModelEstimation
* :page_facing_up: ModelSpecification

### References
* Stan Development Team. (n.d.). *Stan Documentation, Version 2.34*. Stan. https://mc-stan.org/docs/
* Stan Development Team. (2024). *RStan: the R interface to Stan* (Version 2.32.6) [R package]. The R Project for Statistical Computing.


