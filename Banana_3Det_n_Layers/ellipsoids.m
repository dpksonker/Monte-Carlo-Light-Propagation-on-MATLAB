clear
clc

% 
% a = 0.5*19e-3;
% % b = 0.5*19e-3;
% b = 0.5*2.66e-3;
% c = 0.5*2.66e-3;
% 
% 
% theta = 0:pi/180:2*pi;
% 
% %
% [T,P] = meshgrid(theta);
% %
% 
% 
% r = a*c./sqrt(c^2*sin(T).*sin(T) + a^2*cos(T).*cos(T));
% 
% x =  r.*sin(T).*cos(P);
% y = r.*sin(T).*sin(P);
% z = r.*cos(T);
% 
% figure(10)
% % % contour(x,y,z);
% surf((x)*1e3,y*1e3,(z)*1e3, 'FaceColor','b','FaceAlpha',0.5 ,'linestyle','none')
% % 
% % material shiny;
% axis on;
% % camlight('headlight');
% colormap hot
% set(gca,'DataAspectRatio',[1 1 1])
% xlim([-9.5 9.5])
% ylim([-9.5 9.5])
% zlim([-9.5 9.5])

% X = (-9.5:0.1:9.5)*1e-3;
% Y = (-1.33:0.1:1.33)*1e-3;
% % % z = (-1.33:0.1:1.33)*1e-3;

b = 0.5*16e-3;
a = 0.5*3e-3;

T = 0:pi/180:2*pi;
%


r = a*b./sqrt(a^2*sin(T).*sin(T) + b^2*cos(T).*cos(T));

x = 15e-3+r.*cos(T);
y = 14e-3+r.*sin(T);

            
figure(90)   
% fill(x*1e3,y*1e3,'r')
fill(x*1e3,y*1e3,'k','FaceColor','k','FaceAlpha',0.5,'EdgeAlpha',0 )
% 
xlim([0 30])
ylim([0 25])
% zlim([-9.5 9.5])

ax = gca;
ax.YDir = 'reverse';
saveas(gcf,sprintf('focus_0.5MHz.fig'))


