% Author: Sarthak Nijhawan
% 
% Disclaimer: None of the code has been copied or emulted from any outside source

function [output] = myFFT1D_helper(input, N)
	% Input:
	%		input 		-> Input Sequence
	% 		N 			-> Length of the sequence (Assumed to be a power of 2)

	% Base Case
	if N == 2
		% Do nothing since input(1) is already set
		output = [input(1)+input(2), input(1)-input(2)];
		return
    end
    
    % Separate even and odd indexed elements
	even_inputs = input(1:2:N-1);
	odd_inputs = input(2:2:N);

	% Calling the recursions
	Ek = myFFT1D_helper(even_inputs, N/2);
	Ok = myFFT1D_helper(odd_inputs, N/2);

	u = 0:N/2-1;
	w = exp(-1i*2*pi*u/N);

	% Using the cyclicity; DFT(k) = DFT(k+N/2)
	half1 = Ek + w.*Ok;
	half2 = Ek - w.*Ok;

	% Combining the two halves
	output = [half1, half2];

end