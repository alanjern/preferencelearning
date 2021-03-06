% This script makes figures showing results for the choice-sorting experiment
% in the preference learning paper

clear all;
close all;

% Constants
z = 1.96; % For 95% CI

% Results of the cluster analysis
clusters{2} = [32 34 1 16 23 14 22 29 39 21 25 33];
clusters{4} = [4 19 28 6 12 36];
clusters{1} = [5 7 30 9 31 27 15 26];
clusters{3} = [17 18 20];
nClusters = 4;


% Load in the data and model predictions

% Positive-attributes
dataPos = importdata('../Data/Raw data/Positive-attributes/rawdata_fractional.csv');
labelsPos = importdata('../Data/Summary data/Positive-attributes/labels_fractional.csv');
modelPos = load('../Model/positive_choicesort_20mil');
modelRepPos = load('../Model/positive_choicesort_representativeness_20mil');
modelProbitPos = load('../Model/positive_choicesort_probit_200k');
modelLinearPos = load('../Model/positive_choicesort_linear_20mil');

% Negative-attributes
dataNeg = importdata('../Data/Raw data/Negative-attributes/rawdata_fractional.csv');
labelsNeg = importdata('../Data/Summary data/Positive-attributes/labels_fractional.csv');
modelNeg = load('../Model/negative_choicesort_20mil');
modelRepNeg = load('../Model/negative_choicesort_representativeness_20mil');
modelProbitNeg = load('../Model/negative_choicesort_probit_200k');


% Summarize the data

% Positive attributes
nPos = size(dataPos,1);
meansPos = mean(dataPos);
stdsPos = std(dataPos);
sesPos = stdsPos ./ sqrt(nPos);
[sortedDataPos, sortingIndexDataPos] = sort(meansPos);
sortedStdsPos = stdsPos(sortingIndexDataPos);

% Negative attributes
nNeg = size(dataNeg,1);
meansNeg = mean(dataNeg);
stdsNeg = std(dataNeg);
sesNeg = stdsNeg ./ sqrt(nNeg);
[sortedDataNeg, sortingIndexDataNeg] = sort(meansNeg);
sortedStdsNeg = stdsNeg(sortingIndexDataNeg);

% Print the list of choices sorted by mean human ranking
disp(labelsPos);

% ==============================================================================
% Absolute utility model (logit model) vs. Human rankings (positive)
% ==============================================================================
figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 3 3]);

plot(0:48,0:48, 'linewidth', 2, 'Color', [0.5 0.5 0.5]);
hold on;
errorbar(modelPos.rankingMeans, meansPos, sesPos, 'k.', 'markersize', 10);
axis([0 48 0 48]);
set(gca,'XTick',[1 47]);
set(gca,'YTick',[1 47]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;
hold off;

%print('-depsc', 'absolute_vs_human_positive');

% Compute Spearman rho
rhoAbsPos = corr(modelPos.rankingMeans', meansPos', 'type', 'Spearman');
% Compute confidence interval
rhoAbsPosCI = [tanh(atanh(rhoAbsPos) - z/sqrt(length(meansPos)-3)) ...
               tanh(atanh(rhoAbsPos) + z/sqrt(length(meansPos)-3))];
fprintf('Positive absolute utility model rho: %.3f [%.3f %.3f]\n', rhoAbsPos, rhoAbsPosCI(1), rhoAbsPosCI(2));


% =============================================================================
% (For reference) Replot the previous figure with labels
% =============================================================================

figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 3 3]);

plot(0:48,0:48, 'linewidth', 2, 'Color', [0.5 0.5 0.5]);
hold on;
for i=1:length(meansPos)
    label = sprintf('%d', find(sortingIndexDataPos == i));
    text(modelPos.rankingMeans(i), meansPos(i), label);
end

axis([0 48 0 48]);
set(gca,'XTick',[1 47]);
set(gca,'YTick',[1 47]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;
hold off;



% =============================================================================
% Absolute utility model (logit model) vs. Human rankings (negative)
% =============================================================================
figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 3 3]);

