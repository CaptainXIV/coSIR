function y=Linear(x,x1,y1,x2,y2)
y=(x.*((y2-y1)/(x2-x1))+y2-x2*(y2-y1)/(x2-x1));
end
