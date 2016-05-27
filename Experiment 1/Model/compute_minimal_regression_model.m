function [f min_mae] = compute_minimal_regression_model(y,X,mae_thresh)
% Perform a linear regression of x on y, adding one factor at
% a time until the best case MAE (mean absolute error) is below
% a given threshold
%
%
% Returns a vector of the factors in the resulting model.
%
% Inputs
%   X -- an n x p matrix of predictors where n is number of 
%        observations and p is number of factors
%   y -- an n x 1 matrix of outcomes
%   mae_thesh -- the MAE threshold

% Perform regression analysis for every set of predictors up to
% a total of k

n = length(y);
p = size(X,2);
f = 1:p;

min_mae = inf;

% k = 1
for i1=1:p
    b = regress(y,[X(:,i1) ones(n,1)]);
    % Compute MAE
    z=b'*[X(:,[i1]) ones(n,1)]';
    mae = sum(abs(z'-y)) / n;
    if (mae < min_mae)
        min_mae = mae;
        f = [i1];
    end
end
if (min_mae <= mae_thresh)
    return;
end



% k = 2
for i1=1:p
    for i2=(i1+1):p
        b = regress(y,[X(:,[i1 i2]) ones(n,1)]);
        % Compute MAE
        z=b'*[X(:,[i1 i2]) ones(n,1)]';
        mae = sum(abs(z'-y)) / n;
        if (mae < min_mae)
            min_mae = mae;
            f = [i1 i2];
        end
    end
end
if (min_mae <= mae_thresh)
    return;
end



% k = 3
for i1=1:p
    for i2=(i1+1):p
        for i3=(i2+1):p
            b = regress(y,[X(:,[i1 i2 i3]) ones(n,1)]);
            % Compute MAE
            z=b'*[X(:,[i1 i2 i3]) ones(n,1)]';
            mae = sum(abs(z'-y)) / n;
            if (mae < min_mae)
                min_mae = mae;
                f = [i1 i2 i3];
            end
        end
    end
end
if (min_mae <= mae_thresh)
    return;
end



% k = 4
for i1=1:p
    for i2=(i1+1):p
        for i3=(i2+1):p
            for i4=(i3+1):p
                b = regress(y,[X(:,[i1 i2 i3 i4]) ones(n,1)]);
                % Compute MAE
                z=b'*[X(:,[i1 i2 i3 i4]) ones(n,1)]';
                mae = sum(abs(z'-y)) / n;
                if (mae < min_mae)
                    min_mae = mae;
                    f = [i1 i2 i3 i4];
                end
            end
        end
    end
end
if (min_mae <= mae_thresh)
    return;
end


% k = 5
for i1=1:p
    for i2=(i1+1):p
        for i3=(i2+1):p
            for i4=(i3+1):p
                for i5=(i4+1):p
                    b = regress(y,[X(:,[i1 i2 i3 i4 i5]) ones(n,1)]);
                    % Compute MAE
                    z=b'*[X(:,[i1 i2 i3 i4 i5]) ones(n,1)]';
                    mae = sum(abs(z'-y)) / n;
                    if (mae < min_mae)
                        min_mae = mae;
                        f = [i1 i2 i3 i4 i5];
                    end
                end
            end
        end
    end
end
if (min_mae <= mae_thresh)
    return;
end



% k = 6
for i1=1:p
    for i2=(i1+1):p
        for i3=(i2+1):p
            for i4=(i3+1):p
                for i5=(i4+1):p
                    for i6=(i5+1):p
                        b = regress(y,[X(:,[i1 i2 i3 i4 i5 i6]) ones(n,1)]);
                        % Compute MAE
                        z=b'*[X(:,[i1 i2 i3 i4 i5 i6]) ones(n,1)]';
                        mae = sum(abs(z'-y)) / n;
                        if (mae < min_mae)
                            min_mae = mae;
                            f = [i1 i2 i3 i4 i5 i6];
                        end
                    end
                end
            end
        end
    end
end
if (min_mae <= mae_thresh)
    return;
end


% k = 7
for i1=1:p
    for i2=(i1+1):p
        for i3=(i2+1):p
            for i4=(i3+1):p
                for i5=(i4+1):p
                    for i6=(i5+1):p
                        for i7=(i6+1):p
                            b = regress(y,[X(:,[i1 i2 i3 i4 i5 i6 i7]) ones(n,1)]);
                            % Compute MAE
                            z=b'*[X(:,[i1 i2 i3 i4 i5 i6 i7]) ones(n,1)]';
                            mae = sum(abs(z'-y)) / n;
                            if (mae < min_mae)
                                min_mae = mae;
                                f = [i1 i2 i3 i4 i5 i6 i7];
                            end
                        end
                    end
                end
            end
        end
    end
end
if (min_mae <= mae_thresh)
    return;
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
                                b = regress(y,[X(:,[i1 i2 i3 i4 i5 i6 i7 i8]) ones(n,1)]);
                                % Compute MAE
                                z=b'*[X(:,[i1 i2 i3 i4 i5 i6 i7 i8]) ones(n,1)]';
                                mae = sum(abs(z'-y)) / n;
                                if (mae < min_mae)
                                    min_mae = mae;
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
% Find the best fitting model 1-factor model
if (min_mae <= mae_thresh)
    return;
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
                                    b = regress(y,[X(:,[i1 i2 i3 i4 i5 i6 i7 i8 i9]) ones(n,1)]);
                                    % Compute MAE
                                    z=b'*[X(:,[i1 i2 i3 i4 i5 i6 i7 i8 i9]) ones(n,1)]';
                                    mae = sum(abs(z'-y)) / n;
                                    if (mae < min_mae)
                                        min_mae = mae;
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
% Find the best fitting model 1-factor model
if (min_mae <= mae_thresh)
    return;
end


% k = 10
for i1=1:p
    for i2=(i1+1):p
        for i3=(i2+1):p
            for i4=(i3+1):p
                for i5=(i4+1):p
                    for i6=(i5+1):p
                        for i7=(i6+1):p
                            for i8=(i7+1):p
                                for i9=(i8+1):p
                                    for i10=(i9+1):p
                                        b = regress(y,[X(:,[i1 i2 i3 i4 i5 i6 i7 i8 i9 i10]) ones(n,1)]);
                                        % Compute MAE
                                        z=b'*[X(:,[i1 i2 i3 i4 i5 i6 i7 i8 i9 i10]) ones(n,1)]';
                                        mae = sum(abs(z'-y)) / n;
                                        if (mae < min_mae)
                                            min_mae = mae;
                                            f = [i1 i2 i3 i4 i5 i6 i7 i8 i9 i10];
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
end
% Find the best fitting model 1-factor model
if (min_mae <= mae_thresh)
    return;
end


f = 1:p;


