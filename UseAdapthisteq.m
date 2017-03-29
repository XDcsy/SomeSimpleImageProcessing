function[] = UseAdapthisteq()
    files = dir('*.bmp');
    for i = 1 : length(files)
        s = files(i).name;
        img = imread(s);
    	img = rgb2gray(img);
        img = adapthisteq(img,'clipLimit',0.04);
    	imshow(img);
        imwrite(img, 'result.jpg', 'jpg')
    end
end
