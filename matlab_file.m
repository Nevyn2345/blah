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