function [runfilename, avlLocation] = Gen_AVL_casefile(InputFile, CaseFile, var_name, var_value)
	format longg; 
	%% INPUT variables
	%Define a runfile name to save 
	runfilename = '.\RunScript';
	%Location of AVL 
	avlLocation = '.\avl.exe';

	%% Write to RunFile
	%Open the runfile with write permission
	fid = fopen(strcat(runfilename, '.run'), 'w');
	%Load the AVL input and case files
	fprintf(fid, 'LOAD %s\n', InputFile);
	fprintf(fid, 'CASE %s\n', CaseFile);
	fprintf(fid, 'OPER\n');
	fprintf(fid, 'X\n');
	fprintf(fid, 'FT\n');
	switch nargin
		case 4
			TF_name = ['.\\Results\\Total_Force_' var_name num2str(var_value) '.txt'];
			FS_name = ['.\\Results\\Strip_Force_' var_name num2str(var_value) '.txt'];
		case 3
			TF_name = ['.\\Results\\Total_Force_' var_name '.txt'];
			FS_name = ['.\\Results\\Strip_Force_' var_name '.txt'];
		case 2
			TF_name = '.\\Results_optim\\Total_Force.txt';
			FS_name = '.\\Results_optim\\Strip_Force.txt';
	end
	if isfile(TF_name)
		fprintf(fid, TF_name);
		fprintf(fid, '\nO\n');
		fprintf(fid, 'FS\n');
		fprintf(fid, FS_name);
		fprintf(fid, '\nO\n');
		fprintf(fid, '\n');
	else
		fprintf(fid, TF_name);
		fprintf(fid, '\n');
		fprintf(fid, 'FS\n');
		fprintf(fid, FS_name);
		fprintf(fid, '\n');
	%Quit Program
	fprintf(fid, 'Quit\n'); 
	%Close File
	fclose(fid);
end