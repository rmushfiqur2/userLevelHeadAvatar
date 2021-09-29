clc;
clear;
close all;
%% 
pc = pcread('Regard3D/SHAS02.ply');
pcshow(pc)
%%
minDistance = 1;
[labels,numClusters] = pcsegdist(pc,minDistance);
figure
pcshow(pc.Location,labels)
colormap(hsv(numClusters))
title('Point Cloud Clusters')
%% 
% https://www.mathworks.com/matlabcentral/answers/473048-finding-frequency-of-values-in-an-array
tally = accumarray(labels, 1); % labels is ordered
[~,head_ind] = max(tally);
[~,order] = sort(tally, 'descend');
head_ind = order(2);
headPtCloud = select(pc,labels==head_ind);
figure
plot(1:numClusters,tally)
figure
pcshow(headPtCloud)
plane3 = headPtCloud;
%% 
clr = plane3.Color;
thres = 120;
nonWhiteVoxels = find(clr(:,1)<thres | clr(:,2)<thres | clr(:,3)<thres);
plane4 = select(plane3,nonWhiteVoxels);
figure;
pcshow(plane4);
%%
pcwrite(plane4,'Matlab/SHAS02(matlab).ply')
