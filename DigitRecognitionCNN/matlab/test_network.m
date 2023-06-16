%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    %true_labels= output{1}.data(1:1000);
    [~,predicted_labels]=max(P);
    confusion_matrix = confusionmat(ytest(:,i:i+99), predicted_labels);
end