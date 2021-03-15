function Contourfig1()
% plot contour figure of different control level
variant_list=[2];
% 1: Transmissibility; 2: Severity;
criterion_list=[1];
% 1: Mortality; 2: Infection;
addpath('./function/')
for n_criterion=1:length(criterion_list)
    criterion=criterion_list(n_criterion);
    for n_variant=1:length(variant_list)
        variant=variant_list(n_variant);
        maxt=50;
        app=appvar;
        % initialize axis
        x = (0:maxt-1).*(3/(maxt-1))+1;
        y = Linear(1:maxt,1,0,maxt,2);
        z = zeros(maxt,maxt);
        c = zeros(maxt,maxt);
        %initialize parameters
        app.population=60e6; % population
        app.max_time=4000; % initial stimulation time
        app.initv1=10000/app.population; % initial infection population of original strain
        app.initv2=(10^2)/app.population; % initial infection population of emerging strain
        app=SetControlLevel(app,1);
        % start stimulation
        for n_var=(1:maxt)
            for n_pol=(1:maxt)
                var=Linear(n_var,1,0,maxt,2);
                pol=(n_pol-1)*(3/(maxt-1))+1;
                % set parameters
                if variant==1 % SetTransmissibility
                    app=SetTransmissibility(app,var);
                    app=InitialTrans(app);
                    app=Insert(app,pol);
                    app=SetTransmissibility(app,var);
                end
                if variant==2 % SetSeverity
                    app=SetSeverity(app,var);
                    app=InitialTrans(app);
                    app=Insert(app,pol);
                    app=SetSeverity(app,var);
                end
                maxtemp=app.max_time;
                while 1
                    [~, m]=Stimulation(app,app.max_time,app.initstate);
                    if sum(m(end,2:6),2)+sum(m(end,7:11),2)<1e-6
                        break
                    end
                    app.max_time=app.max_time*10;
                end
                app.max_time=maxtemp;
                e0=1e-10;
                if criterion==1
                    z(n_var,n_pol)=m(end,14)+m(end,15);
                    if (m(end,15)+e0)/(m(end,14)+e0)>=0
                        c(n_var,n_pol)=log((m(end,15)+e0)/(m(end,14)+e0));
                    end
                end
                if criterion==2
                    z(n_var,n_pol)=1-m(end,1);
                    if ((m(end,15)+m(end,13)+e0)/(m(end,14)+m(end,12)+e0))>=0
                        c(n_var,n_pol)=log((m(end,15)+m(end,13)+e0)/(m(end,14)+m(end,12)+e0));
                    end
                end
            end
        end
        h=figure;
        z(z==0)=NaN;
        z=z';
        levels=1000;
        contourf(y,x,z,levels,'EdgeColor','none');
        caxis([0,3.5e-3])
        yticks([1 2 3 4])
        set(gca,'yticklabel',{'','','',''})
        set(gca,'yminortick','off')
        colorbar;
    end
end
end


function app=Insert(app,i)
x=1:4;
[app1,app2,app3,app4]=deal(SetControlLevel(app,1),SetControlLevel(app,2),SetControlLevel(app,3),SetControlLevel(app,4));
alpha_1=[app1.alpha_1,app2.alpha_1,app3.alpha_1,app4.alpha_1];
beta_1=[app1.beta_1,app2.beta_1,app3.beta_1,app4.beta_1];
gamma_1=[app1.gamma_1,app2.gamma_1,app3.gamma_1,app4.gamma_1];
delta_1=[app1.delta_1,app2.delta_1,app3.delta_1,app4.delta_1];
epsilon_1=[app1.epsilon_1,app2.epsilon_1,app3.epsilon_1,app4.epsilon_1];
theta_1=[app1.theta_1,app2.theta_1,app3.theta_1,app4.theta_1];
zeta_1=[app1.zeta_1,app2.zeta_1,app3.zeta_1,app4.zeta_1];
eta_1=[app1.eta_1,app2.eta_1,app3.eta_1,app4.eta_1];
mu_1=[app1.mu_1,app2.mu_1,app3.mu_1,app4.mu_1];
nu_1=[app1.nu_1,app2.nu_1,app3.nu_1,app4.nu_1];
tau_1=[app1.tau_1,app2.tau_1,app3.tau_1,app4.tau_1];
lambda_1=[app1.lambda_1,app2.lambda_1,app3.lambda_1,app4.lambda_1];
rho_1=[app1.rho_1,app2.rho_1,app3.rho_1,app4.rho_1];
kappa_1=[app1.kappa_1,app2.kappa_1,app3.kappa_1,app4.kappa_1];
xi_1=[app1.xi_1,app2.xi_1,app3.xi_1,app4.xi_1];
sigma_1=[app1.sigma_1,app2.sigma_1,app3.sigma_1,app4.sigma_1];

app.alpha_1=interp1(x,alpha_1,i);
app.beta_1=interp1(x,beta_1,i);
app.gamma_1=interp1(x,gamma_1,i);
app.delta_1=interp1(x,delta_1,i);
app.epsilon_1=interp1(x,epsilon_1,i);
app.theta_1=interp1(x,theta_1,i);
app.zeta_1=interp1(x,zeta_1,i);
app.eta_1=interp1(x,eta_1,i);
app.mu_1=interp1(x,mu_1,i);
app.nu_1=interp1(x,nu_1,i);
app.tau_1=interp1(x,tau_1,i);
app.lambda_1=interp1(x,lambda_1,i);
app.rho_1=interp1(x,rho_1,i);
app.kappa_1=interp1(x,kappa_1,i);
app.xi_1=interp1(x,xi_1,i);
app.sigma_1=interp1(x,sigma_1,i);

[app.alpha_2, app.beta_2 ,app.gamma_2, app.delta_2] = deal(1*app.alpha_1, 1*app.beta_1 ,1*app.gamma_1, 1*app.delta_1); % ???
[app.epsilon_2, app.theta_2, app.zeta_2, app.eta_2] = deal(app.epsilon_1, app.theta_1, app.zeta_1, app.eta_1); % ??????
[app.mu_2, app.nu_2, app.tau_2] = deal(app.mu_1, app.nu_1, app.tau_1); % ??????
[app.lambda_2, app.rho_2, app.kappa_2, app.xi_2, app.sigma_2] = deal(app.lambda_1, app.rho_1, app.kappa_1, app.xi_1, app.sigma_1); % ???
app.omega_1=0.01;
app.omega_2=0.01;
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

