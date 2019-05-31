% Author: Sarthak Nijhawan
% 
% Disclaimer: None of the code has been copied or emulted from any outside source
% 
% Description:  Supporting script used as a subordinate to the main script

while 1

	img_path = input('Please input the image path : ', 's');
	degraded_img = imread(img_path);

	disp('Follow these steps : ');
	disp('(1) Select any noisy patch with good signal-to-noise ratio (not more than 30x30)');
	disp('(2) Export the patch to the variable "noisy_patch" ');

	imtool(degraded_img)
	disp('Press any key to continue........');
	pause

	% reconstructing the patch
	reconstructed_patch = imsharpen(noisy_patch);

	% Saving noisy patch
	ans = input('Do wanna save the noisy patch? y/n', 's');
	if ans == 'y' || ans == 'Y'
		img_path = input('Please enter the image path!! ', 's');
		imwrite(noisy_patch, img_path);
	end

	% Saving reconstructed patch
	ans = input('Do wanna save the reconstructed patch? y/n', 's');
	if ans == 'y' || ans == 'Y'
		img_path = input('Please enter the image path!! ', 's');
		imwrite(reconstructed_patch, img_path);
	end

	G = fft2(noisy_patch);
	F = fft2(reconstructed_patch);
	F = F+0.0001;

	% Estimation by observation
	H = (abs(F)>0.01).*G./F;

	% kernel in spatial domain
	kernel = real(ifft2(H));

	[M,N,P] = size(degraded_img)

	% For colored images
	if P>1
		kernel = mean(kernel, 3)				% Taking average over each channel
	end

	% Display the ground truth and degraded images
	figure(1),clf
	subplot(121),imshow(degraded_img),title('Degraded Image')

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
				restored = restore_img_rgb(degraded_img, kernel, 'inverse');
				
				str1 = 'Inverse Filtering';
				str2 = ' inverse filtered image';

			case 2
				ans = input('Do you wish to calculate the optimum value? y/n ', 's');
				radius = input('Enter the radius : ');
				restored = restore_img_rgb(degraded_img, kernel, 'truncated inverse', radius);
				
				str1 = strcat('Truncated Inv-Filtering, radius=', num2str(radius));
				str2 = ' truncated image';

			case 3
				K = input('Enter K (the parameter, default=0.01) : ');
				if isempty(K) K=0.01; end
				restored = restore_img_rgb(degraded_img, kernel, 'wiener', K);
				
				str1 = strcat('Wiener Filtering, K = ', num2str(K));
				str2 = ' wiener filtered image';

			case 4	
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
		subplot(122),imshow(restored),title(str1)
		
		ans = input('Do wanna save the image? y/n', 's');
		if ans == 'y' || ans == 'Y'
			img_path = input('Please enter the image path!! ', 's');
			imwrite(restored, img_path);
		end

	end

end