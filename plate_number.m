function[] = plate_number()
    imgName = 'number_plate.jpg';
    img = imread(imgName);
    img = rgb2gray(img);
    img = im2bw(img);
    [L, numberOfAreas] = bwlabel(img,4); %将各连通区域标号

    %根据区域的长宽比进行排除。
    %如果车牌的字符区域存在粘连或断裂，将无法使用长宽比排除。
    %此时可以注释掉下方代码，只用后一种依据位置的方法。
    L2 = L;
    for i = 1 : numberOfAreas
        [x, y] = find(L==i);
        L2(L2==i) = (max(x) - min(x))/(max(y) - min(y)); %用各区域的长宽比替换标号，储存于L2
    end
    L(union(find(L2<1.3),find(L2>1.7))) = 0; %长宽比在阈值范围以外的区域，全部置为0

    %根据区域的位置进行排除。
    areas = unique(L);  %记录此时剩余的各区域的序号
    for i = 2 : length(areas) %检查各个区域，循环从2开始，因为areas(1)对应不是序号的0
        [x, ~] = find(L==areas(i));
        if length(unique(L(min(x):max(x),:))) < 6 + 1  %对每个区域，如果它向左右两边延伸，无法覆盖到6个（车牌上的字符数）或以上的不同区域。（加1是因为存在非区域序号的0。）
            L(L==areas(i)) = 0;  %那么将这个区域全部置0
        end
    end
    L(L ~= 0) = 1;  %剩余的区域置为1，即为找到的字符区域
    
    figure();
    imshow(L);
    title('AreasFound');
    %字符区域已找到，之后可以做一些处理。
    se1 = strel('disk',1);
    se2 = strel('square',3);
    L2 = imclose(L, se1);
    L2 = imclose(L2, se2);
    L2 = imopen(L2, se2);
    figure();
    imshow(L2);
    title('AfterProcessing');
end
