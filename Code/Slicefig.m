function Slicefig()
% mortality under different policies when the emerging strain is at indicated severities relative to the original strain
policy_list=[1 3 4 6];
% Policies:
% 1: Isolation; 2: Isolation & Screen; 3: Screen;
% 4: Cure;      5: Cabin Hospital;     6: Block;
control_list=[3];
% Control Levels:
% 1: Free Development; 2: Weak Control;
% 3: Medium Control;   4: Strict Control;
initial_list=[2];
% Initial Infection Ratio (origin : emerging strain)
% 1: 10000:10;   2: 10000:100;
% 3: 10000:1000; 4: 10000:10000;
variant_list=[2];
% 1: Transmissibility; 2: Severity;
criterion_list=[1];
% 1: Mortality; 2: Infection;

severity_rate=0.5;

policy_sampling=61;
variant_sampling=61;
minrate=0.5;
maxrate=8;
h=figure;
for n_criterion=1:length(criterion_list)
    criterion=criterion_list(n_criterion);
    for n_variant=1:length(variant_list)
        variant=variant_list(n_variant);
        for n_initial=1:length(initial_list)
            initial=initial_list(n_initial);
            for n_control=1:length(control_list)
                control=control_list(n_control);
                for n_policy=1:length(policy_list)
                    policy=policy_list(n_policy);
                    app=appvar;
                    app=SetControlLevel(app,control);
                    app=SetPolicyBase(app,policy);
                    x=Loglinear(1:policy_sampling,1,minrate,policy_sampling,maxrate);
                    z = zeros(variant_sampling,policy_sampling);
                    c = zeros(variant_sampling,policy_sampling);
                    for n_pol=(1:policy_sampling)
                        n_var=1;
                        var=severity_rate;
                        pol=Loglinear(n_pol,1,minrate,policy_sampling,maxrate);
                        app.population=60e6; % population
                        app.max_time=4000; % initial stimulation time
                        app.initv1=10000/app.population; % initial infection population of original strain
                        app.initv2=(10^initial)/app.population; % initial infection population of emerging strain
                        if variant==1 % SetTransmissibility
                            app=SetTransmissibility(app,var);
                            app=InitialTrans(app);
                            app=SetControlLevel(app,control);
                            app=SetPolicy(app,policy,1,pol);
                            app=SetTransmissibility(app,var);
                        end
                        if variant==2 % SetSeverity
                            app=SetSeverity(app,var);
                            app=InitialTrans(app);
                            app=SetControlLevel(app,control);
                            app=SetPolicy(app,policy,var,pol);
                            app=SetSeverity(app,var);
                        end
                        maxtemp=app.max_time;
                        while 1
                            [~, m]=Stimulation(app,app.max_time,app.initstate);
                            if sum(m(end,2:6),2)+sum(m(end,7:11),2)<1e-6
                                break
                            end
                            app.max_time=app.max_time*10;
                            if app.max_time>10000
                                break
                            end
                        end
                        app.max_time=maxtemp;
                        m(m<0)=0;
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
                    plot(x,z(1,1:end),'LineWidth',1)
                    xlim([0.5,8])
                    hold on
                    set(gca,'xscale','log');
                    xticks([0.5 1 2 4 8]);
                    set(gca,'xminortick','off')
                end
                policy_name={'Isolation','Isolation&Screen', 'Screen', 'Cure', 'CabinHospital', 'Block'};
                legend(policy_name(policy_list))
            end
        end
    end
end
end

function app=SetPolicyBase(app,pol)
if pol==1
    app.initpol=app.beta_1;
end
if pol==2
    app.initpol=1;
end
if pol==3
    app.initpol=app.theta_1;
end
if pol==4
    app.initpol=app.rho_1;
end
if pol==5
    app.initpol=app.mu_1;
end
if pol==6
    app.initpol=app.alpha_1;
end
end