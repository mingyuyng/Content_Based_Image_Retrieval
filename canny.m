
function edgeFeature = canny(imgPathName)

I = imread(imgPathName);  % 读入图像
I = rgb2gray(I);
I = imresize(I,[16,16]);
edgeFeature = edge(I,'canny');  % 调用canny函数

end
