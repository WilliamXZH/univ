clear I=imread('test.jpg');    %����ͼ��
q=imadjust(I,[.2 .3 0;.6 .7 1],[]); %��ǿͼ��ĶԱȶ�
j=rgb2gray(q);    %��ɫͼ���Ҷ�ͼ��
j1=im2bw(q,230/255);%��ֵ��
se90=strel('line',3,90);    %����Ԫ��
se0=strel('line',3,0);    %ͬ��
BW2=imdilate(j1,[se90 se0]);   % �ù����Ԫ������
 BW3=bwareaopen(BW2,100);%������
BW3=~BW3;%ȡ��
 BW4=bwareaopen(BW3,20);%��
BW5=bwperim(BW4);%����BW4�ܳ�
[imx,imy]=size(BW5);���㳤��
 L=bwlabel(BW5,8);%�ò�ͬ�����ָ����Ƿ���ͨ���ͼ��
a=max(max(L));%�õ�Lͼ���б�ǽ�������ֵ
 BW6=bwfill(BW5,'hole');%��䱳��
 I2=I;          
 for i=1:3; I2(:,:,i)=I2(:,:,i).*uint8(BW6);
end imshow(I2); 