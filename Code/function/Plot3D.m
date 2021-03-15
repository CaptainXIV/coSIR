function h=Plot3D(x,y,z,c,show_figure)
h=figure;
h.Visible=show_figure;
surf(x,y,z,c,'EdgeColor','none');
hold on
mesh(x,y,z,c,'FaceColor','none','EdgeColor','black');
[variant_sampling,policy_sampling]=size(z);
Y=ones(1,policy_sampling);
X=x;
Z=z((variant_sampling-1)/2+1,:);
plot3(X,Y,Z,'LineStyle',':','LineWidth',2,'Color',[0,0,0]);
[Az,El]=deal(-37.5+180,30);
view(Az,El)
mycolormap = customcolormap(linspace(0,1,11), {'#a60026','#d83023','#f66e44','#faac5d','#ffffbd','#ffffff','#c8edf5','#abd9e9','#73add2','#4873b5','#313691'});
set(gcf,'colormap',mycolormap);
set(gca,'Ydir','reverse');
caxis([-5 5]);
xlim([0.5 8]);
ylim([0,2]);
set(gca,'xscale','log');
xticks([0.5 1 2 4 8]);
set(gca,'xminortick','off')
alpha(0.9);
hold off
end