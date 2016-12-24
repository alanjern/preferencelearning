% Perform a linear regression on participant rankings for
% Experiment 1, using every subset of 10 predictors
%
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
%
% The predictor matrix is n (observerations) x p (predictors)
% Here, n = 47 and p = [1,10]

clear all;

% Load in the data

% Positive effects
dataPos = importdata('../Data/Raw data/Positive-attributes/rawdata_fractional.csv');
nPos = size(dataPos,1);
modelPos = load('../Model/positive_choicesort_20mil');

% Negative effects
dataNeg = importdata('../Data/Raw data/Negative-attributes/rawdata_fractional.csv');
nNeg = size(dataNeg,1);
modelNeg = load('../Model/negative_choicesort_20mil');


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

fcounts_pos = zeros(1,nfeatures);
rho_thresh_pos = zeros(1,nPos);
rhos_pos = zeros(1,nPos);
n_factors_needed_pos = zeros(1,nPos);
fails_pos = 0;

% Positive effects
fprintf('=== Positive effects ===\n');
for i=1:nPos
    fprintf('Subject %d\n',i);
    d = dataPos(i,:);
    % Compute Spearman rho for absolute utility model and subject i
    rho_thresh_pos(i) = corr(modelPos.rankingMeans', d', 'type', 'Spearman');
    [f max_rho] = compute_minimal_regression_rho(d',X,rho_thresh_pos(i));
    if (max_rho < rho_thresh_pos(i))
        fails_pos = fails_pos+1;
        n_factors_needed_pos(i) = 11;
    else
        n_factors_needed_pos(i) = length(f);
    end
    rhos_pos(i) = max_rho;
    fcounts_pos(f) = fcounts_pos(f) + 1;
    factors_pos{i} = f;
end

fcounts_neg = zeros(1,nfeatures);
rho_thresh_neg = zeros(1,nNeg);
rhos_neg = zeros(1,nNeg);
n_factors_needed_neg = zeros(1,nNeg);
fails_neg = 0;

% Negative effects
fprintf('=== Negative effects ===\n');
for i=1:nNeg
    fprintf('Subject %d\n',i);
    d = dataNeg(i,:);
    % Compute Spearman rho for absolute utility model and subject i
    rho_thresh_neg(i) = corr(modelNeg.rankingMeans', d', 'type', 'Spearman');
    [f max_rho] = compute_minimal_regression_rho(d',X,rho_thresh_neg(i));
    if (max_rho < rho_thresh_neg(i))
        fails_neg = fails_neg+1;
        n_factors_needed_neg(i) = 11;
    else
        n_factors_needed_neg(i) = length(f);
    end
    rhos_neg(i) = max_rho;
    fcounts_neg(f) = fcounts_neg(f) + 1;
    factors_neg{i} = f;
end

% Save the results
%save('weightedFeaturePos','rhos_pos','rho_thresh_pos','fails_pos','n_factors_needed_pos','fcounts_pos');
%save('weightedFeatureNeg','rhos_neg','rho_thresh_neg','fails_neg','n_factors_needed_neg','fcounts_neg');



