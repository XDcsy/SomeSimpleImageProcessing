function[] = plate_number()
    imgName = 'number_plate.jpg';
    img = imread(imgName);
    img = rgb2gray(img);
    img = im2bw(img);
    [L, numberOfAreas] = bwlabel(img,4); %������ͨ������

    %��������ĳ���Ƚ����ų���
    %������Ƶ��ַ��������ճ������ѣ����޷�ʹ�ó�����ų���
    %��ʱ����ע�͵��·����룬ֻ�ú�һ������λ�õķ�����
    L2 = L;
    for i = 1 : numberOfAreas
        [x, y] = find(L==i);
        L2(L2==i) = (max(x) - min(x))/(max(y) - min(y)); %�ø�����ĳ�����滻��ţ�������L2
    end
    L(union(find(L2<1.3),find(L2>1.7))) = 0; %���������ֵ��Χ���������ȫ����Ϊ0

    %���������λ�ý����ų���
    areas = unique(L);  %��¼��ʱʣ��ĸ���������
    for i = 2 : length(areas) %����������ѭ����2��ʼ����Ϊareas(1)��Ӧ������ŵ�0
        [x, ~] = find(L==areas(i));
        if length(unique(L(min(x):max(x),:))) < 6 + 1  %��ÿ������������������������죬�޷����ǵ�6���������ϵ��ַ����������ϵĲ�ͬ���򡣣���1����Ϊ���ڷ�������ŵ�0����
            L(L==areas(i)) = 0;  %��ô���������ȫ����0
        end
    end
    L(L ~= 0) = 1;  %ʣ���������Ϊ1����Ϊ�ҵ����ַ�����

    figure();
    imshow(L);
    title('AreasFound');
    %�ַ��������ҵ���֮�������һЩ����
    %����һЩ��㲢��ǿ�ַ�
    se1 = strel('disk',1);
    se2 = strel('square',3);
    newL = imclose(L, se1);
    newL = imclose(newL, se2);
    newL = imopen(newL, se2);
    figure();
    imshow(newL);
    title('AfterProcessing');
    imwrite(newL,'result.bmp','bmp');

    %����ַ�ֻ����������������Ĵ���ȡ������Ĵ�����룬���Խ�������������
    %se1 = strel('disk',4);
    %tmp1 = imerode(imclose(L, se1),se1);
    %se2 = strel('disk',2);
    %holes = imerode(imfill(tmp1, 'holes') - tmp1,se2);
    %tmp2 = imfill(L, 'holes');
    %newL = tmp2 - holes;
    %imwrite(newL,'result.bmp','bmp')
    %figure();
    %imshow(newL);
    %title('AfterProcessing');
end
