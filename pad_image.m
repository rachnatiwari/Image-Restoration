 
% Description: Helper function used to pad images with zeros until the required size is covered

function padded_img = pad_image(orig_img, req_size)
	M = req_size(1);
	N = req_size(2);
	
	[M_filt, N_filt] = size(orig_img);

	padded_img = zeros(M,N);
	padded_img(1:M_filt, 1:N_filt) = orig_img;

end