plot(0:48,0:48, 'linewidth', 2, 'Color', [0.5 0.5 0.5]);
hold on;
errorbar(modelNeg.rankingMeans, meansNeg, sesNeg, 'k.', 'markersize', 10);
axis([0 48 0 48]);
set(gca,'XTick',[1 47]);
set(gca,'YTick',[1 47]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;
hold off;

%print('-depsc', 'absolute_vs_human_negative');

% Compute Spearman rho
rhoAbsNeg = corr(modelNeg.rankingMeans', meansNeg', 'type', 'Spearman');
% Compute confidence interval
rhoAbsNegCI = [tanh(atanh(rhoAbsNeg) - z/sqrt(length(meansNeg)-3)) ...
               tanh(atanh(rhoAbsNeg) + z/sqrt(length(meansNeg)-3))];
fprintf('Negative absolute utility model rho: %.3f [%.3f %.3f]\n', rhoAbsNeg, rhoAbsNegCI(1), rhoAbsNegCI(2));


% =============================================================================
% (For reference) Replot the previous figure with labels
% =============================================================================

figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 3 3]);

plot(0:48,0:48, 'linewidth', 2, 'Color', [0.5 0.5 0.5]);
hold on;
for i=1:length(meansNeg)
    label = sprintf('%d', find(sortingIndexDataNeg == i));
    text(modelNeg.rankingMeans(i), meansNeg(i), label);
end

axis([0 48 0 48]);
set(gca,'XTick',[1 47]);
set(gca,'YTick',[1 47]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;
hold off;


% =============================================================================
% Relative utility model vs. Human rankings (positive)
% =============================================================================
figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 1 1]);

plot(0:48,0:48, 'Color', [0.5 0.5 0.5]);
hold on;
plot(modelPos.rankingHighest, meansPos, 'k.');
axis([0 48 0 48]);
set(gca,'XTick',[1 47]);
set(gca,'YTick',[1 47]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;
hold off;

%print('-depsc', 'relative_vs_human_positive_small');

% Compute Spearman rho
rhoRelPos = corr(modelPos.rankingHighest', meansPos', 'type', 'Spearman');
% Compute confidence interval
rhoRelPosCI = [tanh(atanh(rhoRelPos) - z/sqrt(length(meansPos)-3)) ...
               tanh(atanh(rhoRelPos) + z/sqrt(length(meansPos)-3))];
fprintf('Positive relative utility model rho: %.3f [%.3f %.3f]\n', rhoRelPos, rhoRelPosCI(1), rhoRelPosCI(2));



% =============================================================================
% Relative utility model vs. Human rankings (negative)
% =============================================================================
figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 1 1]);

plot(0:48,0:48, 'Color', [0.5 0.5 0.5]);
hold on;
plot(modelNeg.rankingHighest, meansNeg, 'k.');
axis([0 48 0 48]);
set(gca,'XTick',[1 47]);
set(gca,'YTick',[1 47]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;
hold off;

%print('-depsc', 'relative_vs_human_negative_small');

% Compute Spearman rho
rhoRelNeg = corr(modelNeg.rankingHighest', meansNeg', 'type', 'Spearman');
% Compute confidence interval
rhoRelNegCI = [tanh(atanh(rhoRelNeg) - z/sqrt(length(meansNeg)-3)) ...
               tanh(atanh(rhoRelNeg) + z/sqrt(length(meansNeg)-3))];
fprintf('Negative relative utility model rho: %.3f [%.3f %.3f]\n', rhoRelNeg, rhoRelNegCI(1), rhoRelNegCI(2));


% =============================================================================
% Representativeness model vs. Human rankings (positive)
% =============================================================================
figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 1 1]);

plot(0:48,0:48, 'Color', [0.5 0.5 0.5]);
hold on;
plot(modelRepPos.rankingRep, meansPos, 'k.');
axis([0 48 0 48]);
set(gca,'XTick',[1 47]);
set(gca,'YTick',[1 47]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;
hold off;

%print('-depsc', 'representativeness_vs_human_positive_small');

% Compute Spearman rho
rhoRepPos = corr(modelRepPos.rankingRep', meansPos', 'type', 'Spearman');
% Compute confidence interval
rhoRepPosCI = [tanh(atanh(rhoRepPos) - z/sqrt(length(meansPos)-3)) ...
               tanh(atanh(rhoRepPos) + z/sqrt(length(meansPos)-3))];
fprintf('Positive representativeness model rho: %.3f [%.3f %.3f]\n', rhoRepPos, rhoRepPosCI(1), rhoRepPosCI(2));


% =============================================================================
% Representativeness model vs. Human rankings (negative)
% =============================================================================
figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 1 1]);

