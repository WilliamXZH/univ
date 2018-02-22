% g = imread('test.jpg');
% figure;
% imshow(g);
% figure;
% f = 255-g;
% imshow(f);
% figure;
% a = 50;
% b = 150;
% c = 100;
% d = 200;
% if(f>b)g = d;
% elseif(f<a)g = c;
% else g = (d-c)/(b-a)*(f-a)+c;
% end;
% imshow(g);
% % imshow(f);
A = [0 -1 0
    -1 4 -1
    0 -1 0
    ]
B = [
    -1 -1 -1
    -1 8 -1
    -1 -1 -1
    ]
A*B
