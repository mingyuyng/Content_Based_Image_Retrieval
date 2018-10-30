
function edgeFeature = canny(imgPathName)

I = imread(imgPathName);  % ����ͼ��
I = rgb2gray(I);
I = imresize(I,[16,16]);
edgeFeature = edge(I,'canny');  % ����canny����

end
