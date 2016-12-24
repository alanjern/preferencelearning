close all;
clear all;

pp = parpool;

% We assume a gaussian prior on utilities such that ~98% of the mass lies above
% 0, i.e. mean = 2 * std
s_u = 2; 
u_sign = 1; % Whether utilities are positive (1) or negative (-1)

% When s -> 0, choice rule becomes maximum utility
% When s -> 1, choice rule becomes utility matching (probabilistic selection)
% When s -> inf, choice rule becomes random
s = 1;

% How many importance samples to draw
nsamples = 20000000;

X{1} = {[0 0 0 1 0;
         0 0 0 0 1]};
labels{1} = {'a/x'};
X{2} = {[0 0 0 1 0;
         0 0 0 0 1],
        [0 0 0 1 0;
         0 0 0 0 1]};
labels{2} = {'a/x','a/x'};
X{3} = {[0 0 0 1 0;
         0 0 0 0 1],
        [0 0 0 1 0;
         0 0 0 0 1],
        [0 0 0 1 0;
         0 0 0 0 1],
        [0 0 0 1 0;
         0 0 0 0 1]};
labels{3} = {'a/x','a/x','a/x','a/x'};
X{4} = {[0 0 0 2 0;
         0 0 0 0 2]};
labels{4} = {'aa/xx'};
X{5} = {[0 0 0 4 0;
         0 0 0 0 4]};
labels{5} = {'aaaa/xxxx'};
X{6} = {[1 0 0 0 0;
         0 1 0 0 0;
         0 0 1 0 0;
         0 0 0 1 0;
         0 0 0 0 1]};
labels{6} = {'d/c/b/a/x'};
X{7} = {[1 0 0 0 0;
         0 1 0 0 0;
         0 0 0 0 1],
        [0 0 1 0 0;
         0 0 0 1 0;
         0 0 0 0 1]};
labels{7} = {'d/c/x','b/a/x'};
X{8} = {[1 0 0 0 0;
         0 0 0 0 1],
        [0 1 0 0 0;
         0 0 0 0 1],
        [0 0 1 0 0;
         0 0 0 0 1],
        [0 0 0 1 0;
         0 0 0 0 1]};
labels{8} = {'d/x','c/x','b/x','a/x'};
X{9} = {[0 0 0 1 0;
         0 0 0 1 0;
         0 0 0 0 1]};
labels{9} = {'a/a/x'};
X{10} = {[0 0 0 1 0;
         0 0 0 1 0;
         0 0 0 1 0;
         0 0 0 0 1]};
labels{10} = {'a/a/a/a/x'};

nproblems = 10;
n = 5; % Num of effects 5
run_sampler = 1;

