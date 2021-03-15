function CoSIR_Model_main()
% --------------------Parameters--------------------
policy_list=[1 2 3 4 5 6];
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
variant_list=[1 2];
% 1: Transmissibility; 2: Severity;
criterion_list=[1 2];
% 1: Mortality; 2: Infection;
plotmode = 1;
% 1: 3D fig;            2: Slice fig;
% 3: Vertical view fig; 4: Peroid fig;

addpath('./function/')
show_figure='on';
variant_sampling=41;
policy_sampling=41;
policy_maxrate=8;
policy_minrate=0.5;

disp(['please waiting'])
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
                    name=GetName(policy,control,initial,variant,criterion);
                    disp(['Detail:',name])
                    % initialize axis
                    x = Loglinear(1:policy_sampling,1,policy_minrate,policy_sampling,policy_maxrate);
                    y = Linear(1:variant_sampling,1,0,variant_sampling,2);
                    z = zeros(variant_sampling,policy_sampling);
                    c = zeros(variant_sampling,policy_sampling);
                    %initialize parameters
                    app=appvar;
                    app=SetControlLevel(app,control);
                    app=SetPolicyBase(app,policy);
                    app.population=60e6; % population
                    app.max_time=4000; % initial stimulation time
                    app.initv1=10000/app.population; % initial infection population of original strain
                    app.initv2=(10^initial)/app.population; % initial infection population of emerging strain
                    % start stimulation
                    for n_var=(1:variant_sampling)
                        for n_pol=(1:policy_sampling)
                            var=Linear(n_var,1,0,variant_sampling,2);
                            pol=Loglinear(n_pol,1,policy_minrate,policy_sampling,policy_maxrate);
                            % set parameters
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
                            % stimulation
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
                            % count infection and mortality
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
                    end
                    % Draw figure
                    if plotmode==1
                        h=Plot3D(x,y,z,c,show_figure);
                    end
                    if plotmode==2
                        h=PlotSlice(x,y,z,c,show_figure);
                    end
                    if plotmode==3
                        h=PlotVertical(x,y,z,c,show_figure);
                    end
                    if plotmode==4
                        h=PlotPeroid(m);
                    end
                    if ~exist('output','dir')
                        mkdir('output');
                    end
                    saveas(h,['./output/',name,'.fig'],'fig')
                end
            end
        end
    end
end
end

function name=GetName(policy,control,initial,variant,criterion)
policy_name={'Isolation','Isolation&Screen', 'Screen', 'Cure', 'CabinHospital', 'Block'};
control_name={'FreeDevelopment','Weak Control','Medium Control','Strict Control'};
initial_name={'1000010','10000100','100001000','1000010000'};
variant_name={'Transmissibility','Severity'};
criterion_name={'Mortality','Infection'};
name=[policy_name{policy},'_',control_name{control},'_',initial_name{initial},'_',variant_name{variant},'_',criterion_name{criterion}];
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





