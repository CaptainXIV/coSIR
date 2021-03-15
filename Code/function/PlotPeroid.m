function h=PlotPeroid(m)
% plot the epidemic dynamics details
maxx=500;
draw_list=[1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1];
%          S  i1 i2 d1 d2 a1 a2 r1 r2 t1 t2 H1 H2 E1 E2 V1 V2 H  E  C1 C2 R
draw_list=[draw_list,0,0,0,0,0,1];
%                    i d a r t I
m(m<0)=0;
h=figure();
leg={};
hold on;
color=['#9970ab';'#5aae61';'#bf812d';'#e08214';'#4393c3';'#878787';'#35978f'];
if draw_list(1)
    plot(m(:,1),'Color',color(5,:),'LineWidth',1);
    leg=[leg,'S'];
end
if draw_list(2)
    plot(m(:,2));
    leg=[leg,'I1'];
end
if draw_list(3)
    plot(m(:,7));
    leg=[leg,'I2'];
end
if draw_list(4)
    plot(m(:,3));
    leg=[leg,'D1'];
end
if draw_list(5)
    plot(m(:,8));
    leg=[leg,'D2'];
end
if draw_list(6)
    plot(m(:,4));
    leg=[leg,'A1'];
end
if draw_list(7)
    plot(m(:,9));
    leg=[leg,'A2'];
end
if draw_list(8)
    plot(m(:,5));
    leg=[leg,'R1'];
end
if draw_list(9)
    plot(m(:,10));
    leg=[leg,'R2'];
end
if draw_list(10)
    plot(m(:,6));
    leg=[leg,'T1'];
end
if draw_list(11)
    plot(m(:,11));
    leg=[leg,'T2'];
end
if draw_list(12)
    plot(m(:,12));
    leg=[leg,'H1'];
end
if draw_list(13)
    plot(m(:,13));
    leg=[leg,'H2'];
end
if draw_list(14)
    plot(m(:,14));
    leg=[leg,'E1'];
end
if draw_list(15)
    plot(m(:,15));
    leg=[leg,'E2'];
end
if draw_list(16)
    plot(sum(m(:,2:6),2),'--','Color',color(2,:),'LineWidth',1);
    leg=[leg,'I1'];
end
if draw_list(17)
    plot(sum(m(:,7:11),2),'--','Color',color(4,:),'LineWidth',1);
    leg=[leg,'I2'];
end
if draw_list(18)
    plot(1:length(m(:,12)),sum(m(:,12:13),2))
    leg=[leg,'H'];
end
if draw_list(19)
    plot(sum(m(:,14:15),2),'Color',color(6,:),'LineWidth',1);
    leg=[leg,'E'];
end
if draw_list(20)
    plot(sum([m(:,12),m(:,14)],2));
    leg=[leg,'C1'];
end
if draw_list(21)
    plot(sum([m(:,13),m(:,15)],2));
    leg=[leg,'C2'];
end
if draw_list(22)
    plot(sum(m(:,12:15),2),'Color',color(1,:),'LineWidth',1);
    leg=[leg,'R'];
end
if draw_list(23)
    plot(m(:,2)+m(:,7));
    leg=[leg,'i'];
end
if draw_list(24)
    plot(m(:,3)+m(:,8));
    leg=[leg,'d'];
end
if draw_list(25)
    plot(m(:,4)+m(:,9));
    leg=[leg,'a'];
end
if draw_list(26)
    plot(m(:,5)+m(:,10));
    leg=[leg,'r'];
end
if draw_list(27)
    plot(m(:,6)+m(:,11));
    leg=[leg,'t'];
end
if draw_list(28)
    plot(sum(m(:,2:11),2),'Color',color(7,:),'LineWidth',1);
    leg=[leg,'I'];
end
hold off;
legend(leg);
xlim([0,maxx]);
end