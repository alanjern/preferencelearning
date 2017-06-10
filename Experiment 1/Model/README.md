Experiment 1 model code
=======================

These scripts are written in Matlab and use the Parallel Computing Toolbox.

* `choicesort.m`: This script generates model predictions for the absolute utility model, the relative utility model, and the marginal likelihood model (referred to as surprise model in the code). Absolute utility model rankings are stored in the variable `rankingMeans`. Relative utility model rankings are stored in variable `rankingHighest`. Marginal likelihood model rankings are stored in `rankingSurprise`.
* `choicesort_representativeness.m`: This script generates model predictions for the likelihood model (referred to as the representativeness model in the code). Rankings are stored in the variable `rankingRep`.
* `choicesort_linear.m`: This script generates model predictions for a model that assumes a linear choice function. The model rankings are stored in variable `rankingMeans_linear`.
* `choicesort_probit.m`: This script generates model predictions for a model that assumes a probit choice function. The model rankings are stored in the variable `rankingMeans_probit`.
* `weightedfeature.m`: This script generates model predictions for every subject using the weighted feature model (linear regression model). Results are stored in the variables `weightedFeaturePos` (positive-attributes) and `weightedFeatureNeg` (negative-attributes).
* `weightedfeature_means.m`: This script generates weighted feature model predictions for the mean data using a hold-out sample for validation and for testing. It also generates predictions from the alternative weighted feature model that uses lasso regression instead of linear regression and performs the regression analysis on the residuals of the inverse decision-making model's residuals.

To get a sense of how to work with the output of these scripts, consult the Experiment 1 data analysis script in this repository.

The `*.mat` files contain the output of the above scripts and were used to generate the plots in the paper.