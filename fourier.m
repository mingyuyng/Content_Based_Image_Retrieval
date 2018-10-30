
img = imread('lena.jpg');%读入图像
subplot(2,2,1),imshow(img);%显示
f=rgb2gray(img);%转为灰度图
subplot(2,2,2),imshow(f)%显示
F=fft2(f);%快速傅里叶变换
S1=log(1+abs(F));
subplot(2,2,3);imshow(S1,[])%显示
FS=fftshift(F);%转移到中心
S=log(1+abs(FS));
subplot(2,2,4);imshow(S,[])%显示