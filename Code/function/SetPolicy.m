function app=SetPolicy(app,pol,i,j)
addpath('./function/')
if pol==1
    app=SetIsolation(app,app.initpol/j);
end
if pol==2 % For Medium Coontrol
    app=SetScreen(app,j*0.3705);
    app=SetIsolation(app,1/j*0.023166667);
end
if pol==3
    app=SetScreen(app,app.initpol*j);
end
if pol==4
    app=SetCure(app,app.initpol*j,i);
end
if pol==5 % For Medium Coontrol
    app=SetSevere(app,app.initpol/j);
    app=SetIsolation(app,0.001);
    [app.rho_1,app.xi_1] = deal(0.0342*(0.9+0.1*j),0.0171*(0.9+0.1*j));
    [app.rho_2,app.xi_2] = deal(app.rho_1/(1.1-i*0.1),app.xi_1/(1.1-i*0.1));
    app=SetCure(app,1*j);
end
if pol==6
    app=SetBlock(app,app.initpol/j);
end
end

function app=SetIsolation(app,rate)
[ app.beta_1 , app.delta_1] = deal(rate, app.db*rate);
[ app.beta_2 , app.delta_2] = deal(1*app.beta_1 ,1*app.delta_1);
end

function app=SetScreen(app,rate)
[app.epsilon_1, app.theta_1] = deal(rate/app.te, rate);
[app.epsilon_2, app.theta_2] = deal(app.epsilon_1, app.theta_1);
app.epsilon_1=Rangecheck(app.epsilon_1);
app.epsilon_2=Rangecheck(app.epsilon_2);
app.theta_1=Rangecheck(app.theta_1);
app.theta_2=Rangecheck(app.theta_2);
end

function app=SetBlock(app,rate)
[app.alpha_1, app.beta_1 ,app.gamma_1, app.delta_1] = deal(rate, app.ba*rate, app.ga*rate, app.da*rate);
[app.alpha_2, app.beta_2 ,app.gamma_2, app.delta_2] = deal(1*app.alpha_1, 1*app.beta_1 ,1*app.gamma_1, 1*app.delta_1);
end

function app=SetCure(app,rate1,rate2)
[app.lambda_1, app.rho_1, app.kappa_1, app.xi_1, app.sigma_1] = deal(rate1/app.rl, rate1, app.kl*rate1/app.rl, app.xl*rate1/app.rl, app.sl*rate1/app.rl);
[app.lambda_2, app.rho_2, app.kappa_2, app.xi_2, app.sigma_2] = deal(app.lambda_1/rate2, app.rho_1/rate2, app.kappa_1/rate2, app.xi_1/rate2, app.sigma_1/rate2);
end

function app=SetSevere(app,rate)
[app.nu_1] = deal(rate*app.nm);
[app.nu_2] = deal(app.nu_1);
end