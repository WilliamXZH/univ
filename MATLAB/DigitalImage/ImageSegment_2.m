clear I=imread('test.jpg');    %读入图像
q=imadjust(I,[.2 .3 0;.6 .7 1],[]); %增强图像的对比度
j=rgb2gray(q);    %彩色图像变灰度图像
j1=im2bw(q,230/255);%二值化
se90=strel('line',3,90);    %构造元素
se0=strel('line',3,0);    %同上
BW2=imdilate(j1,[se90 se0]);   % 用构造的元素膨胀
 BW3=bwareaopen(BW2,100);%开操作
BW3=~BW3;%取反
 BW4=bwareaopen(BW3,20);%开
BW5=bwperim(BW4);%计算BW4周长
[imx,imy]=size(BW5);计算长宽
 L=bwlabel(BW5,8);%用不同的数字根据是否连通标记图像，
a=max(max(L));%得到L图像中标记结果的最大值
 BW6=bwfill(BW5,'hole');%填充背景
 I2=I;          
 for i=1:3; I2(:,:,i)=I2(:,:,i).*uint8(BW6);
end imshow(I2); 