s = 'salt_pepper.bmp';
img = imread(s);
img = rgb2gray(img);
img = medfilt2(img);
imshow(img);
imwrite(img, 'salt_pepper_result.bmp', 'bmp');
