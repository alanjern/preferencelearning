Experiment 1 data
=================

Basic information
-----------------

The most useful files here are in "Summary data". There are three files for each condition.
* `labels_fractional.csv`: The list of choices ordered by subjects average ranking. Example: "c/b/ax" describes a choice in which one bag contained candy C, one bag contained candy B, and one bag contained candy A and candy X. The rightmost option is the chosen one.
* `means_fractional.csv`: Average fractional rankings subjects assigned to each choice, in the same order as in `labels_fractional.csv`.
* `stds_fractional.csv`: Standard deviations of subjects rankings, in the same order as the other two files.

This is the data that was used to produce Figure 1 in the paper.

Complete information
--------------------

* Raw data
    Contains transcribed responses from subjects in both conditions. Each file (`results_subject*.txt`) contains a list of numbers, each number corresponding to one of the choices. The numbers appear from weakest to strongest evidence. Choices that were assigned equal rankings are separated by commas. Choices that were assigned different rankings are on different lines. 
    Also contains a summary file (`rawdata_fractional.csv`) that includes the fractional rankings from all subjects except outliers. Each row is one subject.
* `printresults_fractional.py`: This function takes as input a path to a list of raw data files and produces the summary data csv files described above.