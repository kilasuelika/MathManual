nvar=6;
A = [];
b = [];
%Aeq*x=beq
Aeq = [];
beq = [];
% 上下界
lb=repmat(-10,1,nvar);
ub=repmat(10,1,nvar);
nonlcon = [];
IntCon=[];

options = optimoptions('fminunc','Display','iter',...
'MaxFunctionEvaluations',Inf,...
'MaxIterations',Inf);

xp=zeros(6,1);
%xp1=fmincon(@fun,xp,A,b,Aeq,beq,lb,ub,nonlcon,options);
xp1=fminunc(@fun, xp, options);

x=0:0.01:1;
y=polyval(xp1, x);
y_real=exp(x);

coeff_real=[1/120,1/24,1/6,1/2,1,1];
y_best_approx=polyval(coeff_real, x);

plot(x,y,x,y_real,x,y_best_approx);

function y=fun(a)
tmax=@(x) x;
integrand=@(x, t) (polyval(a, x)-(exp(x)-x.*exp(x)/3+x/3+x.*polyval(a, t).^3)).^2;
y=integral2(integrand, 0, 1, 0, tmax);
end