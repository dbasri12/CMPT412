% A test script using templeCoords.mat
%
% Write your code here
%
clear all; close all;

image1 = imread('im1.png');
image2 = imread('im1.png');
load('someCorresp.mat');
fundMatrix = eightpoint(pts1, pts2, M);
load('templeCoords.mat');
points2 = zeros(size(pts1));
for idx = 1 : size(pts1, 1)
    points2(idx, :) = epipolarCorrespondence(image1, image2, fundMatrix, pts1(idx, :));
end

load('intrinsics.mat');
essentialMat = essentialMatrix(fundMatrix, K1, K2);
projMatrix1 = K1 * [eye(3), zeros(3, 1)];
candProjMatrices2 = camera2(essentialMat);
min_cost = 1e10;
for idx = 1: 4
    if det(candProjMatrices2(1:3, 1:3, idx)) ~= 1
        candProjMatrices2(:, :, idx) = K2 * candProjMatrices2(:, :, idx);    
        points3D = triangulate(projMatrix1, pts1, candProjMatrices2(:, :, idx), points2);
        projected1 = projMatrix1 * points3D.';
        projected2 = candProjMatrices2(:, :, idx) * points3D.';
        projected1 = (projected1 ./ projected1(3, :)).';
        projected2 = (projected2 ./ projected2(3, :)).';
        if sum(points3D(:, 3) > 0, 'all') == size(points3D, 1)
            dist1 = norm(pts1 - projected1(:, 1:2)) / size(points3D, 1)
            dist2 = norm(points2 - projected2(:, 1:2)) / size(points3D, 1)
            if dist1 + dist2 < min_cost
                min_cost = (dist1 + dist2);
                points3D_final = points3D;
                projMatrix2 = candProjMatrices2(:, :, idx);
            end
        end
    end
end
plot3(points3D_final(:, 1), points3D_final(:, 2), points3D_final(:, 3), 'r.');
view(90,0);
axis equal
rotMatrix1 = K1 \ projMatrix1(1:3, 1:3);
transVec1 = K1 \ projMatrix1(:, 4);
rotMatrix2 = K2 \ projMatrix2(1:3, 1:3);
transVec2 = K2 \ projMatrix2(:, 4);
% save extrinsic parameters for dense reconstruction
save('extrinsics.mat', 'rotMatrix1', 'transVec1', 'rotMatrix2', 'transVec2');
