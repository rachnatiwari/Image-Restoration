%% Assignment # 3 & 4
% DIP @ c@se Fall 2006
% Alpha Trimmed Filter
%% Program Initializations
clc
close all
clear all
%% Reading an Image and making basic maniulations
%data=imread('cameraman.tif');
data=imread('pears.png');
figure,imshow(data);
data=rgb2gray(data);
data=im2double(data);
% Filter takes double the size of mask
masksize=2;
% Specifications of the filter
d=4;
figure,imshow(data)
[ro col]=size(data);
temp1=[];
graber=0;
akkumulator=[];
%% Main Module for Alpha Trimmed Mean Filter
for i=1:ro;
    for j=1:col;
        for m=-masksize:masksize;
            for n=-masksize:masksize;
                if (i+m>0 && i+m<ro && j+n>0 && j+n<col && ...      % To keep indices in limit
                        masksize+m>0 && masksize+m<ro && ...
                        masksize+n>0 && masksize+n<col) 
                    
                    temp1=[temp1 data(i+m,j+n)];
                                    
                end
            end
        end
         
        temp1=sort(temp1);
        lenth=length(temp1);
        for k=((d/2)-1):(lenth-(d/2))
            akkumulator=[akkumulator temp1(k)];
        end
        akkumulator=sum(akkumulator);
        reformedimage(i,j)=(akkumulator) / (25-d);
        
        akkumulator=[];
        temp1=[];
        
    end
end
figure,imshow(reformedimage)