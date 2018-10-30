lbpFeatureDim = 59;
colorFeatureDim = 64;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%≤‚ ‘%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% images = dir('E:\BaiduYunDownload\pic_lab\*.*');
% path = 'E:\BaiduYunDownload\pic_lab\';
images = dir('/Users/yangmingyu/images/*.*');
path = '/Users/yangmingyu/images/';
%figure;imshow(canny('/Users/yangmingyu/images/Aquatics1.jpg'));
%figure;imshow(canny('/Users/yangmingyu/images/Aquatics2.jpg'));
[r,c] = size(images);

numTest = r-3;

lbpFeature = zeros(numTest,lbpFeatureDim);
colorFeature = zeros(numTest,colorFeatureDim);
% testContents = zeros(numTest,featureDim*featureDim*4);
testFileName = cell(numTest,1);
mapping=getmapping(8,'u2'); 
count = 1;
for i=4:r
    if (images(i).name == '.')
%         disp([path,images(i).name]);
    else
        disp([path,images(i).name]);
        I11=imread([path,images(i).name]);
        I1=imresize(I11,[128,128]);
        
        if ndims(I1) == 3
            RGB = I1;
            I = rgb2gray(I1);
            
        else
            RGB(:,:,1)=I1;
            RGB(:,:,2)=I1;
            RGB(:,:,3)=I1;
            I = I1;           
        end
        lbpFeature(count,:) = LBP(I,1,8,mapping,'nh');
        colorFeature(count,:) = ColorCorrelogram(RGB,6);
%         [testImages(count,:),testContents(count,:)] = getHaarFeature([path,images(i).name]);
        testFileName{count} = [path,images(i).name];
        count = count + 1;
%         disp(count);
    end
end

save('testImages.mat','lbpFeature');
save('testImages2.mat','colorFeature');
save('testFileName.mat','testFileName');