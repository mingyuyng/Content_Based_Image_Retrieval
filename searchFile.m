function [feature]=searchFile(filename,lbpPatches,colorPatches,colorlashTable,lbplashTable,testFileName)
    
    addpath('./lshcode');
    feature = 0;
    I11=imread(filename);
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
    mapping=getmapping(8,'u2'); 
    lbp11 = lbp(I,1,8,mapping,'nh');
    lbp1 = lbp11';
    color1 = ColorCorrelogram(RGB,6); 
       
    [lbp_nnlsh,numcand]=lshlookup(lbp1,lbpPatches,lbplashTable,'k',100,'distfun','lpnorm','distargs',{2});
    [color_nnlsh,numcand]=lshlookup(color1,colorPatches,colorlashTable,'k',100,'distfun','lpnorm','distargs',{2});
    
    nnlsh = union(lbp_nnlsh, color_nnlsh);
    tic;
    d_lbp=sum(abs(bsxfun(@minus,lbp1,lbpPatches(:,nnlsh))));
    d_color=sum(abs(bsxfun(@minus,color1,colorPatches(:,nnlsh))));
%     d = d_lbp/self_diff + d_color;
    d = d_lbp + d_color;
    [ignore,ind]=sort(d);
    toc;
    
    posx = 0;
    posy = 0;
    for i=1:20        
        if mod(i,5)==1
            posx = 0;
            poxy = 1-ceil(i/5)*0.25;
        end
        subplot('position',[posx,poxy,.2,.24]);
        posx = posx + 0.2;
        imshow(imresize(imread(char(testFileName(nnlsh(ind(i)),:))),[512,512]));
    end
    
end



