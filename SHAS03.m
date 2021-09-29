clc;
clear;
close all;
%% 
pc = pcread('Regard3D/SHAS03.ply');
pcshow(pc)
%%
minDistance = 1000;
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
head_ind = order(1);
headPtCloud = select(pc,labels==head_ind);
figure
plot(1:numClusters,tally)
figure
pcshow(headPtCloud)
plane3 = headPtCloud;
%% 
pnt = pc.Location;
xl = plane3.XLimits(1); xu = plane3.XLimits(2);
yl = plane3.YLimits(1); yu = plane3.YLimits(2);
zl = plane3.ZLimits(1); zu = plane3.ZLimits(2);
inlierIndices = find(pnt(:,1)>xl & pnt(:,1)<xu & pnt(:,2)>yl & pnt(:,2)<yu ...
& pnt(:,3)>zl & pnt(:,3)<zu);
plane33 = select(pc,inlierIndices);
figure;
pcshow(plane33);
plane3 = plane33
%% 
clr = plane3.Color;
thres = 120;
nonWhiteVoxels = find(clr(:,1)<thres | clr(:,2)<thres | clr(:,3)<thres);
plane4 = select(plane3,nonWhiteVoxels);
figure;
pcshow(plane4);

%%
pcwrite(plane3,'Matlab/SHAS03(matlab).ply')
