 


function [enhanced_img] = log_transform(original_img)
	% Input Parameters:
	%		original_img 	-> 	Original Input Image
	% 
	% Description:
	%		: all the operations are performed on the variable "img_intensity"
	%		: Returns the logarithmic transformation of an image

	if ndims(original_img) == 3								% Colored Images
		img_hsv = rgb2hsv(original_img);
		img_intensity = 255.0*img_hsv(:,:,3);			% To ensure range of value is in mapped to [0,255]
	else
		img_intensity = original_img;						% Grayscale Images
	end

	enhanced_img = log10(double(img_intensity)+1.0);
	enhanced_img = enhanced_img*255.0/log10(256.0);		% Normalisation	so that the range is [0,255]
	
	if ndims(original_img) == 3								% Colored Images
		img_hsv(:,:,3) = enhanced_img/255.0;			% range for V in HSV must be in [0,1]
		enhanced_img = uint8(255*hsv2rgb(img_hsv));
	else 												% Grayscale Images
		enhanced_img = uint8(enhanced_img);				% Casting the image back for b/w images
	end

	% Displaying Images	
	% subplot(1,2,1)
	% imshow(original_img);
	% title('Original Image');
	% subplot(1,2,2)
	% imshow(enhanced_img);
	% title('Enhanced image');

end