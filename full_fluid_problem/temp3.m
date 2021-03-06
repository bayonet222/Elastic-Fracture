clear

load n524x846-mod
s = 0.138673;
u = 4 - 6*s;

K = 3*sqrt(2*pi)*KI;
p1 = polyfit(K(end-1:end).^u,lambda(end-1:end),1);
%l0 = 0.05915;
l0 = p1(2);
%%{

[h0_prime ,h0_prime_LEFM] = interpolate_hprime(x,n,hprime_data,K,0.5,l0);

h_coefficient_matrix = hprime_to_h_s(x,0.5,t);

h0 = h_integrate(h0_prime',x,n,t,h_coefficient_matrix,0.5 );
h0_z = h_integrate(h0_prime',z,n-1,t,h_coefficient_matrix,0.5 );

h0_LEFM = h_integrate(h0_prime_LEFM',x,n,t,h_coefficient_matrix,0.5 );
h0_LEFM_z = h_integrate(h0_prime_LEFM',z,n-1,t,h_coefficient_matrix,0.5 );



h0_prime_LEFM_23 = convert(0.5,2/3,n,t,x,h0_prime_LEFM);
h_coefficient_matrix_23 = hprime_to_h_s(x,2/3,t);
h0_LEFM_23 = h_integrate(h0_prime_LEFM_23,x,n,t, ... 
    h_coefficient_matrix_23,2/3);
h0_LEFM_23_z = h_integrate(h0_prime_LEFM_23,z,n-1,t, ...
    h_coefficient_matrix_23,2/3);

[~,H] = linear_perturbation_solve(n,t,x,z, h0,h0_z,l0,kernel_matrix,s);

[~,H_LEFM] = linear_perturbation_solve(n,t,x,z, h0_LEFM,h0_LEFM_z,l0,...
    kernel_matrix,s);
%}
[~,H_LEFM_23] = linear_perturbation_solve(n,t,x,z, h0_LEFM_23,...
    h0_LEFM_23_z,l0,kernel_matrix,s);



plot(x,H'.*x.^-s,'o',x,H_LEFM'.*x.^-s,'o',x,H_LEFM_23'.*x.^-s,'*')
hold on
%plot(x,H_LEFM_23'.*x.^-s,'*')


ax = gca;
axis square
xlabel(ax,'$ \xi $','Interpreter','latex','fontsize',25);
ylabel(ax,'$ \tilde{H} \xi^{-s}$','Interpreter','latex','fontsize',25);
title(ax,'Linear perturbation problem estimates of $\tilde{H}\xi^{-s}$',...
    'fontsize', 25,'Interpreter','latex');

axis([0,0.15,0.5,0.95])

%{
er = ones(1,round(0.2*n));
for l = round(0.05*n):round(0.2*n)
    p3 = polyfit(x(l:l+3) , H_LEFM_23(l:l+3)'.*x(l:l+3).^(-s),1);
    p4 = polyfit(x(l:l+4) ,H_LEFM_23(l:l+4)'.*x(l:l+4).^(-s) ,2);
    er(l) = abs(p3(2)-p4(3));
end
[~,I] = min(er(:));

p3 = polyfit(x(I:I+3) ,H_LEFM_23(I:I+3)'.*x(I:I+3).^(-s), 1);
p4 = polyfit(x(I:I+4) ,H_LEFM_23(I:I+4)'.*x(I:I+4).^(-s), 2);

%interp2(1:I) = (p3(1)*x(1:I)+p3(2)).*x(1:I).^(2/3-a);
fprintf('intercept = %.3e\n',p3(2))
intercept(k) = p3(2);
%}