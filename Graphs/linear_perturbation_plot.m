clear
load n400x30-extended
K = 3*sqrt(2*pi)*KI;
s = 0.138673;
u = 4 - 6*s;
l0 = 0.05943;
D = -0.00809;
z = tan((0.5:1:n-1.5)*atan(sqrt(xmax))/(n-1)).^2;


[h0_prime,h0_prime_LEFM] = interpolate_hprime(x,n,hprime_data,K);

h_coefficient_matrix = hprime_to_h_s(x,0.5);

h0 = h_integrate(h0_prime',x,n,t,h_coefficient_matrix,0.5);
h0_LEFM = h_integrate(h0_prime_LEFM',x,n,t,h_coefficient_matrix,0.5 );

h0_prime_LEFM_23 = convert(0.5,2/3,n,t,x,h0_prime);
h_coefficient_matrix_23 = hprime_to_h_s(x,2/3);
h0_LEFM_23 = h_integrate(h0_prime_LEFM_23,x,n,t,h_coefficient_matrix_23,2/3);

[~,H] = linear_perturbation_solve(n,t,xmax, h0,l0);
[~,H_LEFM] = linear_perturbation_solve(n,t,xmax, h0_LEFM,l0);
[~,H_LEFM_23] = linear_perturbation_solve(n,t,xmax, h0_LEFM_23,l0);


figure('units','normalized','outerposition',[0 0 0.5 1])
plot(x,H'.*x.^-s,'o',x,H_LEFM'.*x.^-s,'o',x,H_LEFM_23'.*x.^-s)

ax = gca;
axis square
xlabel(ax,'$ \xi $','Interpreter','latex','fontsize',25);
ylabel(ax,'$ \tilde{H} \xi^{-s}$','Interpreter','latex','fontsize',25);
title(ax,'Linear perturbation problem estimates of $\tilde{H}\xi^{-s}$',...
    'fontsize', 25,'Interpreter','latex');
set(ax,'TickLabelInterpreter', 'latex');
set(ax,'fontsize',20')
legend({'$H_0$ interpolated',...
    '$H_0$ interpolated with LEFM correction'},'Interpreter','Latex'...
    ,'fontsize',20,'Location','southeast')


axis([0,0.3,0.5,1])
