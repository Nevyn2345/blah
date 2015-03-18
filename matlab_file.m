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
scatter3(height, waist, weight)

% step 2: Clean up the data (isnan)
missingVals = isnan(height) | isnan(waist) | isnan(weight);
height_c = height(~missingVals);
waist_c = waist(~missingVals);
weight_c = weight(~missingVals);
% step 3: formulate and solve the model
