%% Interactive prototyping
load S02_MedData

%% Basic data exploration
figure
x = MedData.Age;
y = MedData.BPDiff; %Pulse Pressure
scatter(x, y, 'kx')
xlabel('Age (years)')
ylabel('Pulse Pressure (mmHG)')
title('Pulse pressure vs age')

%% Task: Aim to fit a model to this data set
%Preprocessing to deal with missing values.
missingVals = isnan(x) | isnan(y);
xClean = x(~missingVals);
yClean = y(~missingVals);
% Formulate the model and write it in the MATLAB code
% we can write this as
% pulsePressure = [1, Age, Age^2] * [c0; c1; c2]

b = yClean;
A = [ones(size(xClean)), xClean, xClean.^2];
% or xClean.^0 instead of ones
modelCoeffs = A\b; % solve the system
% Get tje fotted curve:
pulseModel = A * modelCoeffs;
% Plot
hold on
plot(xClean, pulseModel, 'r*')
legend('Raw Data', 'Fitted Model')

%% Move to two dimensions:
height = MedData.Height; % x1
waist = MedData.Waist; % x2
weight = MedData.Weight; % y
%Problem: Can we estimate weight y using height and weight?
% We'll use a quadratic model

% step 1: plot the raw data (scatter3)
figure
scatter3(height, waist, weight, 'kx')

% step 2: Clean up the data (isnan)
badRows = any(isnan([height, waist, weight]),2);
height_c = height(~badRows);
waist_c = waist(~badRows);
weight_c = weight(~badRows);
% step 3: formulate and solve the model


b = weight_c;
A = [ones(size(height_c)), height_c, height_c.^2, ...
    waist_c, waist_c.^2 waist_c.*height_c];

modelCoeffs = A\b;

% Step 4: Visualisation.
modelFun = @(c, x1, x2) c(1) + c(2)*x1 + c(3)*x1.^2+ ...
        c(4)*x2 + c(5)*x2.^2 + c(6)*x1.*x2;
    
% Substep 1: make vector data for x1 and x2.
x1Vec = linspace(min(height_c), max(height_c), 150);
x2Vec = linspace(min(waist_c), max(height_c), 150);
% Substep 2: turn this into a grid
[X1, X2] = meshgrid(x1Vec, x2Vec);
% Substep 3: evaulate the model on the grid.
modelOnGrid = modelFun(modelCoeffs, X1, X2);
hold on
surf(X1, X2, modelOnGrid, 'EdgeAlpha', 0);
% EdgeAlpha - transparency of edges in the grid
%shading interp % Use interpolated shading.

