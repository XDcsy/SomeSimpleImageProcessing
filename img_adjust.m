function[] = img_adjust()
    files = dir('*.bmp');
    for i = 1 : length(files)
        s = files(i).name;
        img = imread(s);
    	img = rgb2gray(img);
        high = max(img(:));
        low = min(img(:));
        low = double(low)/255;
        high = double(high)/255;
        img = imadjust(img,[low; high],[]);
    	imwrite(img, [num2str(i),'-result.bmp']);
    end
end
