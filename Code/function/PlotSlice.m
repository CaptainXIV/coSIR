function h=PlotSlice(x,y,z,c,show_figure)
% plot slice fig
numb=8;
[variant_sampling,policy_sampling]=size(z);
h=figure;
h.Visible=show_figure;
z(z==0)=NaN;
hold off
for i2=1:numb
    i3=round(Linear(i2,1,1,numb,policy_sampling));
    plot(y,z(1:end,i3),'Color','black');
    hold on
end
xlim([0,2])
set(gca,'Xdir','reverse');
for i2=1:numb
    i3=round(Linear(i2,1,1,numb,policy_sampling));
    gtext(['policy=',num2str(x(i3))]);
    hold on
end
hold off
end