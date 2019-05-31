function mask = construct_LPF(radius, size_dft)
	% Returns a low pass (circular and centralised) filter of the given radius and size

	M = size_dft(1);
    N = size_dft(2);
	
	x_coord = 1:M;
	x_coord = x_coord - (M+1)/2;	
	y_coord = 1:N;
	y_coord = y_coord - (N+1)/2;

	% Constructing a grid
	[nx, ny] = ndgrid(x_coord, y_coord);

	% mask construction
	mask = (nx.^2 + ny.^2 <= radius^2);

	% % Display the mask
	% imshow(mask)
end