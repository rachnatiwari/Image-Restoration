 
% Disclaimer: None of the code has been copied or emulted from any outside source

function dft = myFFT2D(original_img)
	% Input:
	%       original_img    -> Original Input Image
	%
	% Output:
	%		 dft 		-> 2D DFT of the input image 
	%
	% Description:
	%		: Calculates the centralised 2D DFT of the input image
	%		: All the operations are performed on the variable "img_val"
	%       : For colored images the same algorithm is performed on the Value(V) plane in HSV

	tic

	if ndims(original_img) == 3			% Colored Images
		img_hsv = rgb2hsv(original_img);
		img_val = 255*img_hsv(:,:,3);
	else
		img_val = original_img;
	end
	
	[M,N] = size(img_val);

	% Padding to achieve resolution to the nearest power of 2	
	M_pow2 = pow2(nextpow2(M));
	N_pow2 = pow2(nextpow2(N));

	pad_img = zeros(M_pow2, N_pow2);
	pad_img(1:M, 1:N) = img_val;

	%% Calculating 2D-DFT
	dft = zeros(M_pow2, N_pow2);

	% Apply 1D FFT to every row
	for i=1:M_pow2
		dft(i, :) = myFFT1D(pad_img(i, :), N_pow2);
	end

	% Apply 1D FFT to every column
	for i=1:N_pow2
		dft(:, i) = myFFT1D(transpose(dft(:, i)), M_pow2);
	end

	%% Displaying the images
	% mag = abs(dft);
	% mag = linear_contrast(mag);
	% mag_im = fft_shift(mag);	

	% Displaying Images
	% figure
	% subplot(1,2,1);
	% imshow(original_img);
	% title('Original Image');
	% subplot(1,2,2)
	% imshow(mag_im);
	% title('Magnitude Plot');

	toc

end