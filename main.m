
% Description:  Main Script to initiate an interactive command line interface 
% 				to showcase and compare various image restoration techniques on
% 				sample images mentioned in the problem statement

clc
close all
clear all

disp('Select from below:')
disp('(1) Restore sample images using different methods');
disp('(2) Degrade an image and restore using different methods');
disp('(3) g part of the assingment');
ans = input('Response = ');

switch ans
	case 1
		sample_restore
	case 2
		custom_degrade_and_restore
	case 3
		g_part
	otherwise
		disp('Please enter a valid integer');
		disp('Exiting........');	
end
