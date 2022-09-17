load ('pareto_final.mat')
k_lst1 = k_list;
CDi_lst1 = CDi_lst;
M_lst1 = M_lst;

load ('pareto_small_domain.mat')
k_lst2 = k_list;
CDi_lst2 = CDi_lst;
M_lst2 = M_lst;

load ('pareto_small_domain2.mat')
k_lst3 = k_list;
CDi_lst3 = CDi_lst;
M_lst3 = M_lst;


k_lst = [k_lst1 k_lst2 k_lst3];
CDi_lst  =  [CDi_lst1 CDi_lst2 CDi_lst3];
M_lst  =  [M_lst1 M_lst2 M_lst3];

savename = 'combined_pareto';
save(savename, 'CDi_lst','M_lst','k_lst');