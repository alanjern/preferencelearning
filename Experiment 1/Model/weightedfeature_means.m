% Run the weighted feature model on mean human rankings

clear all;

% Load in the data and model predictions

% Positive effects
dataPos = importdata('../Data/Raw data/Positive-attributes/rawdata_fractional.csv');
nPos = size(dataPos,1);
modelPos = load('../Model/positive_choicesort_20mil');

% Negative effects
dataNeg = importdata('../Data/Raw data/Negative-attributes/rawdata_fractional.csv');
nNeg = size(dataNeg,1);
modelNeg = load('../Model/negative_choicesort_20mil');

% Summarize the data

% Positive effects
meansPos = mean(dataPos);
residualsPos = meansPos - modelPos.rankingMeans;

% Negative effects
meansNeg = mean(dataNeg);
residualsNeg = meansNeg - modelNeg.rankingMeans;

% Predictor
% 1. Number of chosen effects
% 2. Number of foregone effects
% 3. Choose the effect with max (min) number of effects? (binary)
% 4. Choose the only option with x? (binary)
% 5. Is x the only difference between the options? (binary)
% 6. Total number of foregone options
% 7. Number of forgone options containing x
% 8. Is x in every option? (binary)
% 9. Is the number of effects the same in all options? (binary)
% 10. Max foregone (min) option size

% X(i,:) = a feature vector for choice i using the predictors/features above

X(1,:) = [1 1 0 1 1 1 0 0 1 1];
labels{1} = 'a/x';
X(2,:) = [2 3 0 1 0 1 0 0 0 3];
labels{2} = 'dcb/ax';
X(3,:) = [2 3 0 0 0 3 3 1 1 2];
labels{3} = 'dx/cx/bx/ax';
X(4,:) = [1 1 0 1 1 1 0 0 1 2];
labels{4} = 'ab/ax';
X(5,:) = [1 4 0 1 0 1 0 0 0 4];
labels{5} = 'dcba/x';
X(6,:) = [1 4 0 1 0 2 0 0 0 3];
labels{6} = 'dcb/a/x';
X(7,:) = [3 2 0 0 0 1 1 1 1 3];
labels{7} = 'dcx/bax';
X(8,:) = [3 2 0 0 0 2 2 1 1 3];
labels{8} = 'bdx/cax/bax';
X(9,:) = [3 2 0 0 0 2 1 0 1 3];
labels{9} = 'bad/bcx/bax';
X(10,:) = [1 4 0 1 0 2 0 0 0 2];
labels{10} = 'dc/ba/x';                
X(11,:) = [1 4 0 1 1 4 0 0 1 1];  
labels{11} = 'd/c/b/a/x';    
X(12,:) = [3 2 0 1 0 1 0 0 1 3];    
labels{12} = 'bdc/bax';
X(13,:) = [1 3 0 1 0 2 0 0 0 2];
labels{13} = 'cb/a/x';
X(14,:) = [3 0 1 1 0 0 0 1 1 0];
labels{14} = 'bax';
X(15,:) = [3 2 0 0 0 2 2 1 1 3];
labels{15} = 'bdx/bcx/bax';
X(16,:) = [2 2 0 1 0 1 0 0 1 2];
labels{16} = 'cb/ax';
X(17,:) = [2 3 0 0 0 3 1 0 1 2];
labels{17} = 'ad/ac/bx/ax';
X(18,:) = [3 2 1 1 0 2 0 0 0 1];
labels{18} = 'd/c/bax';
X(19,:) = [1 0 1 1 0 0 0 1 1 0];
labels{19} = 'x';                            
X(20,:) = [3 2 1 1 0 1 0 0 0 2];
labels{20} = 'dc/bax';
X(21,:) = [1 2 0 1 1 2 0 0 1 1];    
labels{21} = 'b/a/x';                       
X(22,:) = [1 4 0 1 0 3 0 0 0 2];
labels{22} = 'dc/b/a/x';    
X(23,:) = [1 3 0 0 0 3 2 0 1 2];
labels{23} = 'ad/cx/bx/ax';
X(24,:) = [2 2 0 0 0 2 1 0 1 2];     
labels{24} = 'ac/bx/ax';
X(25,:) = [2 3 0 1 0 2 0 0 0 2];   
labels{25} = 'dc/b/ax';            
X(26,:) = [2 0 1 1 0 0 0 1 1 0];
labels{26} = 'ax';
X(27,:) = [2 2 1 1 0 2 0 0 0 1];
labels{27} = 'c/b/ax';     
X(28,:) = [4 1 0 0 0 1 1 1 1 4];
labels{28} = 'dcax/bcax';
X(29,:) = [2 2 0 1 1 2 0 0 1 2];    
labels{29} = 'ac/ab/ax';            
X(30,:) = [2 3 0 0 0 2 1 0 1 2];
labels{30} = 'dc/bx/ax';
X(31,:) = [1 2 0 1 0 1 0 0 0 2];    
labels{31} = 'ba/x';    
X(32,:) = [2 1 0 0 0 1 1 1 1 2];
labels{32} = 'bx/ax';
X(33,:) = [2 2 0 0 0 2 2 1 1 2];
labels{33} = 'cx/bx/ax';                
X(34,:) = [2 3 1 1 0 3 0 0 0 1];   
labels{34} = 'd/c/b/ax';            
X(35,:) = [2 1 1 1 0 1 0 0 0 1];
labels{35} = 'b/ax';
X(36,:) = [3 1 1 1 0 1 0 0 0 1];
labels{36} = 'c/bax';       
X(37,:) = [1 3 0 1 0 1 0 0 0 3];
labels{37} = 'cba/x';
X(38,:) = [3 1 0 0 0 1 1 1 1 3];
labels{38} = 'cax/bax';
X(39,:) = [4 0 1 1 0 0 0 1 1 0];
labels{39} = 'cbax';
X(40,:) = [5 0 1 1 0 0 0 1 1 0];
labels{40} = 'dcbax';
X(41,:) = [4 1 0 1 1 1 0 0 1 4];
labels{41} = 'cbad/cbax';
X(42,:) = [3 1 0 1 1 1 0 0 1 3];
labels{42} = 'bad/bax';
X(43,:) = [2 3 0 1 1 3 0 0 1 2];
labels{43} = 'ad/ac/ab/ax';
X(44,:) = [2 3 0 1 0 2 0 0 1 2];
labels{44} = 'dc/ab/ax';
X(45,:) = [1 3 0 1 1 3 0 0 1 1];
labels{45} = 'c/b/a/x';
X(46,:) = [4 1 1 1 0 1 0 0 0 1];
labels{46} = 'd/cbax';               
X(47,:) = [3 2 0 1 1 2 0 0 1 3];
labels{47} = 'bad/bac/bax';

