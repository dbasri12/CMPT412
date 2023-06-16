%% Network defintion
layers = get_lenet();
% load the trained weights
load lenet.mat

%image= imread("myImages/myimg4.png");
%image = imresize(image,[28 28]); %resize the image
%image = rgb2gray(image);
%image = reshape(image,[28*28,1]);
%image = double(image);
%layers{1}.batch_size = 1;
%[output, P] = convnet_forward(params, layers, image);
%[~,predicted_labels]=max(P);


I = imread("images/image4.jpg");
level = graythresh(I);

im_BW=imcomplement(BW);
BW = imbinarize(I,level);
figure;
testBW=im2bw(I);
testBW=imcomplement(testBW);
cc = bwconncomp(testBW); %Find connected components
stats = regionprops(cc,'BoundingBox','Area'); %Extract properties
%stats(2)
%imshowpair(I,testBW,'montage')
layers{1}.batch_size = 1;
figure;
imshow(I);
hold on;
prediction=[];
for i = 1:length(stats)
    thisBB =stats(i).BoundingBox;
    rectangle('Position',[thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','r','LineWidth',2);%    hold on;
    x = thisBB(1);
    y = thisBB(2);
    w = thisBB(3);
    h = thisBB(4);
    if w < h
        w = h;
    elseif h < w
        h = w;
    end

    %resize the bounding box to 28x28
    img = imresize(imcrop(testBW,[x y w h]), [28 28]);
    testimg=reshape(img,[28*28,1]);
    [output, P] = convnet_forward(params, layers, testimg);
    [~,predicted_labels]=max(P);
    prediction=[prediction,predicted_labels];
end

%hold off;