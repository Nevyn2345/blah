function [ modelCoeffs ] = fitQuadModels( X, y )
%FITQUADMODEL Generic function for fitting quadratic models
%   See also surf, meshgrid, linspace

% Check correct number of inputs
narginchk( 2, 2)

% Validate X
validateattributes(X, {'double'}, {'2d', 'real', 'nonempty'})
if size(X, 2) >= 3
    error('fitQuadModel:TooManyCols', 'X must have one or two columns.')
end % if
if any(isinf( X(:) ) )
    error('fitQuadModel:InfValues', 'X cannot contain Inf or -Inf')
end % if

% Validate Y
validateattributes(Y, {'double'}, ...
    {'column', 'real', 'nonempty', 'numel', numel(X(:,1))})
if any(isinf( y ) )
    error('fitQuadModel:InfValues', 'y cannot contain Inf or -Inf')
end % if

% Clean the data
[XClean, yClean] = removeNaNs(X, y);

% Fitting the model.
modelCoeffs = fitModel(XClean, yClean);

% Visualise the results.
% visResults(X, y, XClean, modelCoeffs);

end % fitQuadModel

function [XClean, yClean] = removeNaNs(X, y)

missingVals = any(isnan([X, y]), 2);
XClean = X(~missingVals, :);
yClean = y(~missingVals);

end %removeNaNs

function modelCoeffs = fitModel(XClean, yClean)

nVars = size(XClean, 2); % 1 or 2
switch nVars
    case 1
        A = [ones(size(XClean)), XClean, XClean.^2];
        
    case 2
        x1 = XClean(:, 1); x2 = XClean(:, 2);
        A = [ones(size(x1)), x1, x1.^2, ...
             x2, x2.^2 x1.*x2];
    otherwise
        error('FitQuadModel:WrongNumberOfVars', ...
            'X must have one or two columns')
end % switch/case
modelCoeffs = A\yClean;
end % fitmodel

function visResults(X, y, XClean, modelCoeffs)

end % visResults

