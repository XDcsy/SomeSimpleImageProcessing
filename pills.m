img = imread('1.tiff');
bw = rgb2gray(img);
gray = bw;
bw(bw < 40) = 0;
bw(bw ~=0) = 255;
bw = im2bw(bw);
bw = imfill(bw, 'holes');
se=strel('disk',5);
bw = imopen(bw, se);
gray = uint8(bw).*gray;
%result 1
e = edge(bw,'canny');
theta = 1:180;
[R,xp] = radon(e,theta);
[I,J] = find(R>=max(max(R)));%J记录了倾斜角，最大的倾斜角
angle=90-J;
bw = imrotate(bw,angle,'bicubic','crop');