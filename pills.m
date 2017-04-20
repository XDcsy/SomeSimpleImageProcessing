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
rect = minboundrect(c,r,'a');