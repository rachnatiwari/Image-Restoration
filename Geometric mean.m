%loading of image
img = imread('xyz.png');
%string size of images
[row column channel] = size(img);
%building of new image
im = img;
for i = 2:row-1	%sweeping through rows
    for j= 2:column-1	%swiping through coloumn
    	for k = 1:channel	%sweeping through channel
        	a = 0;
        	%convolution
        	for u = -1:1
         		for v = -1:1
           			a = a * img(i+u , j+v);
         		end
        	end
        	%assigning values
        	im(i,j,k) = a^(1/numel(m*n));
      	end
    end
end
