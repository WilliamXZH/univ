Img=imread('test.jpg');  
imgsize=size(Img);
subimg_width=round(imgsize(1)/2);
subimg_height=round(imgsize(2)/2);
num_width_spilt=ceil(imgsize(1)/subimg_width);  
num_height_spilt=ceil(imgsize(2)/subimg_height);  
num=num_width_spilt*num_height_spilt;  
for i=1:num_width_spilt  
   for j=1:num_height_spilt  
   if(i*subimg_width<=imgsize(1))  
       width=subimg_width;  
   else  
       width=imgsize(1)-(i-1)*subimg_width;  
   end  
   if(j*subimg_height<=imgsize(2))  
       height=subimg_height;  
   else  
       height=imgsize(2)-(j-1)*subimg_height;  
   end  
    subimg=zeros(width,height);  
    for ii=1:width  
    for jj=1:height  
    for kk=1:3  
   subimg(ii,jj,kk)=Img((i-1)*subimg_width+ii,(j-1)*subimg_height+jj,kk);  
    end  
    end  
    end  
  subimg=uint8(subimg);  
    eval(['imwrite(subimg, ''subimg' num2str((i-1)*num_width_spilt+j) '.bmp'',''bmp'');']);  
   end  
end  