function [Aero, wing] = Datafile()
	%% Wing Geometry
	span = 14;
	root_c = 5.5;
	tip_c = 2.0;
	taper = tip_c/root_c;
	MAC = root_c*2/3*((1 + taper + taper^2)/(1 + taper));

	%% Aero data
	alt = 6000;
	rho = 0.66;
	M = 0.7;
	CL = 0.6;
	a = 316.428;
	wing = struct('span', span, 'root_c', root_c, 'tip_c', tip_c, 'taper', taper, 'MAC', MAC);
	Aero = struct('alt', alt, 'rho', rho, 'M', M, 'a', a, 'CL', CL); 
end