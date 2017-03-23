function[] = histogram_equalization()
    files = dir('*.bmp');
    for i = 1 : length(files)
        s = files(i).name;
        img = imread(s);
    	img = rgb2gray(img);
        img = histeq(img);
    	imwrite(img, [num2str(i),'-result.bmp']);
    end
end
