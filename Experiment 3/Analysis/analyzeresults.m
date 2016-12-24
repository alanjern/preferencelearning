close all;
clear all;

% Comparisons
% 1.1 a|x -- a|x,a|x
% 1.2 a|x,a|x -- a|x,a|x,a|x,a|x
% 1.3 a|x -- a|x,a|x,a|x,a|x
% 2.1 a|x -- aa|xx
% 2.2 aa|xx -- aaaa|xxxx
% 2.3 a|x -- aaaa|xxxx
% 3.1 d|c|b|a|x -- d|c|x,b|a|x
% 3.2 d|c|x,b|a|x -- d|x,c|x,b|x,a|x
% 3.3 d|c|b|a|x -- d|x,c|x,b|x,a|x
% 4.1 a|x -- a|a|x
% 4.2 a|a|x -- a|a|a|a|x
% 4.3 a|x -- a|a|a|a|x 

% Model includes predictions for some conditions not discussed in paper.
% Included comparisons (in presentation order): 1.1, 1.3, 2.1 2.3, 4.1, 4.3, 3.1, 3.3
% This vector defines the indices of the included comparisons
abbreviated_set = [1 3 4 6 10 12 7 9];

% Constants
n = 20;
z = 1.96;

% Load in the model predictions
model = load('../Model/positive_maxvsmatch_20mil');

% Data from conditions 1 to 8, ordered as shown in Figure 4 of the paper
c(1,:) = [1 1 -3 1 2 0 3 3 0 1 2 2 1 1 0 3 1 0 0 3 1 3 1 0 1 0 2 1 1 3];
c(2,:) = [3 1 2 2 2 1 3 3 0 2 2 2 1 2 1 3 2 1 1 3 1 3 0 1 1 0 3 2 1 3];
c(3,:) = [0 0 2 0 1 0 0 3 0 1 0 3 0 1 0 3 0 2 0 3 3 0 2 0 0 0 2 0 -1 3];
c(4,:) = [0 0 -2 0 2 0 0 3 0 2 2 3 0 0 0 3 0 2 2 3 -2 3 1 0 0 0 2 1 1 3];
c(5,:) = [2 0 3 2 1 0 0 3 0 -1 0 3 1 1 0 0 1 -2 1 3 0 3 1 0 1 0 0 1 0 0];
c(6,:) = [3 0 2 3 2 0 0 3 0 0 2 2 1 0 0 0 1 -2 1 3 1 3 -1 0 1 0 2 1 1 0];
c(7,:) = [1 1 -3 1 -3 0 3 2 1 0 2 1 1 1 1 3 2 1 2 -3 3 -3 1 0 1 0 2 0 -1 1];
c(8,:) = [2 1 0 3 2 0 0 3 0 3 2 -2 1 1 1 3 2 3 3 3 2 -3 -1 1 2 0 3 -1 -1 2];

% Compute statistics
means = mean(c');
CIs = z*std(c') / sqrt(n);

% Perform hypothesis tests
% One-sample t-test
% Null hypothesis: Mean <= 0 (i.e. one-tailed t-test)
fprintf('One-tailed t-test results\n');

[h p] = ttest(c(1,:), 0, 'tail', 'right');
fprintf('Condition 1: %.5f\n',p);
[h p] = ttest(c(2,:), 0, 'tail', 'right');
fprintf('Condition 2: %.5f\n',p);
[h p] = ttest(c(3,:), 0, 'tail', 'right');
fprintf('Condition 3: %.5f\n',p);
[h p] = ttest(c(4,:), 0, 'tail', 'right');
fprintf('Condition 4: %.5f\n',p);
[h p] = ttest(c(5,:), 0, 'tail', 'right');
fprintf('Condition 5: %.5f\n',p);
[h p] = ttest(c(6,:), 0, 'tail', 'right');
fprintf('Condition 6: %.5f\n',p);
[h p] = ttest(c(7,:), 0, 'tail', 'right');
fprintf('Condition 7: %.5f\n',p);
[h p] = ttest(c(8,:), 0, 'tail', 'right');
fprintf('Condition 8: %.5f\n',p);

% Plot figure
figuresize = [0 0 1.2 6]; 
barpositions = [1.4 2.8 3.8 4.8 5.9 7 8.3 9.6];
ymin = 0.5;
ymax = 10.3;
xmax_model = 1;
xmin_data = -1;
xmax_data = 2.6;

tickLen = 0.05;

% I'm putting the model predictions and data on the same plot
% so I need to scale up the model predictions so x=2 for data
% is the same as x=1 for model
scaledPredictions = model.predictions_absolute * (xmax_data / xmax_model);

predictionsAndData = [scaledPredictions(abbreviated_set), means'];
f1=figure();
colormap([0.75 0.75 0.75; 0 0 0]);
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', figuresize);
barh(barpositions, flipud(predictionsAndData), 0.8);
hold on;
herrorbar(fliplr(means), barpositions+0.15, zeros(1,8), CIs,'k.');
box off;
axis off;
xlim([xmin_data xmax_data]);
ylim([ymin ymax]);
set(gca,'YTick',[]);
set(gcf,'Color','none');
set(gca,'Color','none');
% Draw in a new x axis on top
plot([xmin_data xmax_data], [ymax ymax],'k');
% Plot some ticks
plot([-1 -1], [ymax-tickLen ymax],'k');
plot([2 2], [ymax-tickLen ymax],'k');
% Draw in a new x axis on bottom
plot([xmin_data xmax_data], [ymin ymin],'k');
% Plot some ticks
plot([-1 -1], [ymin+tickLen ymin],'k');
plot([2 2], [ymin+tickLen ymin],'k');
set(gcf, 'InvertHardCopy', 'off');
hold off;

%print('-depsc', 'Figures/maxvsmatch_abbreviated_results');
