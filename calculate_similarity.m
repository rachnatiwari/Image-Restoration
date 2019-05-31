
% Description:	This function calculates the similarity metrics for a given pair of images

function [] = calculate_similarity(img1, img2, name)
	ans = input(strcat(['Do u wanna calculate similarity metrics for', name, ' ?y/n ']), 's');
	if ans == 'y' || ans == 'Y'
		disp('Calculating.................');
        [m,n] = size(img1);
        object1 = zeros(m,n);
        object2 = zeros(m,n);
        object1 = uint8(object1);
        object2 = uint8(object2);
        for j= 1:m
            for k = 1:n
                object1(j,k) = img1(j,k);
                object2(j,k) = img2(j,k);
            end
        end
		m = immse(object1, object2);                 % MSE
		p = psnr(object1, object2);                  % PSNR
		s = ssim(object1, object2);                  % SSIM

		disp(['RMS error per pixel = ', num2str(m)]);
		disp(['Calculated PSNR = ', num2str(p) ' dB']);
		disp(['Calculated SSIM = ', num2str(s)]);
	end
end