nproblems = 47;
nfeatures = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analysis 1: Compute how many features are needed by weighted
%    feature model to match performance of IDM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Positive effects
% Compute Spearman rho for absolute utility model
rho_thresh_pos = corr(modelPos.rankingMeans', meansPos', 'type', 'Spearman');
[f max_rho] = compute_minimal_regression_rho(meansPos',X,rho_thresh_pos);
if (max_rho < rho_thresh_pos)
    n_factors_needed_pos = 11;
else
    n_factors_needed_pos = length(f);
end

fprintf('Positive-attributes features needed: %d\n', n_factors_needed_pos);
disp(f);
fprintf('Weighted feature rank correlation: %.3f\n\n', max_rho);


% Negative effects
% Compute Spearman rho for absolute utility model
rho_thresh_neg = corr(modelNeg.rankingMeans', meansNeg', 'type', 'Spearman');
[f max_rho] = compute_minimal_regression_rho(meansNeg',X,rho_thresh_neg);
if (max_rho < rho_thresh_neg)
    n_factors_needed_neg = 11;
else
    n_factors_needed_neg = length(f);
end

fprintf('=== Min feature analysis ===\n\n');

fprintf('Negative-attributes features needed: %d\n', n_factors_needed_neg);
disp(f);
fprintf('Weighted feature rank correlation: %.3f\n\n', max_rho);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analysis 2: Evaluate performance of weighted feature model
%      using a hold-out sample
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m = 5; %500; % number of times to run the analysis
valSize = 5; % size of validation set
testSize = 5; % size of the test set

% Weighted feature model correlations on test set
weightedFeatureRhosPos = zeros(m,1); 
weightedFeatureRhosNeg = zeros(m,1);

% Lasso weighted feature model correlations on test set
lassoRhosPos = zeros(m,1); 
lassoRhosNeg = zeros(m,1);

% IDM model correlations on test set
idmRhosPos = zeros(m,1);
idmRhosNeg = zeros(m,1);

for i=1:m

	dataIndices = randperm(nproblems);
	trainInd = dataIndices(1:(nproblems-valSize-testSize)); % indices for training set
	valInd = dataIndices((nproblems-valSize-testSize+1):(nproblems-testSize)); % indicies for validation set
	testInd = dataIndices((nproblems-testSize+1):end); % indices for test set
	
	% Training data
	Xtrain = X(trainInd,:);
	meansPosTrain = meansPos(trainInd);
	meansNegTrain = meansNeg(trainInd);

	% Validataion data
	Xval = X(valInd,:);
	meansPosVal = meansPos(valInd);
	meansNegVal = meansNeg(valInd);
	
	% Test data
	Xtest = X(testInd,:);
	meansPosTest = meansPos(testInd);
	meansNegTest = meansNeg(testInd);
	
	% Positive attributes
	
	% 1. Weighted feature model
	[f_best b_best] = choose_regression_parameters(meansPosTrain',Xtrain,meansPosVal',Xval);
	
	% Generate predictions for test data
	wfPreds = b_best'*[Xtest(:,f_best) ones(length(meansPosTest),1)]';
	weightedFeatureRhosPos(i) = corr(meansPosTest', wfPreds', 'type', 'Spearman');
	if (isnan(weightedFeatureRhosPos(i)))
		weightedFeatureRhosPos(i) = 0;
	end
	
	% 2. Lasso weighted feature model
	numLambda = 100; % Number of lambda values to try with lasso
	[bLassoPos,fitInfoPos] = lasso(Xtrain,meansPosTrain','NumLambda',numLambda);
	
	% Choose the feature weights for lambda value that maximizes rank correlation on validation set
	lassoRhos = zeros(numLambda,1);
	for j=1:numLambda
		lassoPredictedVals = Xval*bLassoPos(:,j);
		lassoRhos(j) = corr(lassoPredictedVals, meansPosVal', 'type', 'Spearman');
	end
	maxLassoRho = max(lassoRhos);
	maxLassoModels = bLassoPos(:,lassoRhos == maxLassoRho);
	% Choose the last model (model with the fewest degrees of freedom)
	simplestBestModel = maxLassoModels(:,end);
	simplestBestLassoDFpos(i) = sum(simplestBestModel > 0);
	
	% Apply to test set
	lassoPredictedTestVals = Xtest*simplestBestModel;
	lassoRhosPos(i) = corr(lassoPredictedTestVals, meansPosTest', 'type', 'Spearman');
	if (isnan(lassoRhosPos(i)))
		lassoRhosPos(i) = 0;
	end
	
	
	% 3. IDM model
	idmRhosPos(i) = corr(modelPos.rankingMeans(testInd)', meansPosTest');
	if (isnan(idmRhosPos(i)))
		idmRhosPos(i) = 0;
	end
	
	
	
	
	% Negative attributes
	
	% 1. Weighted feature model
	[f_best b_best] = choose_regression_parameters(meansNegTrain',Xtrain,meansNegVal',Xval);
	
	% Generate predictions for test data
	wfPreds = b_best'*[Xtest(:,f_best) ones(length(meansNegTest),1)]';
	weightedFeatureRhosNeg(i) = corr(meansNegTest', wfPreds', 'type', 'Spearman');
	if (isnan(weightedFeatureRhosNeg(i)))
		weightedFeatureRhosNeg(i) = 0;
	end
	
	% 2. Lasso weighted feature model
	numLambda = 100; % Number of lambda values to try with lasso
	[bLassoNeg,fitInfoPos] = lasso(Xtrain,meansNegTrain','NumLambda',numLambda);
	
	% Choose the feature weights for lambda value that maximizes rank correlation on validation set
	lassoRhos = zeros(numLambda,1);
	for j=1:numLambda
		lassoPredictedVals = Xval*bLassoNeg(:,j);
		lassoRhos(j) = corr(lassoPredictedVals, meansNegVal', 'type', 'Spearman');
	end
	maxLassoRho = max(lassoRhos);
	maxLassoModels = bLassoNeg(:,lassoRhos == maxLassoRho);
	% Choose the last model (model with the fewest degrees of freedom)
	simplestBestModel = maxLassoModels(:,end);
	simplestBestLassoDFneg(i) = sum(simplestBestModel > 0);
	
	% Apply to test set
	lassoPredictedTestVals = Xtest*simplestBestModel;
	lassoRhosNeg(i) = corr(lassoPredictedTestVals, meansNegTest', 'type', 'Spearman');
	if (isnan(lassoRhosNeg(i)))
		lassoRhosNeg(i) = 0;
	end

    % 3. IDM model
    idmRhosNeg(i) = corr(modelNeg.rankingMeans(testInd)', meansNegTest');
    if (isnan(idmRhosNeg(i)))
		idmRhosNeg(i) = 0;
	end
	
end

fprintf('=== Hold-out analysis ===\n\n');

fprintf('Positive attributes\n\n');
fprintf('Weighted feature model rank correlation: M=%.3f (SD=%.3f)\n', ...
	mean(weightedFeatureRhosPos), std(weightedFeatureRhosPos));
fprintf('Lasso model rank correlation: M=%.3f (SD=%.3f)\n', ...
	mean(lassoRhosPos), std(lassoRhosPos));
fprintf('IDM model rank correlation: M=%.3f (SD=%.3f)\n\n', ...
	mean(idmRhosPos), std(idmRhosPos));

fprintf('Negative attributes\n\n');
fprintf('Weighted feature model rank correlation: M=%.3f (SD=%.3f)\n', ...
	mean(weightedFeatureRhosNeg), std(weightedFeatureRhosNeg));
fprintf('Lasso model rank correlation: M=%.3f (SD=%.3f)\n', ...
	mean(lassoRhosNeg), std(lassoRhosNeg));
fprintf('IDM model rank correlation: M=%.3f (SD=%.3f)\n', ...
	mean(idmRhosNeg), std(idmRhosNeg));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analysis 3: Perform linear regression on the residuals of the
%      IDM's residuals. Statistically significant predictors
%      suggest the IDM is failing to account for additional 
%      features that explain variance in subjects' mean rankings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\n\n=== Regression on residuals ===\n\n');

fprintf('Positive attributes\n');
mPos = fitlm(X,residualsPos');
disp(mPos);

fprintf('\n\nNegative attributes\n');
mNeg = fitlm(X,residualsNeg');
disp(mNeg);