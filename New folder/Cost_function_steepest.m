function [J,CDi,M_total] = Cost_function_steepest(x, x0, k, CDi0, M_T0, Aero, wing, simplified, alpha, sq, steepest)
    
    if simplified == 1 
        winglet.phi = x(1)*x0(1);
        winglet.sw = x(2)*x0(2);	
        winglet.lw =  0.28;
        winglet.Cwr =  0.8;              %winglet root chord length in %
        winglet.taper = 0.4;		     %winglet taper
        winglet.twr = 0;				%winglet root twist angle
        winglet.twt = 0;				%winglet tip twist angle
        if steepest == 1
            winglet.phi = x(1) + alpha*sq(1);
            winglet.sw = x(2) + alpha*sq(2);
        end 
    else 
        winglet.lw = x(1)*x0(1);				%winglet length in   
        winglet.phi = x(2)*x0(2);				%winglet cant angle 
        winglet.Cwr = x(3)*x0(3);				%winglet root chord length in %
        winglet.taper = x(4)*x0(4);		    %winglet taper
        winglet.sw = x(5)*x0(5);				%winglet leading edge sweep angle
        winglet.twr = 0;				%winglet root twist angle
        winglet.twt = 0;				%winglet tip twist angle
    end 


    winglet
	Exec_AVL(Aero, wing, winglet);
	[CDi, M_total] = data_discipline(Aero, winglet);
 	J = k*(CDi/CDi0) + (1 - k)*(M_total/M_T0)
% 	fprintf('CDi/CDi0 = %f\n', (CDi/CDi0));
% 	fprintf('M_total/M_total_0 = %f\n', (M_total/M_T0));
% 	fprintf('J = %f\n', J);
end

