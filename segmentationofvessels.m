clc
clear all
close all
aimg=imread('angiogram.jpg');
contrastinc=aimg*.5;
contrastdec=aimg*20;
subplot(5,5,1);imshow(aimg);title('original angiogram');
subplot(5,5,2);imshow(contrastinc);title('Increase in contrast');

subplot(5,5,3);imshow(contrastdec);title('decrease in contrast');


e1=edge(aimg,'roberts');
e2=edge(aimg,'sobel');
e3=edge(aimg,'prewitt');
e4=edge(aimg,'log');
e5=edge(aimg,'canny');

subplot(5,5,6);imshow(e1);title('roberts');
subplot(5,5,7);imshow(e2);title('sobel');
subplot(5,5,8);imshow(e3);title('prewitt');
subplot(5,5,9);imshow(e4);title('log');
subplot(5,5,10);imshow(e5);title('canny');


aimg_edge=edge(contrastinc,'canny');
subplot(5,5,11);imshow(aimg_edge);title('canny edge detection on angiogram');

%local feature extraction 

corners=detectFASTFeatures(contrastinc,'MinContrast',0.1);
localfeature=insertMarker(contrastinc,corners,'circle');
subplot(5,5,13);imshow(localfeature);

%take image result of local feature extraction -- (actually LFE + PFE result)


[m n]=size(localfeature);
t=95

for i=1:m
    for j= 1:n
        if localfeature(i,j)<t
            b(i,j)=0;
        else
            b(i,j)=255;
        end
    end
end
subplot(5,5,16);imshow(b);title('Thresholded image on local feature extraction');
xlabel(sprintf('threshold value is %g ',t))










largest_connected_component=bwconncomp(b);
numofpixels=cellfun(@numel,largest_connected_component.PixelIdxList);
[unused,indexOfMax]=max(numofpixels);
biggest=zeros(size(b));
biggest(largest_connected_component.pixelIdxList{indexOfMax})=1;
subplot(5,5,18);imshow(biggest);

