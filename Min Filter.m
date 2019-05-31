%read image
A = imread('xyz.png');
A = rgb2gray(A(1:300,1:300,:));
figure,imshow(A),title('ORIGINAL IMAGE');


%reallopcate the output image
B=zeros(size(A));

%pad the matrix with zeroes
modifyA=padarray(A,[1 1]);
x=[1:3];
y=[1:3];
for i= 1:size(modifyA,1)-2
    for j=1:size(modifyA,2)-2
    	window=reshape(modifyA(i+x-1,j+y-1),[],1);
		%Ffinding the minimum value
        B(i,j)=min(window);
   	end
end
%converting the output in 0-255 range
B=uint8(B);
figure,imshow(B),title('IMAGE AFTER MIN FILTERING');
