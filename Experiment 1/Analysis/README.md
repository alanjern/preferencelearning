Experiment 1 data analysis
==========================

These files analyze the data for Experiment 1 and generate the plots in the paper.

* `findclusters.m` and `analyzeclusters.m`: These scripts perform the individual differences analysis described in the Supplemental Material.
* `varypriormean.m` and `varypriorsd.m`: These scripts generate inverse decision-making model predictions with varying prior assumptions about utilities (varying means and varying standard deviations, respectively).
* `analyze_subject_variance.m`: This script computes the mean correlation between individual subjects' rankings and the mean rankings in each condition.
* `makeresultsfigures.m`: This script generates the plots for Figure 3, Figure 6, Figure B1, and Figure C1. It also computes all of the reported Spearman rank correlation coefficients.

The `*.mat` files contain the output of `varypriormean.m` and `varypriords.m` that were used for the parameter sensitivity analysis.