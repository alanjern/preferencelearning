function [f b_best] = choose_regression_parameters(ytrain,Xtrain,ytest,Xtest)
% Perform a linear regression of Xtrain on ytrain for all subsets of features in Xtrain
% to find the best subset of features that leads to the best transfer performance on
% the test set (ytest,Xtest)
%
% Returns
%   f -- a vector of the factors in the resulting model
%   b_best -- the regression coefficients that produce the max rank correlation
%
% Inputs
%   Xtrain -- an n x p matrix of predictors where n is number of 
%        	  observations and p is number of factors
%   ytrain -- an n x 1 matrix of outcomes
%   Xtest  -- predictors for test set, same size as Xtrain
%   ytrain -- outcomes for test set, same size as ytrain

% Perform regression analysis for every set of predictors up to
% a total of k

ntrain = length(ytrain);
ntest = length(ytest);
p = size(Xtrain,2);
f = 1:p;

max_rho = -1;
b_best = zeros(size(Xtrain,2),1);

% k = 1
for i1=1:p
    b = regress(ytrain,[Xtrain(:,i1) ones(ntrain,1)]);
    z=b'*[Xtest(:,[i1]) ones(ntest,1)]';
    % Compute rho
    rho = corr(ytest, z', 'type', 'Spearman');
    if (rho > max_rho)
        max_rho = rho;
		b_best = b;
        f = [i1];
    end
end

% k = 2
for i1=1:p
    for i2=(i1+1):p
        b = regress(ytrain,[Xtrain(:,[i1 i2]) ones(ntrain,1)]);
        z=b'*[Xtest(:,[i1 i2]) ones(ntest,1)]';
        % Compute rho
        rho = corr(ytest, z', 'type', 'Spearman');
        if (rho > max_rho)
            max_rho = rho;
			b_best = b;
            f = [i1 i2];
        end
    end
end


% k = 3
for i1=1:p
    for i2=(i1+1):p
        for i3=(i2+1):p
            b = regress(ytrain,[Xtrain(:,[i1 i2 i3]) ones(ntrain,1)]);
            z=b'*[Xtest(:,[i1 i2 i3]) ones(ntest,1)]';
            % Compute rho
            rho = corr(ytest, z', 'type', 'Spearman');
            if (rho > max_rho)
                max_rho = rho;
				b_best = b;
                f = [i1 i2 i3];
            end
        end
    end
end

% k = 4
for i1=1:p
    for i2=(i1+1):p
        for i3=(i2+1):p
            for i4=(i3+1):p
                b = regress(ytrain,[Xtrain(:,[i1 i2 i3 i4]) ones(ntrain,1)]);
                z=b'*[Xtest(:,[i1 i2 i3 i4]) ones(ntest,1)]';
                % Compute rho
                rho = corr(ytest, z', 'type', 'Spearman');
                if (rho > max_rho)
                    max_rho = rho;
					b_best = b;
                    f = [i1 i2 i3 i4];
                end
            end
        end
    end
end

% k = 5
for i1=1:p
    for i2=(i1+1):p
        for i3=(i2+1):p
            for i4=(i3+1):p
                for i5=(i4+1):p
                    b = regress(ytrain,[Xtrain(:,[i1 i2 i3 i4 i5]) ones(ntrain,1)]);
                    z=b'*[Xtest(:,[i1 i2 i3 i4 i5]) ones(ntest,1)]';
                    % Compute rho
                    rho = corr(ytest, z', 'type', 'Spearman');
                    if (rho > max_rho)
                        max_rho = rho;
						b_best = b;
                        f = [i1 i2 i3 i4 i5];
                    end
                end
            end
        end
    end
end


% k = 6
for i1=1:p
    for i2=(i1+1):p
        for i3=(i2+1):p
            for i4=(i3+1):p
                for i5=(i4+1):p
                    for i6=(i5+1):p
                        b = regress(ytrain,[Xtrain(:,[i1 i2 i3 i4 i5 i6]) ones(ntrain,1)]);
                        z=b'*[Xtest(:,[i1 i2 i3 i4 i5 i6]) ones(ntest,1)]';
                        % Compute rho
                        rho = corr(ytest, z', 'type', 'Spearman');
                        if (rho > max_rho)
                            max_rho = rho;
							b_best = b;
                            f = [i1 i2 i3 i4 i5 i6];
                        end
                    end
                end
            end
        end
    end
end

% k = 7
for i1=1:p
    for i2=(i1+1):p
        for i3=(i2+1):p
            for i4=(i3+1):p
                for i5=(i4+1):p
                    for i6=(i5+1):p
                        for i7=(i6+1):p
                            b = regress(ytrain,[Xtrain(:,[i1 i2 i3 i4 i5 i6 i7]) ones(ntrain,1)]);
                            z=b'*[Xtest(:,[i1 i2 i3 i4 i5 i6 i7]) ones(ntest,1)]';
                            % Compute rho
                            rho = corr(ytest, z', 'type', 'Spearman');
                            if (rho > max_rho)
                                max_rho = rho;
								b_best = b;
                                f = [i1 i2 i3 i4 i5 i6 i7];
                            end
                        end
                    end
                end
            end
        end
    end
end


% k = 8
for i1=1:p
    for i2=(i1+1):p
        for i3=(i2+1):p
            for i4=(i3+1):p
                for i5=(i4+1):p
                    for i6=(i5+1):p
                        for i7=(i6+1):p
                            for i8=(i7+1):p
                                b = regress(ytrain,[Xtrain(:,[i1 i2 i3 i4 i5 i6 i7 i8]) ones(ntrain,1)]);
                                z=b'*[Xtest(:,[i1 i2 i3 i4 i5 i6 i7 i8]) ones(ntest,1)]';
                                % Compute rho
                                rho = corr(ytest, z', 'type', 'Spearman');
                                if (rho > max_rho)
                                    max_rho = rho;
									b_best = b;
                                    f = [i1 i2 i3 i4 i5 i6 i7 i8];
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

% k = 9
for i1=1:p
    for i2=(i1+1):p
        for i3=(i2+1):p
            for i4=(i3+1):p
                for i5=(i4+1):p
                    for i6=(i5+1):p
                        for i7=(i6+1):p
                            for i8=(i7+1):p
                                for i9=(i8+1):p
                                    b = regress(ytrain,[Xtrain(:,[i1 i2 i3 i4 i5 i6 i7 i8 i9]) ones(ntrain,1)]);
                                    z=b'*[Xtest(:,[i1 i2 i3 i4 i5 i6 i7 i8 i9]) ones(ntest,1)]';
                                    % Compute rho
                                    rho = corr(ytest, z', 'type', 'Spearman');
                                    if (rho > max_rho)
                                        max_rho = rho;
										b_best = b;
                                        f = [i1 i2 i3 i4 i5 i6 i7 i8 i9];
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

% k = 10
b = regress(ytrain,[Xtrain ones(ntrain,1)]);
z=b'*[Xtest ones(ntest,1)]';
% Compute rho
rho = corr(ytest, z', 'type', 'Spearman');
if (rho > max_rho)
	disp('gothere')
    max_rho = rho;
    f = 1:p;
	b_best = b;
end



