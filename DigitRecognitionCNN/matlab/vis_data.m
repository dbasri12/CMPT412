layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;
 
 
layers{1}.batch_size = 1;
img = xtest(:, 1);
img = reshape(img, 28, 28);
figure
imshow(img')
hold on;
%[cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));
output = convnet_forward(params, layers, xtest(:, 1));
output_1 = reshape(output{1}.data, 28, 28);
%imshow(output_1')
output2=reshape(output{2}.data,[24,24,20]);
figure
for i = 1:20
    subplot(4,5,i);
    imshow(output2(:,:,i)')
end

output3=reshape(output{3}.data,[24,24,20]);
figure
for i = 1:20
    subplot(4,5,i);
    imshow(output3(:,:,i)')
end
% Fill in your code here to plot the features.
