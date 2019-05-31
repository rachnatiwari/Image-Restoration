
% Description:  Supportig script used as a subordinate to the main script

while 1

	% Asking for image path
	img_path = input('Please input the image path : ', 's');
	original_img = im2double(imread(img_path));

	disp('Select how you want to blur the image : ');
	disp('(1) Disk blur');
	disp('(2) Motion blur');
	disp('(3) Exit');
	ans = input('Response = ');

	% Input parameters
	switch ans
		case 1
			radius = input('Enter the radius : ');
			kernel = fspecial('disk', radius);
		case 2
			radius = input('Enter the radius : ');
			angle = input('Enter the angle of blur : ');
			kernel = fspecial('motion', radius, angle);
		otherwise
			disp('Please enter a valid integer');
			disp('Exiting........');
			break;	
	end

	[M,N,P] = size(original_img);

	% Read image and convert to double for fft
	kernel_DFT = fft2(kernel, size(original_img, 1), size(original_img, 2));
	kernel_DFT = repmat(kernel_DFT, [1,1,P]);
	img_blur = abs(ifft2(kernel_DFT.*fft2(original_img)));

	% Input for other parameters
	sigma_u = input('Enter sigma for noise (default = 0.01) : ');
	if isempty(sigma_u) sigma_u=0.01; end
	degraded_img = uint8(255*(img_blur + sigma_u*randn(size(img_blur))));

	% Display the ground truth and degraded images
	figure(1),clf
	subplot(131),imshow(original_img),title('GroundTruth Image')
	subplot(132),imshow(degraded_img),title('Degraded Image')

	% Saving degraded image
	ans = input('Do wanna save the degraded image? y/n', 's');
	if ans == 'y' || ans == 'Y'
		img_path = input('Please enter the image path!! ', 's');
		imwrite(degraded_img, img_path);
	end

	% Calculating the evaluation metrics
	calculate_similarity(degraded_img, original_img, ' degraded image');

	disp('Next, choose any filter you wanna apply');
	disp('press any key to continue ...')
	pause

	while 1
		fprintf('\n\n');
		disp('Please enter any one of the filter numbers : ')
		disp('(1) Inverse Filtering');
		disp('(2) Truncated Inverse Filtering');
		disp('(3) Wiener Filtering');
		disp('(4) Constrained Least Square Filtering');
		disp('(5) Try new image!!');
		ans = input('Response = ');

		switch ans
			case 1
				% Inverse filtering
				restored = restore_img_rgb(degraded_img, kernel, 'inverse');
				
				str1 = 'Inverse Filtering';
				str2 = ' inverse filtered image';

			case 2
				% Truncated inverse filtering
				ans = input('Do you wish to calculate the optimum value? y/n ', 's');
				radius = input('Enter the radius : ');
				restored = restore_img_rgb(degraded_img, kernel, 'truncated inverse', radius);
				
				str1 = strcat('Truncated Inv-Filtering, radius=', num2str(radius));
				str2 = ' truncated image';

			case 3
				% Wiener Filtering
				K = input('Enter K (the parameter, default=0.01) : ');
				if isempty(K) K=0.01; end
				restored = restore_img_rgb(degraded_img, kernel, 'wiener', K);
				
				str1 = strcat('Wiener Filtering, K = ', num2str(K));
				str2 = ' wiener filtered image';

			case 4
				% CLS Filtering
				alpha = input('Enter alpha (the parameter, default=0.01) : ');
				if isempty(alpha) alpha=0.01; end					
				restored = restore_img_rgb(degraded_img, kernel, 'clsf', alpha);

				str1 = strcat('CLS Filtering, alpha = ', num2str(alpha));
				str2 = ' CLS filtered image';

			otherwise
				fprintf('Invalid entry\n Exiting........\n' );
				break;
		end

		figure(1),
		subplot(133),imshow(restored),title(str1)

		% Calculate similarity
		calculate_similarity(restored, original_img, str2);
		
		ans = input('Do wanna save the image? y/n', 's');
		if ans == 'y' || ans == 'Y'
			img_path = input('Please enter the image path!! ', 's');
			imwrite(restored, img_path);
		end

	end

end