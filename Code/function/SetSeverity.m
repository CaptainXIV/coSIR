function app=SetSeverity(app,rate)
[app.zeta_2, app.eta_2]=deal(rate*app.zeta_1, rate*app.eta_1);
[app.mu_2, app.nu_2, app.tau_2] = deal(rate*app.mu_1, rate*app.nu_1, rate*app.tau_1);
[app.lambda_2, app.rho_2, app.kappa_2, app.xi_2, app.sigma_2] = deal(app.lambda_1*(1.1-rate*0.1), app.rho_1*(1.1-rate*0.1), app.kappa_1*(1.1-rate*0.1), app.xi_1*(1.1-rate*0.1), app.sigma_1*(1.1-rate*0.1));
end