function  output = ColorCorrelogram(rgb,d)
R = rgb(:,:,1);
G = rgb(:,:,2);
B = rgb(:,:,3);
R_BITS = 2;%bit量化
G_BITS = 2;
B_BITS = 2;
size_color = 2^R_BITS*2^G_BITS*2^B_BITS;%归一化后的颜色种数
R1=bitshift(R,-(8-R_BITS));
G1=bitshift(G,-(8-G_BITS));
B1=bitshift(B,-(8-B_BITS));
%包含的颜色种数为：4x4x4
I=R1+G1*2^R_BITS+B1*2^R_BITS*2^B_BITS;%新生图像
temp = zeros(size_color,1);
os = offset(d);
s = size(os);
for i = 1:s(1)
    offset = os(i,:);
    glm = GLCMATRIX(I,offset,size_color);
    temp = temp+glm;
end
hc = zeros(size_color,1);
for j = 0:size_color-1
    hc(j+1) = numel(I(I == j));%Index为j的计数
end
output = temp./(hc+eps);
output = output/(8*d);
end


function os = offset(d)
[r,c] = meshgrid(-d:d,-d:d);
r = r(:);
c = c(:);
os = [r c];
bad = max(abs(r),abs(c)) ~= d;
os(bad,:) = [];
end


function out = GLCMATRIX(si,offset,nl)
s = size(si);%图像大小
[r,c] = meshgrid(1:s(1),1:s(2));%网格化，很明显
r = r(:);%向量化
c = c(:);%向量化
r2 = r+offset(1);%加偏置
c2 = c+offset(2);%加偏置
bad = c2<1|c2>s(2)|r2<1|r2>s(1);%筛选出index不在图像内的点
Index = [r c r2 c2];%原始距离与相对距离的矩阵
Index(bad,:) = [];%剔除坏点
v1 = si(sub2ind(s,Index(:,1),Index(:,2)));%从索引到数据
v2 = si(sub2ind(s,Index(:,3),Index(:,4)));
v1 = v1(:);
v2 = v2(:);
Ind  = [v1 v2 ];
bad = v1~=v2;%这里计算的是颜色自相关图
Ind(bad,:) = [];
if isempty(Ind)
    oneGLCM2 = zeros(nl);
else
    oneGLCM2 = accumarray(Ind+1,1,[nl,nl]);
end
out = [];
for i = 1:nl
    out = [out oneGLCM2(i,i)];
end
out = out(:);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%