plot(0:48,0:48, 'Color', [0.5 0.5 0.5]);
hold on;
plot(modelRepNeg.rankingRep, meansNeg, 'k.');
axis([0 48 0 48]);
set(gca,'XTick',[1 47]);
set(gca,'YTick',[1 47]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;
hold off;

%print('-depsc', 'representativeness_vs_human_negative_small');

% Compute Spearman rho
rhoRepNeg = corr(modelRepNeg.rankingRep', meansNeg', 'type', 'Spearman');
% Compute confidence interval
rhoRepNegCI = [tanh(atanh(rhoRepNeg) - z/sqrt(length(meansNeg)-3)) ...
               tanh(atanh(rhoRepNeg) + z/sqrt(length(meansNeg)-3))];
fprintf('Negative representativeness model rho: %.3f [%.3f %.3f]\n', rhoRepNeg, rhoRepNegCI(1), rhoRepNegCI(2));


% =============================================================================
% Surprise model vs. Human rankings (positive)
% =============================================================================
figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 1 1]);

plot(0:48,0:48, 'Color', [0.5 0.5 0.5]);
hold on;
plot(modelPos.rankingSurprise, meansPos, 'k.');
axis([0 48 0 48]);
set(gca,'XTick',[1 47]);
set(gca,'YTick',[1 47]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;
hold off;

%print('-depsc', 'surprise_vs_human_positive_small');

% Compute Spearman rho
rhoSurprisePos = corr(modelPos.rankingSurprise', meansPos', 'type', 'Spearman');
% Compute confidence interval
rhoSurprisePosCI = [tanh(atanh(rhoSurprisePos) - z/sqrt(length(meansPos)-3)) ...
               tanh(atanh(rhoSurprisePos) + z/sqrt(length(meansPos)-3))];
fprintf('Positive surprise model rho: %.3f [%.3f %.3f]\n', rhoSurprisePos, rhoSurprisePosCI(1), rhoSurprisePosCI(2));

% =============================================================================
% Surprise model vs. Human rankings (negative)
% =============================================================================
figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 1 1]);

