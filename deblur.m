clear;
img = imread('blur.tif');
img = im2double(img);
%imshow(img);
len = 8; theta = 0;
PSF = fspecial('motion',len,theta);

%可以验证运动模糊实际上是卷积运算
%n = 5;
%expandedImg = zeros(size(img,1),size(img,2)+n,size(img,3));
%首先向运动模糊的反方向扩展一下画布，之后进行运动模糊
%为了验证的方便，只做单维度的模糊（即此处模糊方向只沿着x轴，PSF的theta = 0）
%expandedImg(:,n+1:end,:) = img(:,:,:);
%expandedImg = imfilter(expandedImg,PSF,'conv');
%imshow(expandedImg);
%使用matlab提供的解卷积函数deconv对图像矩阵进行逐行的解卷积运算
%可以复原出清晰的图像
%for i = 1 : 3
%    for j = 1 : size(img,1)
%        img2(j,:,i) = deconv(expandedImg(j,:,i),PSF);
%    end
%end
%imshow(img2);

img2 = deconvwnr(img,PSF,0.02);
imshow(img2);
