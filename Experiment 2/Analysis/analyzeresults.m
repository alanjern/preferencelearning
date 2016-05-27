close all;
clear all;

% Constants
n = 20;
z = 1.96;

% Load in the model predictions
model = load('../Model/positive_choicefactors_20mil');

% Data from conditions 1 to 8, ordered as shown in Figure 3 of the paper
c(1,:) = [1.5 2.5 3.5 2.5 1.5 3.5 2.5 3.5 1.5 3.5 ...
          0.5 -0.5 0.5 1.5 0.5 3.5 2.5 1.5 3.5 3.5];
c(2,:) = [0.5 0.5 3.5 0.5 0.5 1.5 1.5 3.5 1.5 1.5 ...
          3.5 2.5 3.5 -0.5 3.5 0.5 3.5 0.5 3.5 3.5];
c(3,:) = [-0.5 3.5 0.5 3.5 1.5 1.5 -0.5 3.5 1.5 3.5 ...
          0.5 2.5 1.5 1.5 3.5 2.5 0.5 -0.5 2.5 2.5];
c(4,:) = [-3.5 -0.5 3.5 -0.5 -1.5 2.5 0.5 -0.5 3.5 1.5 ...
          1.5 -0.5 2.5 -0.5 2.5 2.5 0.5 0.5 2.5 0.5];
c(5,:) = [0.5 1.5 2.5 3.5 1.5 3.5 1.5 1.5 0.5 1.5 ...
          3.5 -0.5 2.5 0.5 3.5 2.5 -0.5 2.5 3.5 -3.5];
c(6,:) = [3.5 1.5 3.5 1.5 2.5 0.5 1.5 3.5 2.5 3.5 ...
          0.5 0.5 1.5 0.5 3.5 -0.5 3.5 -3.5 3.5 3.5];
c(7,:) = [1.5 0.5 1.5 3.5 0.5 3.5 1.5 2.5 3.5 3.5 ...
          3.5 1.5 1.5 -0.5 3.5 3.5 0.5 3.5 2.5 3.5];
c(8,:) = [0.5 -2.5 1.5 -0.5 3.5 3.5 0.5 3.5 3.5 1.5 ...
          -3.5 2.5 1.5 3.5 0.5 3.5 0.5 3.5 3.5 -3.5];
          
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
figuresize = [0 0 1.2 4.9];
barpositions = [1 2 3.1 4.2 5.2 6.2 7.2 8.2];
ymin = 0.4;
ymax = 8.7;
xmin_model = -1.5;
xmax_model = 1.5;
xmin_data = -1;
xmax_data = 3.5; %3;

tickLen = 0.05;

% I'm putting the model predictions and data on the same plot
% so I need to scale up the model predictions so x=2 for data
% is the same as x=1 for model
scaledPredictions = model.predictions_absolute * (xmax_data / xmax_model);

predictionsAndData = [scaledPredictions, means'];
figure();
colormap([0.75 0.75 0.75; 0 0 0]);
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', figuresize);
barh(barpositions, flipud(predictionsAndData));
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
plot([-3 3.5], [ymax ymax],'k');
% Plot some ticks
plot([-1 -1], [ymax-tickLen ymax],'k');
plot([2 2], [ymax-tickLen ymax],'k');
%plot([3 3], [ymax-tickLen ymax],'k');
% Draw in a new x axis on bottom
plot([-3 3.5], [ymin ymin],'k');
% Plot some ticks
plot([-1 -1], [ymin+tickLen ymin],'k');
plot([2 2], [ymin+tickLen ymin],'k');
set(gcf, 'InvertHardCopy', 'off');
hold off;

%print('-depsc', 'Figures/choicefactors_results2');