plot(0:48,0:48, 'Color', [0.5 0.5 0.5]);
hold on;
plot(modelNeg.rankingSurprise, meansNeg, 'k.');
axis([0 48 0 48]);
set(gca,'XTick',[1 47]);
set(gca,'YTick',[1 47]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;
hold off;

%print('-depsc', 'surprise_vs_human_negative_small');

% Compute Spearman rho
rhoSurpriseNeg = corr(modelNeg.rankingSurprise', meansNeg', 'type', 'Spearman');
% Compute confidence interval
rhoSurpriseNegCI = [tanh(atanh(rhoSurpriseNeg) - z/sqrt(length(meansNeg)-3)) ...
               tanh(atanh(rhoSurpriseNeg) + z/sqrt(length(meansNeg)-3))];
fprintf('Negative surprise model rho: %.3f [%.3f %.3f]\n', rhoSurpriseNeg, rhoSurpriseNegCI(1), rhoSurpriseNegCI(2));


% ==============================================================================
% Absolute utility model (probit model) vs. Human rankings (positive)
% ==============================================================================

% Compute Spearman rho
rhoAbsPos = corr(modelProbitPos.rankingMeans_probit', meansPos', 'type', 'Spearman');
% Compute confidence interval
rhoAbsPosCI = [tanh(atanh(rhoAbsPos) - z/sqrt(length(meansPos)-3)) ...
               tanh(atanh(rhoAbsPos) + z/sqrt(length(meansPos)-3))];
fprintf('Positive probit model rho: %.3f [%.3f %.3f]\n', rhoAbsPos, rhoAbsPosCI(1), rhoAbsPosCI(2));

% ==============================================================================
% Absolute utility model (probit model) vs. Human rankings (negative)
% ==============================================================================

% Compute Spearman rho
rhoAbsPos = corr(modelProbitNeg.rankingMeans_probit', meansNeg', 'type', 'Spearman');
% Compute confidence interval
rhoAbsPosCI = [tanh(atanh(rhoAbsPos) - z/sqrt(length(meansPos)-3)) ...
               tanh(atanh(rhoAbsPos) + z/sqrt(length(meansPos)-3))];
fprintf('Negative probit model rho: %.3f [%.3f %.3f]\n', rhoAbsPos, rhoAbsPosCI(1), rhoAbsPosCI(2));

% ==============================================================================
% Absolute utility model (linear model) vs. Human rankings (positive)
% ==============================================================================

% Compute Spearman rho
rhoAbsPos = corr(modelLinearPos.rankingMeans_linear', meansPos', 'type', 'Spearman');
% Compute confidence interval
rhoAbsPosCI = [tanh(atanh(rhoAbsPos) - z/sqrt(length(meansPos)-3)) ...
               tanh(atanh(rhoAbsPos) + z/sqrt(length(meansPos)-3))];
fprintf('Positive linear model rho: %.3f [%.3f %.3f]\n', rhoAbsPos, rhoAbsPosCI(1), rhoAbsPosCI(2));



% =============================================================================
% Cluster analysis (negative)
% =============================================================================

load('cluster_analysis_negative');

for c=1:nClusters 
    meansNegCluster(c,:) = mean(dataNeg(clusters{c},:));
    
    figure();
    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperPosition', [0 0 1 1]);
    plot(0:48,0:48, 'Color', [0.5 0.5 0.5]);
    hold on;
    plot(modelNeg.rankingMeans, meansNegCluster(c,:), 'k.');
    axis([0 48 0 48]);
    set(gca,'XTick',[1 47]);
    set(gca,'YTick',[1 47]);
    set(gca,'XTickLabel',{});
    set(gca,'YTickLabel',{});
    box off;
    hold off;
%    fname = sprintf('cluster%d_absolute',c);
%    print('-depsc', fname);
    
    figure();
    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperPosition', [0 0 1 1]);
    plot(0:48,0:48, 'Color', [0.5 0.5 0.5]);
    hold on;
    plot(modelNeg.rankingHighest, meansNegCluster(c,:), 'k.');
    axis([0 48 0 48]);
    set(gca,'XTick',[1 47]);
    set(gca,'YTick',[1 47]);
    set(gca,'XTickLabel',{});
    set(gca,'YTickLabel',{});
    box off;
    hold off;
    
    fprintf('Cluster %d (N=%d) absolute rho: %.3f [%.3f %.3f]\n', ...
            c, length(clusters{c}), clusterRhos(c,1), clusterRhoCIs(c,1,1), clusterRhoCIs(c,1,2));
    fprintf('Cluster %d (N=%d) relative rho: %.3f [%.3f %.3f]\n', ...
            c, length(clusters{c}), clusterRhos(c,2), clusterRhoCIs(c,2,1), clusterRhoCIs(c,2,2));
end


% =============================================================================
% Weighted feature model analysis
% =============================================================================

weightedFeaturePos = load('../Model/weightedFeaturePos');

figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 3.2 2]);
hold on;
[nb,xb] = hist(weightedFeaturePos.n_factors_needed_pos,1:11);
bh=bar(xb,nb);
set(bh,'facecolor',[0.5 0.5 0.5]);
set(bh,'edgecolor','none');
axis([0 12 0 25]);
set(gca,'XTick',1:11);
set(gca,'YTick',[5 10 15 20 25]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;
hold off;

%print('-depsc', 'weighted_feature_pos');

weightedFeatureNeg = load('../Model/weightedFeatureNeg');

figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 3.2 2]);
hold on;
[nb,xb] = hist(weightedFeatureNeg.n_factors_needed_neg,1:11);
bh=bar(xb,nb);
set(bh,'facecolor',[0.5 0.5 0.5]);
set(bh,'edgecolor','none');
axis([0 12 0 25]);
set(gca,'XTick',1:11);
set(gca,'YTick',[5 10 15 20 25]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;
hold off;

%print('-depsc', 'weighted_feature_neg');



% =============================================================================
% Model parameter sensitivity analysis
% =============================================================================

varyMeansPos = load('vary_prior_mean_results_500k_positive');
varyMeansNeg = load('vary_prior_mean_results_500k_negative');
varySDsPos = load('vary_prior_sd_results_500k_positive');
varySDsNeg = load('vary_prior_sd_results_500k_negative');

figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 2.5 2]);

