function [CDi, M_total] = data_discipline(Aero, winglet, filename_FT, filename_FS)
	switch nargin
		case 2
			filename_FT = '.\\Results_optim\\Total_Force.txt';
			filename_FS = '.\\Results_optim\\Strip_Force.txt';
	end
	fid1 = fileread(fullfile(filename_FS));
% 	[~, e] = regexp(fid1, 'Mx');
% 	[~, e_bref] = regexp(fid1, 'Bref  =');
% 	[~, e_sref] = regexp(fid1, 'Sref  =');
% 	b_ref = str2double(fid1(e_bref + 1:e_bref + 13));
% 	S_ref = str2double(fid1(e_sref + 1:e_sref + 13));
% 	start_wing = e(1) + 44;
% 	if ~isempty(winglet)
% 		[~, e_V] = regexp(fid1, 'Vz');
% 		start_winglet = e(3) + 44;
% 		start_winglet_V = e_V(3) + 44;
% 		M_winglet = str2double(fid1(start_winglet:start_winglet + 13))*b_ref*S_ref + 14*S_ref*str2double(fid1(start_winglet_V:start_winglet_V + 13));
% 	else 
% 		M_winglet = 0;
% 	end
% 	M_wing = str2double(fid1(start_wing:start_wing + 13))*b_ref*S_ref;
% 	M_total = M_wing + M_winglet;
	[~, e] = regexp(fid1, 'c cl');
	start_wing = e(1) + 110;
	start_wing_y = e(1) + 110 - 27;
	ccl_wing = zeros(30, 1);
	wing_y = zeros(size(ccl_wing));
	if ~isempty(winglet)
		start_winglet = e(3) + 110;
		start_winglet_y = e(3) + 110 - 27;
		ccl_winglet = zeros(size(ccl_wing));
		winglet_y = zeros(size(ccl_wing));
	end
	count = 1;
	for i = 0:29
		ccl_wing(count, 1) = str2double(fid1(start_wing + i*116:start_wing + i*116 + 6));
		wing_y(count, 1) = str2double(fid1(start_wing_y + i*116:start_wing_y + i*116 + 6)); 
		if ~isempty(winglet)
			ccl_winglet(count, 1) = str2double(fid1(start_winglet + i*116:start_winglet + i*116 + 6));
			winglet_y(count, 1) = str2double(fid1(start_winglet_y + i*116:start_winglet_y + i*116 + 6));
		end
		count = count + 1;
	end
	V = Aero.M*Aero.a;
	rho = Aero.rho;
	ccl_wing = ccl_wing.*(0.5*rho*(V^2));
	
	if ~isempty(winglet)
		ccl = [ccl_wing; ccl_winglet.*(0.5*rho*(V^2))];
		Y = [wing_y; winglet_y];
	else
		ccl = ccl_wing;
		Y = wing_y;
	end
	
	M_total = trapz(Y, cumtrapz(Y, ccl));
	
	fid1 = fileread(fullfile(filename_FT));
	[~, e] = regexp(fid1, 'CDind = ');
	CDi = str2double(fid1(e + 1:e + 9));
	fclose all;
end