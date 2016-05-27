% We assume that there is a vector of decisions d = [d_1 d_2 ... d_m]
% d_i = {1,2,3,...,c} where c is the number of choices.
% There are n possible effects for each decision.
%
% x_i is a binary vector indicating which of the m effects follow from
% decision d_i.
%
% beta is a vector of utilities assigned to each of the effects, where
% we assume that the utility for a decision d_i is the sum of the
% utilities of its effects.
%
% Therefore, P(beta | d,X) \propto P(d | beta,X) * P(beta | X)
%                          \propto P(d | beta,X) * P(beta)
%
%

close all;
clear all;

% We assume a gaussian prior on utilities such that ~98% of the mass lies above
% 0, i.e. mean = 2 * std
s_u = 2;
u_sign = 1; % Whether utilities are positive (1) or negative (-1)

% And we assume the selection is made using the following probabilistic rule
%   P(i) = exp(u_i)^(1/s) / (\sum_j{exp(u_j)^(1/s)})
% When s -> 0, choice rule becomes maximum utility
% When s -> 1, choice rule becomes utility matching (probabilistic selection)
% When s -> inf, choice rule becomes random
s = 1;

% How many importance samples to draw
nsamples = 20000000;

% X{i} = a [option-by-effect] matrix where each row represents x_i
% 1) 1 chosen attribute, 2 forgone attributes
C1F2 = 1;
X{C1F2}{1} = [1 0 0;
              0 1 0;
              0 0 1];
% 2) 1 chosen attribute, 4 forgone attributes
C1F4 = 2;
X{C1F4}{1} = [1 1 0 0 0;
              0 0 1 1 0;
              0 0 0 0 1];
% 3) 2 chosen attributes, 2 forgone attributes
C2F2 = 3;
X{C2F2}{1} = [1 0 0 0;
              0 1 0 0;
              0 0 1 1];
% 4) 2 chosen attributes, 4 forgone attributes
C2F4 = 4;
X{C2F4}{1} = [1 1 0 0 0 0;
              0 0 1 1 0 0;
              0 0 0 0 1 1];
% 5) 2 options
O2 = 5;
X{O2}{1} = [1 1 1 0;
            0 0 0 1];
% 6) 4 options
O4 = 6;
X{O4}{1} = [1 0 0 0;
            0 1 0 0;
            0 0 1 0;
            0 0 0 1];
% 7) 3 choices
C3 = 7;
X{C3}{1} = [1 0 0 0;
            0 0 0 1];
X{C3}{2} = [0 1 0 0;
            0 0 0 1];
X{C3}{3} = [0 0 1 0;
            0 0 0 1];

nproblems = 7;
% Selected option is always last row
chosen_option = [3 3 3 3 2 4 2];
nchoices = [1 1 1 1 1 1 3];
neffects = [3 5 4 6 4 4 4];
    
% Draw samples from the prior
if (u_sign > 0)
	priorsamples = mvnrnd(zeros(1,6)+2*s_u, eye(6,6)*s_u, nsamples);
else
	priorsamples = mvnrnd(zeros(1,6)-2*s_u, eye(6,6)*s_u, nsamples);
end

% Create an indicator vector such that
% z = 1 if x has the highest utility, else z = 0
z = zeros(nsamples,nproblems);

parfor problem=1:nproblems

	option = chosen_option(problem);
	nc = nchoices(problem);
	n = neffects(problem);
	
	fprintf('=== Problem %d ===\n', problem);
	
	w{problem} = zeros(1,nsamples);
	
	for i=1:nsamples
	
		if (mod(i,1000000) == 0)
			fprintf('Iteration %d\n',i);
		end
		
		% Record whether x has highest utility
		if (max(priorsamples(i,:)) == priorsamples(i,neffects(problem)))
			z(i,problem) = 1;
		else
			z(i,problem) = 0;
		end
		
		% Get current sample
		y = priorsamples(i,1:n);
		
		% Compute likelihood
		w{problem}(i) = 1;
		for j=1:nc
			w{problem}(i) = w{problem}(i) * exp(y * X{problem}{j}(option,:)').^(1/s) / ...
				sum(exp(y * X{problem}{j}').^(1/s));
		end                                       
	end
end

% Compute expected values
for problem = 1:nproblems
	% E(u_x) -- absolute utility model 
	allmeans{problem} = w{problem} * priorsamples ./ sum(w{problem});
	means(problem) = allmeans{problem}(neffects(problem));
	% E(z) -- relative utility model
	pHighest(problem) = w{problem} * z(:,problem) ./ sum(w{problem});
end

% Save the results
predictions_absolute = [means(C1F2)-means(C2F2),
						means(C1F4)-means(C2F4),
						means(C1F4)-means(C1F2),
						means(C2F4)-means(C2F2),
						means(O2)-means(O4),
						means(C3)-means(O4),
						means(C1F4)-means(C2F2),
						means(C1F2)-means(C2F4)];
						
predictions_relative = [pHighest(C1F2)-pHighest(C2F2),
					pHighest(C1F4)-pHighest(C2F4),
					pHighest(C1F4)-pHighest(C1F2),
					pHighest(C2F4)-pHighest(C2F2),
					pHighest(O2)-pHighest(O4),
					pHighest(C3)-pHighest(O4),
					pHighest(C1F4)-pHighest(C2F2),
					pHighest(C1F2)-pHighest(C2F4)];
					
labels = {'C1F2-C2F2', 'C1F4-C2F4', 'C1F4-C1F2', 'C2F4-C2F2', ...
		  'O2-O4', 'C3-O4', 'C1F4-C2F2', 'C1F2-C2F4'};
		  

r = corr(predictions_absolute, predictions_relative);
fprintf('Correlation between absolute and relative utility model predictions: %.3f\n',r);		  

		  
%save('positive_choicefactors_20mil','predictions_absolute','labels');




