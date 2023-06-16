M = load('someCorresp.mat','M');
pts1_struct = load('someCorresp.mat','pts1');
pts2_struct = load('someCorresp.mat','pts2');
I1 = imread('im1.png');
I2 = imread('im2.png');
value = getfield(M,'M');
pts1 = getfield(pts1_struct,'pts1');
pts2 = getfield(pts2_struct,'pts2');
F = eightpoint(pts1, pts2, value);
F
displayEpipolarF(I1, I2, F);