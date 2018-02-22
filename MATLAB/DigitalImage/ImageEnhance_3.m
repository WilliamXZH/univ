%利用中值滤波去噪
clear all;
I=imread('test.jpg');
M=rgb2gray(I);
N1=imnoise(M,'salt & pepper',0.04);
N2=imnoise(M,'gaussian',0,0.02);
N3=imnoise(M,'speckle',0.02);   %添加乘性噪声
G1=medfilt2(N1);      %中值滤波去噪
G2=medfilt2(N2);
G3=medfilt2(N3);
subplot(2,3,1);
imshow(N1);
title('添加椒盐噪声图像');
subplot(2,3,2);
imshow(N2);
title('添加高斯噪声');
subplot(2,3,3);
imshow(N3);
title('添加乘性噪声');
subplot(2,3,4);
imshow(G1);
title('椒盐噪声中值滤波图像');
subplot(2,3,5);
imshow(G2);
title('高斯噪声中值滤波图像');
subplot(2,3,6);
imshow(G3);
title('乘性噪声中值滤波图像');
