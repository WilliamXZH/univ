f = imread('test.jpg');
% size(f)
[M,N] = size(f);
whos f;
% imshow(f,[])
imfinfo test.jpg;
print -fl -dtiff -r300 hi_res_rose