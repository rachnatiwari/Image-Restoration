

function enhanced_img = linear_contrast(orig_img)
	% Enhances the image by increasing the conrast linearly
	% Handles only b/w images

	min_im = min(min(orig_img));
	max_im = max(max(orig_img));
	enhanced_img = uint8(255*(orig_img-min_im)/(max_im-min_im));

end