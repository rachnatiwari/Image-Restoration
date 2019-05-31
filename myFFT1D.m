% Author: Sarthak Nijhawan
% 
% Disclaimer: None of the code has been copied or emulted from any outside source

function fft_seq = myFFT1D(input_sequence, n_points)
	% Returns the 1D-DFT of an input sequence
	% Does by FFT-algorithm (Radix-2 DIT)

	% Finding the nearest power of 2
	near_pow2 = pow2(nextpow2(n_points));
	pad_points = near_pow2-n_points;

	% Zero padding the input_sequence to achieve the nearest power of 2 in length of the sequence
	if pad_points > 0
		pad_array = zeros(1, pad_points);
		pad_input = double([input_sequence, pad_array]);
	else
		pad_input = input_sequence;
	end
	
	% Calculating the 1D-DFT using FFT 
	fft_seq = myFFT1D_helper(pad_input, near_pow2);

	% Naive DFT-1D
	% fft_seq = ones(1,n_points);
	% for k=0:n_points-1
	% 	n = 0:n_points-1;
	% 	w = exp(-1i*2*pi*n*k/n_points);
	% 	fft_seq(k+1) = sum(input_sequence.*w);
	% end
	
end