if (run_sampler == 1)

    % Draw samples from the prior
    if (u_sign > 0)
        priorsamples = mvnrnd(zeros(1,n)+2*s_u, eye(n,n)*s_u, nsamples);
    else
        priorsamples = mvnrnd(zeros(1,n)-2*s_u, eye(n,n)*s_u, nsamples);
    end
    
    % Create an indicator vector such that
    % z = 1 if x has the highest utility, else z = 0
    z = zeros(nsamples,nproblems);

    parfor problem=1:nproblems
        
        fprintf('=== Problem %d ===\n', problem);
        
        w{problem} = zeros(1,nsamples);
        w_max{problem} = zeros(1,nsamples);
        
        for i=1:nsamples
        
            if (mod(i,1000000) == 0)
                fprintf('Iteration %d\n',i);
            end
            
            % Record whether x has highest utility
            if (max(priorsamples(i,:)) == priorsamples(i,end))
                z(i,problem) = 1;
            else
                z(i,problem) = 0;
            end
            
            % Get current sample
            y = priorsamples(i,1:n);

            % Choose probabilistically from the bags proportional to total utility
            w{problem}(i) = 1;
            w_max{problem}(i) = 1;
            for d=1:length(X{problem})
                decision = X{problem}{d};
                w{problem}(i) = w{problem}(i) * ...
                    exp(y * decision(end,:)').^(1/s) / ...
                    sum(exp(y * decision').^(1/s));
                    
                % Compute w term for max model
                option_utilities = y * decision';
                if (option_utilities(end) == max(option_utilities))
                    w_max{problem}(i) = w_max{problem}(i) * 1;
                else
                    w_max{problem}(i) = w_max{problem}(i) * 0;
                end
            end         
        end
    end
    
    % Compute expected values
    for problem = 1:nproblems
        % 1) E(u_x) -- absolute utility matching
        allmeans{problem} = w{problem} * priorsamples ./ sum(w{problem});
        means(problem) = allmeans{problem}(end);
		% 2) E(z) -- relative utility matching
		pHighest(problem) = w{problem} * z(:,problem) ./ sum(w{problem});
        % 3) E(u_x) -- maximizing
        allmeans_max{problem} = w_max{problem} * priorsamples ./ sum(w_max{problem});
        means_max(problem) = allmeans_max{problem}(end);
		% 4) E(z) -- relative utility maximizing
		pHighest_max(problem) = w_max{problem} * z(:,problem) ./ sum(w_max{problem});
    end
    

end


% Set up the comparisons
% 1.1 a|x -- a|x,a|x: 							#2 - #1
% 1.2 a|x -- a|x,a|x,a|x,a|x: 					#3 - #1
% 2.1 a|x -- aa|xx:								#4 - #1
% 2.2 a|x -- aaaa|xxxx:							#5 - #1
% 3.1 a|x -- a|a|x								#9 - #1
% 3.2 a|x -- a|a|a|a|x							#10 - #1
% 4.1 d|c|b|a|x -- d|c|x,b|a|x:					#7 - #6
% 4.2 d|c|b|a|x -- d|x,c|x,b|x,a|x:				#8 - #6

    
predictions_absolute = [means(2)-means(1);
                        means(3)-means(1);
                        means(4)-means(1);
                        means(5)-means(1);
                        means(9)-means(1);
                        means(10)-means(1);
                        means(7)-means(6);
                        means(8)-means(6)];
						
predictions_relative = [pHighest(2)-pHighest(1);
                        pHighest(3)-pHighest(1);
                        pHighest(4)-pHighest(1);
                        pHighest(5)-pHighest(1);
                        pHighest(9)-pHighest(1);
                        pHighest(10)-pHighest(1);
                        pHighest(7)-pHighest(6);
                        pHighest(8)-pHighest(6)];
                      
predictions_absolute_max = [means_max(2)-means_max(1);
                            means_max(3)-means_max(1);
                            means_max(4)-means_max(1);
                            means_max(5)-means_max(1);
                            means_max(9)-means_max(1);
                            means_max(10)-means_max(1);
                            means_max(7)-means_max(6);
                            means_max(8)-means_max(6)];
							
predictions_relative_max = [pHighest_max(2)-pHighest_max(1);
                            pHighest_max(3)-pHighest_max(1);
                            pHighest_max(4)-pHighest_max(1);
                            pHighest_max(5)-pHighest_max(1);
                            pHighest_max(9)-pHighest_max(1);
                            pHighest_max(10)-pHighest_max(1);
                            pHighest_max(7)-pHighest_max(6);
                            pHighest_max(8)-pHighest_max(6)];
    

r1 = corr(predictions_absolute, predictions_relative);
fprintf('Correlation between absolute and relative utility model predictions (matching): %.3f\n',r1);	
r2 = corr(predictions_absolute_max, predictions_relative_max);
fprintf('Correlation between absolute and relative utility model predictions (maximizing): %.3f\n',r2);
	
%save('positive_maxvsmatch_20mil','predictions_absolute','predictions_absolute_max','predictions_relative');

delete(pp);