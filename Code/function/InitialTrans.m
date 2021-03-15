function app=InitialTrans(app)
addpath('./function/')
I=200/app.population;
D=20/app.population;
A=1/app.population;
R=2/app.population;
T=0.00;
H=0.00;
E=0.00;
S=1-I-D-A-R-T-H-E;
x0 = [S, I, D, A, R, T, 0, 0, 0, 0, 0, H, H, E,E];
[~,x1]=Stimulation(app,1000,x0);
x11=[];
x12=[];
for t0=1:1000
    if(sum(x1(t0,2:6),2)>app.initv1)
        x11=x1(t0,:);
        break;
    end
end
x0 = [S, 0, 0, 0, 0, 0, I, D, A, R, T, H, H, E,E];
[~,x1]=Stimulation(app,1000,x0);
for t0=1:1000
    if(sum(x1(t0,7:11),2)>app.initv2)
        x12=x1(t0,:);
        break;
    end
end
app.initstate=zeros(1,13);
if (~isempty(x11))&&(isempty(x12))
    app.initstate=[x11(1), x11(2:6), 0,0,0,0,0, x11(12) ,0, x11(14), 0];
end
if (isempty(x11))&&(~isempty(x12))
    app.initstate=[x12(1), 0,0,0,0,0, x12(7:11), 0 ,x12(13), 0, x12(15)];
end
if (~isempty(x11))&&(~isempty(x12))
    app.initstate=[x11(1)+x12(1)-1, x11(2:6), x12(7:11), x11(12) ,x12(13), x11(14), x12(15)];
end
end
