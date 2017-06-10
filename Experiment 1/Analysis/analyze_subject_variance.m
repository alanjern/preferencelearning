% Compute rank correlations between individual subjects' rankings 
% and mean rankings

close all;
clear all;

% Load in data
dataPos = importdata('../Data/Raw data/Positive-attributes/rawdata_fractional.csv');
meansPos = mean(dataPos);
nPos = size(dataPos,1);

dataNeg = importdata('../Data/Raw data/Negative-attributes/rawdata_fractional.csv');
meansNeg = mean(dataNeg);
nNeg = size(dataNeg,1);

% Positive attributes 
correlationsPos = zeros(1,nPos);
for i=1:nPos
	subjectRankings = dataPos(i,:);
	correlationsPos(i) = corr(subjectRankings', meansPos', 'type', 'Spearman');
end

% Negative attributes 
correlationsNeg = zeros(1,nNeg);
for i=1:nNeg
	subjectRankings = dataNeg(i,:);
	correlationsNeg(i) = corr(subjectRankings', meansNeg', 'type', 'Spearman');
end

% Report mean correlations for both conditions
% Lower correlations indicate more variance in rankings
fprintf('Positive-attributes mean correlation: %.3f\n', mean(correlationsPos));
fprintf('Negative-attributes mean correlation: %.3f\n', mean(correlationsNeg));