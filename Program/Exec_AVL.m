function [] = Exec_AVL(Aero, wing, winglet, var_name, var)
	casefile = '.\sim';
	switch nargin
		case 5
			inputfile = Gen_AVL_inputfile(Aero, wing, winglet);
			[runfilename, avlLocation] = Gen_AVL_casefile(inputfile, casefile, var_name, var);
			[status, result] = dos(strcat(avlLocation, ' < ', runfilename, '.run'));
		case 3
			inputfile = Gen_AVL_inputfile(Aero, wing, winglet);
			[runfilename, avlLocation] = Gen_AVL_casefile(inputfile, casefile);
			[status, result] = dos(strcat(avlLocation, ' < ', runfilename, '.run'));
		case 2
			inputfile = Gen_AVL_inputfile(Aero, wing);
			[runfilename, avlLocation] = Gen_AVL_casefile(inputfile, casefile, 'no_winglets');
			[status, result] = dos(strcat(avlLocation, ' < ', runfilename, '.run'));
	end
end