%% Preallocation (pages 5-7, 8, 9)

tic
X = zeros(10); % Be carefull, zero might be an actual datapoint
%y = NaN(10);
for k1=1:10
    for k2=1:10
        X(k1, k2) = k1^2 +k2^2 -1;
    end % for k2
end % for k1
toc

%% Implicit preallocation
tic
for k1 = 10:-1:1
    for k2 = 10:-1:1
        X(k1, k2) = k1^2 +k2^2 -1;
    end
end
toc

%% cells/structures.
% Preallocate using CELL/STRUCT




