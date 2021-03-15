function h=PlotVertical(x,y,z,c,show_figure)
% plot vertical view fig
[variant_sampling,policy_sampling]=size(z);
h=figure;
h.Visible=show_figure;
z(z==0)=NaN;
contourf(y,x(30:end),c(1:end,30:end)',50,'EdgeColor','none')
hold on
plot(ones(1,variant_sampling-29),x(30:end))
mycolormap = customcolormap(linspace(0,1,11), {'#a60026','#d83023','#f66e44','#faac5d','#ffffbd','#ffffff','#c8edf5','#abd9e9','#73add2','#4873b5','#313691'});
set(gcf,'colormap',mycolormap);
set(gca,'Xdir','reverse');
caxis([-5 5])
end