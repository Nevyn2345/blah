%% Basic Performance Measures
tic
A = rand(1e3);
toc
%% Processing Time
t1 = cputime;
A = rand(1e3);
t2 = cputime;
delta_t = t2-t1

%% From 13b onwards, also have TIMEIT
myFunc = @() rand(1e3);
t_avg = timeit(myFunc)

%% MATLAB profiler.
profile on
prediction = findBestPredictors_debug()
profile off
profile viewer
% Advanced Exercise: use parallel computing and HPIC