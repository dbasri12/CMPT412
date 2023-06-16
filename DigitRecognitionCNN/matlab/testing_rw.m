%% Network defintion
layers = get_lenet();
% load the trained weights
load lenet.mat

image= imread("myImages/myimg5.png");
image = imresize(image,[28 28]); %resize the image
image = rgb2gray(image);
image = reshape(image,[28*28,1]);
image = double(image);
layers{1}.batch_size = 1;
[output, P] = convnet_forward(params, layers, image);
[~,predicted_labels]=max(P)