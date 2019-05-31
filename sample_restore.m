
% Description:	Supportig script used as a subordinate to the main script

img = input('Enter the image number in the range 1 to 4 : ');

orig_img_path = sprintf('images/GroundTruth%d.jpg', img);
degraded_path = sprintf('images/Blurry%d_%d.jpg', img, img);
kernel_path = sprintf('images/Kernel%d_%d.jpg', img, img);

% Read the images and kernel
original_img = imread(orig_img_path);
degraded_img = imread(degraded_path);
kernel = imread(kernel_path);

% Normalising the kernel
kernel = double(kernel)/sum(sum(kernel));

% Display the ground truth and degraded images
figure(1),clf
subplot(131),imshow(original_img),title('GroundTruth Image')
subplot(132),imshow(degraded_img),title('Degraded Image')

% Calculating the evaluation metrics
calculate_similarity(degraded_img, original_img, ' degraded image');

% Initiate an interactive cmd-interface
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
	ans = input('Response = ');

	switch ans
		case 1
			restored = restore_img_rgb(degraded_img, kernel, 'inverse');
			
			str1 = 'Inverse Filtering';
			str2 = ' Inverse Filtered Image';

		case 2
			radius = input('Enter the radius : ');
			restored = restore_img_rgb(degraded_img, kernel, 'truncated inverse', radius);
			
			str1 = strcat('Truncated Inverse Filtering, radius = ', num2str(radius));
			str2 = ' truncated image';

		case 3
			K = input('Enter K (the parameter, default=0.01) : ');
			if isempty(K) K=0.01; end
			restored = restore_img_rgb(degraded_img, kernel, 'wiener', K);
			
			str1 = strcat('Wiener Filtering, K = ', num2str(K));
			str2 = ' wiener filtered image';

		case 4	
			alpha = input('Enter alpha (the parameter, default=0.01) : ');				
			restored = restore_img_rgb(degraded_img, kernel, 'clsf', alpha);

			str1 = strcat('CLS Filtering, alpha = ', num2str(alpha));
			str2 = ' CLS filtered image';

		otherwise
			fprintf('Invalid entry\n Exiting........' );
			break;
	end

	figure(1),
	subplot(133),imshow(restored),title(str1)

	% Calculate similarity metric
	calculate_similarity(restored, original_img, str2);
	
	ans = input('Do wanna save the image? y/n', 's');
	if ans == 'y' || ans == 'Y'
		img_path = input('Please enter the image path!! ', 's');
		imwrite(restored, img_path);
	end
end

disp('The program ends here!!!');
disp('Press any key to continue...........');
pause
