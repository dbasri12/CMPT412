function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
if size(I1,3)==3
    I1 = rgb2gray(I1);
end
if size(I2,3)==3
    I2 = rgb2gray(I2);
end
%% Detect features in both images
features1 = detectFASTFeatures(I1);
features2 = detectFASTFeatures(I2);
%% Obtain descriptors for the computed feature locations
[features1,vp1] = computeBrief(I1,features1.Location);
[features2,vp2] = computeBrief(I2,features2.Location);
%% Match features using the descriptors
idxPairs = matchFeatures(features1, features2,'MatchThreshold', 10., 'MaxRatio', 0.68);
matchedPoints1 = vp1(idxPairs(:,1),:);
matchedPoints2 = vp2(idxPairs(:,2),:);
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
locs1 = matchedPoints1;
locs2 = matchedPoints2;
end

