%loading image
I=imread('xyz.tif');
I=rgb2gray(I);
%applying noise
density=0.1;  
h=imnoise(I,'salt & pepper',density);
imshow(h);
%storing size of image
[M,N]=size(h);
new = I
%kernel size
kernel_size=3;
k=zeros(kernel_size);  %k is the kernel used. 

%applying the median filter to the image:

start=kernel_size-floor(kernel_size*0.5);
for x=start:1:M-floor(kernel_size*0.5)
	for y=start:1:N-floor(kernel_size*0.5)
		%defining x1 & y1 as the 1st coordinates in the kernel
		x1=x-(floor(kernel_size*0.5));
		y1=y-(floor(kernel_size*0.5));
		%specifying image pixels to the kernel
		for p=1:1:kernel_size
			for q=1:1:kernel_size
 				k(p,q)=h(x1+p-1,y1+q-1);
			end    
		end
		d=reshape(k,1,[]);  %k values into an array d 
		[r,c]=size(d);
		%Ordering kernel members*
		for j=1:1:c-1
			for i=1:1:c-1
    			a=d(1,i);
    			b=d(1,i+1);
    			if(a>b)
    			 d(1,i)=b;
    			 d(1,i+1)=a;
    			end
			end  
		end
		Median = d(1,floor(kernel_size*kernel_size*0.5)+1);
		new(x,y)=Median;    
	end
end

%displaying the result:
imshow(new);