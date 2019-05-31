

% Description:	This function attempts to restore the underlying ground truth image
% 				,given the degradation image and the estimated degrading kernel
% 				using various methods such as
% 				(1)	Inverse Filtering
% 				(2) Truncated Inverse Filtering
% 				(3) Wiener Filtering
% 				(4) Constrained Least Square Filtering

function reconstructed_img = restore_img_rgb(degraded_img, kernel, filter, arg)

	[M,N,P] = size(degraded_img);

	% Resize the kernel to match the size of the degraded image
	padded_kernel = pad_image(kernel, [M,N]);
	kernel_DFT = fftshift(fft2(padded_kernel)) + 0.001*ones([M,N]);
	kernel_DFT = repmat(kernel_DFT, [1,1,P]);

	% Degraded image DFT
	if P > 1
		% R Channel
		degraded_img_DFT(:,:,1) = fftshift(fft2(degraded_img(:,:,1)));

		% G Channel
		degraded_img_DFT(:,:,2) = fftshift(fft2(degraded_img(:,:,2)));

		% B Channel
		degraded_img_DFT(:,:,3) = fftshift(fft2(degraded_img(:,:,3)));
	else
		% Intensity
		degraded_img_DFT = fftshift(fft2(degraded_img));
	end

	% Apply inverse filtering method
	if strcmp(filter, 'inverse')
		reconstructed_img_DFT = degraded_img_DFT./kernel_DFT;

	% Pseudo-inverse filtering
	elseif strcmp(filter, 'pseudo inverse')
		reconstructed_img_DFT = ((abs(kernel_DFT)>arg).*degraded_img_DFT)./kernel_DFT;

	% Truncation Method
	elseif strcmp(filter, 'truncated inverse')
		reconstructed_img_DFT = degraded_img_DFT./kernel_DFT;		
		low_pass_filter = construct_LPF(arg, [M, N]);
		low_pass_filter = repmat(low_pass_filter, [1,1,P]);
		reconstructed_img_DFT = abs(reconstructed_img_DFT).*low_pass_filter.*exp(1i*angle(reconstructed_img_DFT));

	% Wiener Filtering
	elseif strcmp(filter, 'wiener')
		reconstructed_img_DFT = conj(kernel_DFT).*degraded_img_DFT./(abs(kernel_DFT).^2 + arg*ones(M,N,P));

	% Constrained Least Squares Method	
	elseif strcmp(filter, 'clsf')
		laplacian = [0 -1 0; -1 4 -1; 0 -1 0];
		padded_laplacian = pad_image(laplacian, [M, N]);
		laplacian_DFT = fftshift(fft2(padded_laplacian));
		laplacian_DFT = repmat(laplacian_DFT, [1,1,P]);
		reconstructed_img_DFT = conj(kernel_DFT).*degraded_img_DFT./(abs(kernel_DFT).^2 + arg*laplacian_DFT);	
	else 
		fprintf('Please enter the correct filter name!');
		return;
	end

	% Take inverse FFT
	if P > 1
		% R Channel
		reconstructed_img(:,:,1) = uint8(abs(ifft2(fftshift(reconstructed_img_DFT(:,:,1)))));

		% G Channel
		reconstructed_img(:,:,2) = uint8(abs(ifft2(fftshift(reconstructed_img_DFT(:,:,2)))));

		% B Channel
		reconstructed_img(:,:,3) = uint8(abs(ifft2(fftshift(reconstructed_img_DFT(:,:,3)))));
	else
		% Intensity
		reconstructed_img = uint8(abs(ifft2(fftshift(reconstructed_img_DFT))));
	end

	% Display imgs
	% figure(2)
	% subplot(1,3,1);
	% imshow(degraded_img);
	% title('Degraded Image');
	% subplot(1,3,2)
	% % imshow(log_transform(linear_contrast(abs(reconstructed_img_DFT))));
	% title('Reconstructed Image DFT');
	% subplot(1,3,3)
	% imshow(reconstructed_img);
	% title('Reconstructed Image')

end