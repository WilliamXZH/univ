%������ֵ�˲�ȥ��
clear all;
I=imread('test.jpg');
M=rgb2gray(I);
N1=imnoise(M,'salt & pepper',0.04);
N2=imnoise(M,'gaussian',0,0.02);
N3=imnoise(M,'speckle',0.02);   %��ӳ�������
G1=medfilt2(N1);      %��ֵ�˲�ȥ��
G2=medfilt2(N2);
G3=medfilt2(N3);
subplot(2,3,1);
imshow(N1);
title('��ӽ�������ͼ��');
subplot(2,3,2);
imshow(N2);
title('��Ӹ�˹����');
subplot(2,3,3);
imshow(N3);
title('��ӳ�������');
subplot(2,3,4);
imshow(G1);
title('����������ֵ�˲�ͼ��');
subplot(2,3,5);
imshow(G2);
title('��˹������ֵ�˲�ͼ��');
subplot(2,3,6);
imshow(G3);
title('����������ֵ�˲�ͼ��');
