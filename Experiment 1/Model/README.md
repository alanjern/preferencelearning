Experiment 1 model code
=======================

These scripts are written in Matlab and use the Parallel Computing Toolbox.

* `choicesort.m`: This script generates model predictions for the logit model (called the absolute utility model in the Supplemental Material), the relative utility model, and the surprise model. Absolute utility model rankings are stored in variable `rankingMeans`. Relative utility model rankings are stored in varaible `rankingHighest`. Surprise model rankings are stored in `rankingSurprise`.
* `choicesort_representativness.m`: This script generates model predictions for the representativeness model. Rankings are stored in the variable `rankingRep`.
* `weightedfeature.m`: This script generates model predictions for every subject using the weighted feature model (linear regression model). Results are stored in the variables `weightedFeaturePos` (positive-attributes) and `weightedFeatureNeg` (negative-attributes).

To get a sense of how to work with the output of these scripts, consult the Experiment 1 data analysis script in this repository.

The `*.mat` files contain the output of the above scripts and were used to generate the plots in the paper.