function Contourfig2()
% plot contour figure of Transmissibility and Severity
control_list=[1];
% Control Levels:
% 1: Free Development; 2: Weak Control;
% 3: Medium Control;   4: Strict Control;
addpath('./function/')
for n_control=1:length(control_list)
    control=control_list(n_control);
    app=appvar;
    maxt=50;
    maxt1=50;
    minrate=0;
    maxrate=2;
    x=Linear(1:maxt,1,minrate,maxt,maxrate);
    y=Linear(1:maxt,1,0,maxt,2);
    z = zeros(maxt,maxt1);
    zx1 = zeros(maxt,maxt1);
    zx2 = zeros(maxt,maxt1);
    zx3 = zeros(maxt,maxt1);
    zx4 = zeros(maxt,maxt1);
    c = zeros(maxt,maxt1);
    cx = zeros(maxt,maxt1);
    app=SetControlLevel(app,1);
    app.population=60e6; % population
    app.max_time=4000; % initial stimulation time
    app.initv1=10000/app.population; % initial infection population of original strain
    app.initv2=(10^2)/app.population; % initial infection population of emerging strain
    for nvar1=(1:maxt)
        for nvar2=(1:maxt1)
            var1=Linear(nvar1,1,minrate,maxt,maxrate);
            var2=Linear(nvar2,1,0,maxt,2);
            app=SetTransmissibility(app,var1);
            app=SetSeverity(app,var2);
            app=InitialTrans(app);
            app=SetControlLevel(app,control);
            app=SetBlock(app,0.11);
            app=SetTransmissibility(app,var1);
            app=SetSeverity(app,var2);
            maxtemp=app.max_time;
            while 1
                [~, m]=Stimulation(app,app.max_time,app.initstate);
                if sum(m(end,2:6),2)+sum(m(end,7:11),2)<1e-6
                    break
                end
                app.max_time=app.max_time*10;
            end
            app.max_time=maxtemp;
            z(nvar1,nvar2)=m(end,14)+m(end,15);
            zx1(nvar1,nvar2)=m(end,12)+m(end,13)+m(end,14)+m(end,15);
            zx2(nvar1,nvar2)=m(end,13)+m(end,15);
            zx3(nvar1,nvar2)=m(end,14)+m(end,15);
            zx4(nvar1,nvar2)=m(end,15);
            e0=1e-10;
            c(nvar1,nvar2)=log((m(end,15)+e0)/(m(end,14)+e0));
            cx(nvar1,nvar2)=log((m(end,15)+m(end,13)+e0)/(m(end,14)+m(end,12)+e0));
        end
    end
    z=z';
    zx1=zx1';
    zx2=zx2';
    zx3=zx3';
    zx4=zx4';
    c=c';
    cx=cx';
    h1=figure;
    contourf(x,y,zx1,1000,'EdgeColor','none');
    colorbar;
    h2=figure;
    contourf(x,y,zx2,1000,'EdgeColor','none');
    colorbar;
    h3=figure;
    contourf(x,y,zx3,1000,'EdgeColor','none');
    colorbar;
    h4=figure;
    contourf(x,y,zx4,1000,'EdgeColor','none');
    colorbar;
    h5=figure;
    mycolormap = customcolormap(linspace(0,1,11), {'#a60026','#d83023','#f66e44','#faac5d','#ffffbd','#ffffff','#c8edf5','#abd9e9','#73add2','#4873b5','#313691'});
    contourf(x,y,c,1000,'EdgeColor','none');
    set(gcf,'colormap',mycolormap);
    colorbar;
    caxis([-5,5])
    h6=figure;
    contourf(x,y,cx,1000,'EdgeColor','none');
    set(gcf,'colormap',mycolormap);
    colorbar;
    caxis([-5,5])
end
end

function app=SetBlock(app,rate)
[app.alpha_1, app.beta_1 ,app.gamma_1, app.delta_1] = deal(rate, app.ba*rate, app.ga*rate, app.da*rate);
[app.alpha_2, app.beta_2 ,app.gamma_2, app.delta_2] = deal(1*app.alpha_1, 1*app.beta_1 ,1*app.gamma_1, 1*app.delta_1);
end
