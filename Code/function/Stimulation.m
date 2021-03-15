function [tspan, x] = Stimulation(app,time,x0)
step=1;
t=1:step:time;
f = @(t,x)[((-app.alpha_1*x(2)-app.beta_1*x(3)-app.gamma_1*x(4)-app.delta_1*x(5))+...
    (-app.alpha_2*x(7)-app.beta_2*x(8)-app.gamma_2*x(9)-app.delta_2*x(10)))*x(1);
    
    (app.alpha_1*x(2)+app.beta_1*x(3)+app.gamma_1*x(4)+app.delta_1*x(5))*(x(1)+app.omega_1*(x(12)+x(13)))-(app.epsilon_1+app.zeta_1+app.lambda_1)*x(2);
    app.epsilon_1*x(2)-(app.eta_1+app.rho_1)*x(3);
    app.zeta_1*x(2)-(app.theta_1+app.mu_1+app.kappa_1)*x(4);
    app.eta_1*x(3)+app.theta_1*x(4)-(app.nu_1+app.xi_1)*x(5);
    app.mu_1*x(4)+app.nu_1*x(5)-(app.sigma_1+app.tau_1)*x(6);
    
    (app.alpha_2*x(7)+app.beta_2*x(8)+app.gamma_2*x(9)+app.delta_2*x(10))*(x(1)+app.omega_2*(x(12)+x(13)))-(app.epsilon_2+app.zeta_2+app.lambda_2)*x(7);
    app.epsilon_2*x(7)-(app.eta_2+app.rho_2)*x(8);
    app.zeta_2*x(7)-(app.theta_2+app.mu_2+app.kappa_2)*x(9);
    app.eta_2*x(8)+app.theta_2*x(9)-(app.nu_2+app.xi_2)*x(10);
    app.mu_2*x(9)+app.nu_2*x(10)-(app.sigma_2+app.tau_2)*x(11);
    
    app.lambda_1*x(2)+app.rho_1*x(3)+app.kappa_1*x(4)+app.xi_1*x(5)+app.sigma_1*x(6)-(app.alpha_1*x(2)+app.beta_1*x(3)+app.gamma_1*x(4)+app.delta_1*x(5))*app.omega_1*(x(12)+x(13));
    app.lambda_2*x(7)+app.rho_2*x(8)+app.kappa_2*x(9)+app.xi_2*x(10)+app.sigma_2*x(11)-(app.alpha_2*x(7)+app.beta_2*x(8)+app.gamma_2*x(9)+app.delta_2*x(10))*app.omega_2*(x(12)+x(13));
    app.tau_1*x(6);
    app.tau_2*x(11)];

[tspan, x] = ode45(f, t, x0);

end