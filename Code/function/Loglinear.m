function y=Loglinear(x,x1,y1,x2,y2)
y2=log2(y2);
y1=log2(y1);
y=2.^(x.*((y2-y1)/(x2-x1))+y2-x2*(y2-y1)/(x2-x1));
end