%m = {'+','o','*','.','x','s','d','^','v','>','<','p','h'};
%set(gca(), 'LineStyleOrder',m,'ColorOrder',[0 0 0],'NextPlot','replacechildren')

%plot(varyMeansPos.priormeans, [varyMeansPos.rhos_abs; varyMeansPos.rhos_rel; ...
%                varyMeansPos.rhos_rep; varyMeansPos.rhos_surp], 'markersize', 4);
plot(varyMeansPos.priormeans, [varyMeansPos.rhos_abs; varyMeansPos.rhos_rel; ...
                varyMeansPos.rhos_rep; varyMeansPos.rhos_surp], '.', 'markersize', 8);
axis([0 24.1 -1 1.1]);
set(gca,'XTick',[10 20 24]);
set(gca,'YTick',[0 1]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;

%print('-depsc', 'param_sensitivity_mu_pos');

figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 2.5 2]);

plot(varyMeansNeg.priormeans, [varyMeansNeg.rhos_abs; varyMeansNeg.rhos_rel; ...
                varyMeansNeg.rhos_rep; varyMeansNeg.rhos_surp], '.', 'markersize', 8);
axis([0 24.1 -1 1.1]);
set(gca,'XTick',[10 20 24]);
set(gca,'YTick',[0 1]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;

%print('-depsc', 'param_sensitivity_mu_neg');

figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 2.5 2]);

plot(varySDsPos.priorsds, [varySDsPos.rhos_abs; varySDsPos.rhos_rel; ...
                varySDsPos.rhos_rep; varySDsPos.rhos_surp], '.', 'markersize', 8);
axis([0 15.5 -1 1.1]);
set(gca,'XTick',[5 10 15]);
set(gca,'YTick',[0 1]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;

%print('-depsc', 'param_sensitivity_sigma_pos');

figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 2.5 2]);

plot(varySDsNeg.priorsds, [varySDsNeg.rhos_abs; varySDsNeg.rhos_rel; ...
                varySDsNeg.rhos_rep; varySDsNeg.rhos_surp], '.', 'markersize', 8);
axis([0 15.5 -1 1.1]);
set(gca,'XTick',[5 10 15]);
set(gca,'YTick',[0 1]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;

%print('-depsc', 'param_sensitivity_sigma_neg');


% =============================================================================
% Residual regression analysis
% =============================================================================

% Positive attributes
residualsPos = meansPos - modelPos.rankingMeans;

figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 2.5 2]);
plot([0 48], [0 0], ':', 'Color', [0.5 0.5 0.5]);
hold on;
plot(modelPos.rankingMeans, residualsPos, 'k.', 'markersize', 8);
axis([0 48 -20 10])
set(gca,'XTick', [1 47]);
set(gca,'YTick', [-20 -10 0 10]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;

%print('-depsc', 'residual_plot_pos');

% Negative attributes
residualsNeg = meansNeg - modelNeg.rankingMeans;

figure();
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 2.5 2]);
plot([0 48], [0 0], ':', 'Color', [0.5 0.5 0.5]);
hold on;
plot(modelNeg.rankingMeans, residualsNeg, 'k.', 'markersize', 8);
axis([0 48 -20 10])
set(gca,'XTick', [1 47]);
set(gca,'YTick', [-20 -10 0 10]);
set(gca,'XTickLabel',{});
set(gca,'YTickLabel',{});
box off;

%print('-depsc', 'residual_plot_neg');