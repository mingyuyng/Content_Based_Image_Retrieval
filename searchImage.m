global lbpPatches;
global colorPatches;
global testFileName;
global colorlashTable;
global lbplashTable;

load testImages.mat;
load testImages2.mat;
load testFileName.mat;

%addpath('./lshcode');
% load testImages2;
colorPatches = colorFeature';
lbpPatches = lbpFeature';

colorlashTable=lsh('e2lsh',4,8,size(colorPatches,1),colorPatches,'range',1);

lbplashTable=lsh('e2lsh',4,8,size(lbpPatches,1),lbpPatches,'range',1);

filep='./images/flower1.jpg';
searchFile(filep,lbpPatches,colorPatches,colorlashTable,lbplashTable,testFileName);