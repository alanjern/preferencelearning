% Compute the average ranking for each cluster and compare
% it to the predictions of both versions of the inverse decision making
% model (absolute and relative)

close all;
clear all;

% Constants
z = 1.96; % For 95% CI

% Load in the data
dataNeg = importdata('../Data/Raw data/Negative-attributes/rawdata_fractional.csv');
n = size(dataNeg,1);

% Define clusters
% These are the clusters that were identified using findclusters.m
clusters{1} = [5 26 7 30 9 31 27 15 35 24];
clusters{2} = [32 34 1 16 23 2 14 21 22 25 39 29 33];
clusters{3} = [4 19 28 6 12 36];
nClusters = 3;

for c=1:nClusters
	means{c} = mean(dataNeg(clusters{c},:));
end

clusterRhos = zeros(nClusters,2); % clusterRhos(i,j) is the rho coefficient for cluster i, model j
                                  % j = {1: absolute, 2: relative}
clusterRhoCIs = zeros(nClusters,2,2); % clusterRhoCIs(i,j,:) is the rho coefficient CI for cluster i, model j
                   
% Load in model predictions
model = load('../Model/negative_choicesort_20mil');

% Compute correlations
for c=1:nClusters
    % Absolute utility model
    clusterRhos(c,1) = corr(means{c}', model.rankingMeans', 'type', 'Spearman'); 
    clusterRhoCIs(c,1,:) = [tanh(atanh(clusterRhos(c,1)) - z/sqrt(length(means{c})-3)) ...
                            tanh(atanh(clusterRhos(c,1)) + z/sqrt(length(means{c})-3))];
                            
    % Relative utility model
    clusterRhos(c,2) = corr(means{c}', model.rankingHighest', 'type', 'Spearman'); 
    clusterRhoCIs(c,2,:) = [tanh(atanh(clusterRhos(c,2)) - z/sqrt(length(means{c})-3)) ...
                            tanh(atanh(clusterRhos(c,2)) + z/sqrt(length(means{c})-3))];
end


%save('cluster_analysis_negative');