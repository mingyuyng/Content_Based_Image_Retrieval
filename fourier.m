
img = imread('lena.jpg');%����ͼ��
subplot(2,2,1),imshow(img);%��ʾ
f=rgb2gray(img);%תΪ�Ҷ�ͼ
subplot(2,2,2),imshow(f)%��ʾ
F=fft2(f);%���ٸ���Ҷ�任
S1=log(1+abs(F));
subplot(2,2,3);imshow(S1,[])%��ʾ
FS=fftshift(F);%ת�Ƶ�����
S=log(1+abs(FS));
subplot(2,2,4);imshow(S,[])%��ʾ