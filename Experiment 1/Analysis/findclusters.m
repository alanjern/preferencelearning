% Perform a hierarchical clustering analysis on the data from the
% negative-attributes condition and plot the resulting dendrogram

close all;
clear all;

% Load in data
dataNeg = importdata('../Data/Raw data/Negative-attributes/rawdata_fractional.csv');
dataPos = importdata('../Data/Raw data/Positive-attributes/rawdata_fractional.csv');

% Negative

% Compute distances based on spearman rank correlation
d = squareform(pdist(dataNeg,'spearman'));
% Generate the clusters using average link clustering
c = linkage(d,'average');
% Plot the dendrogram and color the clusters
figure();
dendrogram(c,50,'ColorThreshold',0.8);

% Positive

% Compute distances based on spearman rank correlation
dp = squareform(pdist(dataPos,'spearman'));
% Generate the clusters using average link clustering
cp = linkage(dp,'average');
% Plot the dendrogram and color the clusters
figure();
dendrogram(cp,50,'ColorThreshold',0.8);