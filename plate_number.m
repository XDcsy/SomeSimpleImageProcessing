function[] = plate_number()
    numberAsAGroup = 6;  %一个测试group包含的区域数，不大于车牌上的字符总数。越大越精确，但无法找到结果时可调小此数或调大阈值。
    imgName = 'number_plate.jpg';
    img = imread(imgName);
    img = rgb2gray(img);
    img = im2bw(img);
    [L, numberOfAreas] = bwlabel(img,4);
    for i = 1 : numberOfAreas
        [x, y] = find(L==i);
        block(i, 1:4) = [max(x) - min(x), max(x), i, max(y) - min(y)]; %block中保存图像中所有连通区域的外接矩形的长、宽、最大纵坐标和序号
    end
    block = sortrows(block, 1);
    k = 1;
    for i = 1 : numberOfAreas - numberAsAGroup + 1 
        CVlength = block(i : i + numberAsAGroup - 1, 1); %numberAsAGroup个连通区域作为一组
        CVy = block(i : i + numberAsAGroup - 1, 2);
        if std(CVlength)/mean(CVlength) < 0.15 && std(CVy)/mean(CVy) < 0.15 && min(block(i : i + numberAsAGroup - 1, 4))*4 > max(block(i : i + numberAsAGroup - 1, 4)) %如果一组区域中的长度和最大纵坐标的变异系数小于阈值，并且最小的横向宽度不小于最大横向宽度的四分之一
            numberBlock(k, 1:numberAsAGroup) = (block(i : i + numberAsAGroup - 1, 3))'; %认为找到字符区域，记录序号
			k = k + 1;
        end
    end
    for i = 1 : numel(numberBlock)
        L(find(L == numberBlock(i))) = -1; %字符区域暂时置为-1
    end
L(find(L~=-1)) = 0; %字符区域以外置为全黑
L(find(L==-1)) = 1; %字符区域置白色
figure();
imshow(L);
title('NumberAreasFound');
%字符区域已找到，之后可以进一步做一些处理。
se1 = strel('disk',1);
se2 = strel('square',3);
L2 = imclose(L, se1);
L2 = imclose(L2, se2);
L2 = imopen(L2, se2);
figure();
imshow(L2);
title('AfterProcessing');
end
