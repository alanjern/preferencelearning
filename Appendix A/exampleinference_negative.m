
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example: Choices 11, 16, 34, 38
% Negative utility
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;

u_values = -2:-1;



p_u = [0.4 0.6];

% Enumerate all the possible utility assignments
n_possible_assignments = 2^3;
u_assignments = zeros(n_possible_assignments,3);
ui = 1;
for ua = -2:-1
	for ub = -2:-1
		for ux = -2:-1
			u_assignments(ui,:) = [ua,ub,ux];
			ui = ui+1;			
		end
	end
end

% Compute likelihoods and priors for each assignment
u_prior = ones(n_possible_assignments,1);
u_prior_h1 = zeros(n_possible_assignments,1); % Priors for utility assignments given that ux is highest
p_h1 = 0; % The probability that ux has highest utility
u_ll_11 = ones(n_possible_assignments,1);
u_ll_16 = ones(n_possible_assignments,1);
u_ll_34 = ones(n_possible_assignments,1);
u_ll_38 = ones(n_possible_assignments,1);

for i = 1:length(u_assignments)
	u = u_assignments(i,:);
	
	% Compute prior
	for j = 1:length(u)
		u_prior(i) = u_prior(i) * p_u(find(u_values == u(j)));
	end
	
	% Compute likelihoods
    u_ll_11(i) = exp(u(3)+u(1)) / ( exp(u(3)+u(1)) + exp(u(3)+u(2)) );
    u_ll_16(i) = exp(u(3)+u(1)) / ( exp(u(3)+u(1)) + exp(u(2)) );
    u_ll_34(i) = exp(u(3)) / ( exp(u(3)) + exp(u(1)) );
	u_ll_38(i) = exp(u(3)) / ( exp(u(1)) + exp(u(2)) + exp(u(3)) );
	
	
	% Compute prior and likelihood for relative utility model
    if (max(u) == u(3))
        u_prior_h1(i) = u_prior(i);
        p_h1 = p_h1 + u_prior(i);
    end
end

% Normalize the h1 prior
u_prior_h1 = u_prior_h1 ./ sum(u_prior_h1);
% Probability of making choice given than ux is highest (representativeness model)
p_choice_h1_11 = sum(u_ll_11 .* u_prior_h1);
p_choice_h1_16 = sum(u_ll_16 .* u_prior_h1);
p_choice_h1_34 = sum(u_ll_34 .* u_prior_h1);
p_choice_h1_38 = sum(u_ll_38 .* u_prior_h1);

% Compute posteriors and normalize
u_posterior_11 = (u_ll_11 .* u_prior) ./ sum(u_ll_11 .* u_prior);
u_posterior_16 = (u_ll_16 .* u_prior) ./ sum(u_ll_16 .* u_prior);
u_posterior_34 = (u_ll_34 .* u_prior) ./ sum(u_ll_34 .* u_prior);
u_posterior_38 = (u_ll_38 .* u_prior) ./ sum(u_ll_38 .* u_prior);


% Compute marginal for ux
ux_marginal_11 = zeros(length(u_values),1);
ux_marginal_16 = zeros(length(u_values),1);
ux_marginal_34 = zeros(length(u_values),1);
ux_marginal_38 = zeros(length(u_values),1);


for i = 1:length(u_assignments)
	u_index = find(u_values == u_assignments(i,3));
    ux_marginal_11(u_index) = ux_marginal_11(u_index) + u_posterior_11(i);
    ux_marginal_16(u_index) = ux_marginal_16(u_index) + u_posterior_16(i);
    ux_marginal_34(u_index) = ux_marginal_34(u_index) + u_posterior_34(i);
    ux_marginal_38(u_index) = ux_marginal_38(u_index) + u_posterior_38(i);
end

% Compute mean posterior for ux
ux_mean_posterior_11 = u_values * ux_marginal_11;
ux_mean_posterior_16 = u_values * ux_marginal_16;
ux_mean_posterior_34 = u_values * ux_marginal_34;
ux_mean_posterior_38 = u_values * ux_marginal_38;


% Compute posterior p(h=1)
p_h1_11 = p_choice_h1_11 * p_h1 / sum(u_ll_11 .* u_prior);
p_h1_16 = p_choice_h1_16 * p_h1 / sum(u_ll_16 .* u_prior);
p_h1_34 = p_choice_h1_34 * p_h1 / sum(u_ll_34 .* u_prior);
p_h1_38 = p_choice_h1_38 * p_h1 / sum(u_ll_38 .* u_prior);

% Compute reciprocal marginal likelihood (surprise model)
surprise_11 = 1/sum(u_ll_11 .* u_prior);
surprise_16 = 1/sum(u_ll_16 .* u_prior);
surprise_34 = 1/sum(u_ll_34 .* u_prior);
surprise_38 = 1/sum(u_ll_38 .* u_prior);
