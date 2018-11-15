clear;clc;
% simple sample data
% points = [46,42;37,52;52,64;52,33;52,41;62,42;42,57];
% demand = [0,19,16,11,15,8,8];
filename= 'db/tests1.csv';
[~,~,file_data] = xlsread( filename);
data = cell2mat(file_data);
demand = data(:,1)';
points = data(:,2:3);

global CantP CantV CV PR D DT MDist DistTotal Rule
PR = points;                               % Coordinates
D = demand;                                % Demands
CantP=length(D);                           % Total of points
CV = 40;                                   % Vehicle max capacity
DT = sum(D);                               % Total demand
CantV=round(DT/CV)+round(CantP*0.05);      % Vehicle quantity approximate
[MDist, DistTotal]= dist(PR);              % Distance matrix, max distance, (Euclidean)
% Calculate data for Rule.
x=fix(DistTotal);
xs = num2str(x);
Rule = length(xs);                         % Rule, length of max distance in digits.
nvars = CantP*CantV;                       % Variables number
lb = zeros(1,CantP*CantV);                 % Lower limits
ub =CantP*ones(1,CantP*CantV);             % Upper limits

rng default                                % For reproducibility
fitnessfcn = @simple_o_function;

% use this configuration if you wants to see the iterations data
% options = optimoptions('particleswarm', 'Display', 'iter','TolFun',1e-10);
options = optimoptions('particleswarm', 'TolFun',1e-10);
% Do 30 runs of the algorithm.
for i=1:30
    tic
    x = particleswarm(fitnessfcn,nvars,lb,ub, options);
    time = toc;
    % Save to a file all results in iteration
    save(strcat('results/pso_',num2str(i)));
end
