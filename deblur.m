clear;
img = imread('blur.tif');
img = im2double(img);
%imshow(img);
len = 8; theta = 0;
PSF = fspecial('motion',len,theta);

%������֤�˶�ģ��ʵ�����Ǿ������
%n = 5;
%expandedImg = zeros(size(img,1),size(img,2)+n,size(img,3));
%�������˶�ģ���ķ�������չһ�»�����֮������˶�ģ��
%Ϊ����֤�ķ��㣬ֻ����ά�ȵ�ģ�������˴�ģ������ֻ����x�ᣬPSF��theta = 0��
%expandedImg(:,n+1:end,:) = img(:,:,:);
%expandedImg = imfilter(expandedImg,PSF,'conv');
%imshow(expandedImg);
%ʹ��matlab�ṩ�Ľ�������deconv��ͼ�����������еĽ�������
%���Ը�ԭ��������ͼ��
%for i = 1 : 3
%    for j = 1 : size(img,1)
%        img2(j,:,i) = deconv(expandedImg(j,:,i),PSF);
%    end
%end
%imshow(img2);

img2 = deconvwnr(img,PSF,0.02);
imshow(img2);
