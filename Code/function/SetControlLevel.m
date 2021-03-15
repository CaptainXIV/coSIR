function app=SetControlLevel(app,i)
% Free Development
if(i==1)
    [app.alpha_1, app.beta_1 ,app.gamma_1, app.delta_1] = deal(0.57, 0.114, 0.456, 0.114); 
    [app.epsilon_1, app.theta_1, app.zeta_1, app.eta_1] = deal(0.1026, 0.3705, 0.1254, 0.1254);
    [app.mu_1, app.nu_1, app.tau_1] = deal(0.0171, 0.0274, 0.0001);
    [app.lambda_1, app.rho_1, app.kappa_1, app.xi_1, app.sigma_1] = deal(0.0342, 0.0342, 0.0171, 0.0171, 0.0171);
    app.omega_1=0.01;  
    [app.alpha_2, app.beta_2 ,app.gamma_2, app.delta_2] = deal(1*app.alpha_1, 1*app.beta_1 ,1*app.gamma_1, 1*app.delta_1);
    [app.epsilon_2, app.theta_2, app.zeta_2, app.eta_2] = deal(app.epsilon_1, app.theta_1, app.zeta_1, app.eta_1);
    [app.mu_2, app.nu_2, app.tau_2] = deal(app.mu_1, app.nu_1, app.tau_1);
    [app.lambda_2, app.rho_2, app.kappa_2, app.xi_2, app.sigma_2] = deal(app.lambda_1, app.rho_1, app.kappa_1, app.xi_1, app.sigma_1);
    app.omega_2=0.01;
end
% Weak Control
if(i==2)
    [app.alpha_1, app.beta_1 ,app.gamma_1, app.delta_1] = deal(0.4218, 0.0057, 0.285 , 0.0057); 
    [app.epsilon_1, app.theta_1, app.zeta_1, app.eta_1] = deal(0.1026, 0.3705, 0.1254, 0.1254); 
    [app.mu_1, app.nu_1, app.tau_1] = deal(0.0171, 0.0274, 0.0001); 
    [app.lambda_1, app.rho_1, app.kappa_1, app.xi_1, app.sigma_1] = deal(0.0342, 0.0342, 0.0171, 0.0171, 0.0171); 
    app.omega_1=0.01;
    [app.alpha_2, app.beta_2 ,app.gamma_2, app.delta_2] = deal(1*app.alpha_1, 1*app.beta_1 ,1*app.gamma_1, 1*app.delta_1);
    [app.epsilon_2, app.theta_2, app.zeta_2, app.eta_2] = deal(app.epsilon_1, app.theta_1, app.zeta_1, app.eta_1);
    [app.mu_2, app.nu_2, app.tau_2] = deal(app.mu_1, app.nu_1, app.tau_1); 
    [app.lambda_2, app.rho_2, app.kappa_2, app.xi_2, app.sigma_2] = deal(app.lambda_1, app.rho_1, app.kappa_1, app.xi_1, app.sigma_1); 
    app.omega_2=0.01;
end
% Medium Control
if(i==3)
    [app.alpha_1, app.beta_1 ,app.gamma_1, app.delta_1] = deal(0.27,0.023166667,0.167666667,0.023166667);
    [app.epsilon_1, app.theta_1, app.zeta_1, app.eta_1] = deal(0.1026, 0.3705, 0.1254, 0.1254);
    [app.mu_1, app.nu_1, app.tau_1] = deal(0.0171, 0.0274, 0.0001);
    [app.lambda_1, app.rho_1, app.kappa_1, app.xi_1, app.sigma_1] = deal(0.0342, 0.0342, 0.0171, 0.0171, 0.0171); 
    app.omega_1=0.01;
    [app.alpha_2, app.beta_2 ,app.gamma_2, app.delta_2] = deal(1*app.alpha_1, 1*app.beta_1 ,1*app.gamma_1, 1*app.delta_1); 
    [app.epsilon_2, app.theta_2, app.zeta_2, app.eta_2] = deal(app.epsilon_1, app.theta_1, app.zeta_1, app.eta_1);
    [app.mu_2, app.nu_2, app.tau_2] = deal(app.mu_1, app.nu_1, app.tau_1); 
    [app.lambda_2, app.rho_2, app.kappa_2, app.xi_2, app.sigma_2] = deal(1.0*app.lambda_1, 1.0*app.rho_1, 1.0*app.kappa_1, 1.0*app.xi_1, 1.0*app.sigma_1); 
    app.omega_2=0.01;
end
% Strict Control
if(i==4)
    [app.alpha_1, app.beta_1 ,app.gamma_1, app.delta_1] = deal(0.21, 0.005, 0.11, 0.005);
    [app.epsilon_1, app.theta_1, app.zeta_1, app.eta_1] = deal(0.2, 0.3705, 0.025, 0.025); 
    [app.mu_1, app.nu_1, app.tau_1] = deal(0.008, 0.015, 0.0001);
    [app.lambda_1, app.rho_1, app.kappa_1, app.xi_1, app.sigma_1] = deal(0.08, 0.08, 0.02, 0.02, 0.02);
    app.omega_1=0.01;
    [app.alpha_2, app.beta_2 ,app.gamma_2, app.delta_2] = deal(1*app.alpha_1, 1*app.beta_1 ,1*app.gamma_1, 1*app.delta_1); 
    [app.epsilon_2, app.theta_2, app.zeta_2, app.eta_2] = deal(app.epsilon_1, app.theta_1, app.zeta_1, app.eta_1); 
    [app.mu_2, app.nu_2, app.tau_2] = deal(app.mu_1, app.nu_1, app.tau_1);
    [app.lambda_2, app.rho_2, app.kappa_2, app.xi_2, app.sigma_2] = deal(app.lambda_1, app.rho_1, app.kappa_1, app.xi_1, app.sigma_1); 
    app.omega_2=0.01;
end
app.te=app.theta_1/app.epsilon_1;
app.ba=app.beta_1/app.alpha_1;
app.ga=app.gamma_1/app.alpha_1;
app.da=app.delta_1/app.alpha_1;
app.rl=app.rho_1/app.lambda_1;
app.kl=app.kappa_1/app.lambda_1;
app.xl=app.xi_1/app.lambda_1;
app.sl=app.sigma_1/app.lambda_1;
app.db=app.delta_1/app.beta_1;
app.nm=app.nu_1/app.mu_1;
end