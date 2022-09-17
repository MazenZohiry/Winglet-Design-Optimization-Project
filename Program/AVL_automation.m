clear;
close all;
clc;
%%
[Aero, wing, winglet] = Datafile();
Exec_AVL(Aero, wing);
filename_FT = '.\\Results\\Total_Force_no_winglets.txt';
filename_FS = '.\\Results\\Strip_Force_no_winglets.txt';
[CDi, M_no_winglet] = data_discipline(Aero, [], filename_FT, filename_FS);

phi_arr = 0:10:90;
lw_arr = 0.02:0.01:0.1;
[CDi_phi, M_phi] = Iter_var_winglet(Aero, wing, winglet, 'phi', phi_arr);
[CDi_lw, M_lw] = Iter_var_winglet(Aero, wing, winglet, 'lw', lw_arr);

%% Plots
%close all;
figure();
plot(phi_arr, CDi_phi, 'k-*')
grid on
xlabel('$\phi \: [^{\circ}]$', 'interpreter', 'Latex', 'FontSize', 15);
ylabel('$C_{D_i}$ [-]', 'interpreter', 'Latex', 'FontSize', 15);
%saveTightLayout(gca);

figure();
plot(phi_arr, M_phi, 'k-*')
grid on
xlabel('$\phi \: [^{\circ}]$', 'interpreter', 'Latex', 'FontSize', 15);
ylabel('$M_x \: [Nm]$', 'interpreter', 'Latex', 'FontSize', 17);
%saveTightLayout(gca);

figure();
plot(lw_arr, CDi_lw, 'k-*')
grid on
xlabel('$l_w$ [-]', 'interpreter', 'Latex', 'FontSize', 15);
ylabel('$C_{D_i}$ [-]', 'interpreter', 'Latex', 'FontSize', 15);
%saveTightLayout(gca);

figure();
plot(lw_arr, M_lw, 'k-*')
grid on
xlabel('$l_w$ [-]', 'interpreter', 'Latex', 'FontSize', 15);
ylabel('$M_x \: [Nm]$', 'interpreter', 'Latex', 'FontSize', 17);
%saveTightLayout(gca);

function [CDi, M] = Iter_var_winglet(Aero, wing, winglet, var_name, var_arr)
	CDi = zeros(size(var_arr));
	M = zeros(size(var_arr));
	idx = 1;
	winglet_i = winglet;
	for var = var_arr
		winglet_i.(var_name) = var;
		Exec_AVL(Aero, wing, winglet_i, var_name, var);
		[CDi(idx), M(idx)] = data_discipline(Aero, winglet_i, ['.\\Results\\Total_Force_' var_name num2str(var) '.txt'], ['.\\Results\\Strip_Force_' var_name num2str(var) '.txt']);
		idx = idx + 1;
	end
end