function[] = homomorphic_filtering()
    files = dir('*.jpg');
    for n = 1 : length(files)
        s = files(n).name;
        img = imread(s);
        img = double(rgb2gray(img));
        [x,y] = size(img);
        rL=0.5;
        rH=4.7;
        c=2;
        d0=10;
        img1=log(img+1);
        FI=fft2(img1);
        n1=floor(x/2);
        n2=floor(y/2);
        for i=1:x
            for j=1:y
                D(i,j)=((i-n1).^2+(j-n2).^2);
                H(i,j)=(rH-rL).*(exp(c*(-D(i,j)./(d0^2))))+rL;
            end
        end
        img2=ifft2(H.*FI);
        img3=real(exp(img2));
        %这里用imshow(img3,[]);可以显示结果。用imwrite输出的话，需要再做一些处理
        high = max(img3(:));
        low = min(img3(:));
        img3 = (img3-low)/(high-low);
        imwrite(img3, [num2str(i),'-result.jpg'], 'jpg');
    end
end
