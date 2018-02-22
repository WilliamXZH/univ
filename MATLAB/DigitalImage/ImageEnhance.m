% A = imread('test.jpg');
% figure(1);
% imshow(A);
% B=A+50;
% figure(2);
% imshow(B);
% C=1.5*A;
% figure(30);
% imshow(C);
% D=0.8*A;
% figure(4);
% imshow(D);
% E = -double(A)+255;
% figure(5);
% imshow(uint8(E));

% I =imread('test2.jpg');
% A = I+50;
% B = 1.5*I;
% C = 0.8*I;
% D = (255-1*I);
% subplot(1,5,1),imshow(I);
% subplot(1,5,2),imshow(A);
% subplot(1,5,3),imshow(B);
% subplot(1,5,4),imshow(C);
% subplot(1,5,5),imshow(D);

% RGB = imread('test2.jpg');
% RGB2 = imadd(RGB,50);
% subplot(1,2,1),imshow(uint8(RGB));
% subplot(1,2,2),imshow(RGB2);

%直方图
% I = imread('test2.jpg');
% figure;
% imshow(I);
% title('Souce');
% figure;
% imhist(I);
% title('Graph');
% figure;
% imhist(I,64);

%图像加法
I = imread('bg.jpg');
J = imread('test.jpg');
 figure;
% imshow(I);
% figure;
 imshow(J);
K = imadd(J,J);
 figure;
imshow(K);
C = imsubtract(J,J);
figure;
imshow(C);
% subplot(2,2,1);imshow(I);
% subplot(2,2,2);imshow(J);
% subplot(2,2,3);imshow(K);