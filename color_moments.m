function y=color_moments(I)
    y=zeros(9,1);
    [m,n,d]=size(I);
    sum=n*m;
    
    I=rgb2hsv(I);
    h=I(:,:,1);
    s=I(:,:,2);
    v=I(:,:,3);
    %求一阶矩（均值）
    for i=1:sum
        y(1)=y(1)+h(i);
        y(2)=y(2)+s(i);
        y(3)=y(3)+v(i);
    end
    y(1)=y(1)/sum;
    y(2)=y(2)/sum;
    y(3)=y(3)/sum;
    %求二阶矩（方差）
    for i=1:sum
        y(4)=y(4)+(h(i)-y(1))^2;
        y(5)=y(5)+(s(i)-y(2))^2;
        y(6)=y(6)+(v(i)-y(3))^2;
    end
    y(4)=sqrt(y(4)/sum);
    y(5)=sqrt(y(5)/sum);
    y(6)=sqrt(y(6)/sum);
    %求三阶矩
    for i=1:sum
        y(7)=y(7)+(h(i)-y(1))^3;
        y(8)=y(8)+(s(i)-y(2))^3;
        y(9)=y(9)+(v(i)-y(3))^3;
    end
    y(7)=(y(7)/sum)^(1/3);
    y(8)=(y(8)/sum)^(1/3);
    y(9)=(y(9)/sum)^(1/3);
end