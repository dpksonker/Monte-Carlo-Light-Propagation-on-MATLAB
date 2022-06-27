clc 
clear

tic

Bound.Nx = 1800;
Bound.Ny = 1800;                                                             % Dimension of the tissue
Bound.Nz = 500;
Bound.Nr = 900;

Bound.dx = 0.05;
Bound.dy = 0.05;                                                            % Spacing between grid lines 0.5 mm
Bound.dz = 0.05;
Bound.dr = 0.05;

Bound.x = zeros(1,1800);
Bound.y = zeros(1,1800);                                                     % Initialize the x,y,z,r to zeros
Bound.z = zeros(1,500);
Bound.r = zeros(1,900);

Bound.xmin = 0;
Bound.xmax = 0;
Bound.ymin = 0;
Bound.ymax = 0;                                                                     % Variable initialized to and are for storing min and max tissue dimensions
Bound.zmin = 0;
Bound.zmax = 0;

Bound.x = ([0:Bound.Nx-1] - Bound.Nx/2)*Bound.dx;
Bound.y = ([0:Bound.Ny-1] - Bound.Ny/2)*Bound.dy;                                                 % The coordinates of x [-x:x]
Bound.z = ([0:Bound.Nz-1])* Bound.dz;
Bound.r = ([0:Bound.Nr-1])* Bound.dr;

Bound.xmin = min(Bound.x);
Bound.xmax = max(Bound.x);
Bound.ymin = min(Bound.x);                                                    % Min and Max tissue length
Bound.ymax = max(Bound.y);
Bound.zmin = min(Bound.z);
Bound.zmax = max(Bound.z);

Radius_det = 0.15;                                                                    % Radius of the detector

Tissue.D1 = 0;
Tissue.D1 = (Bound.Nr/2.25)*Bound.dr;                                               % Distance of D1 from source

Tissue.D2 = 0;
Tissue.D2 = (Bound.Nr/1.5)*Bound.dr;                                                % Distance of D2 from source

Tissue.D3 = 0;
Tissue.D3 = (Bound.Nr/1.125)*Bound.dr;                                              % Distance of D3 from source

Tissue.count_D1 = 0;
Tissue.count_D2 = 0;                                                                  % Counter to count number of photons reached the detector
Tissue.count_D3 = 0;

n = [1,1.37,1.43,1.33,1.37,1];                                                         % Row vector representing the refractive indexes of all the layers
Tissue.d1 = 3;                                                             % Tickness of first layer
Tissue.d2 = 7; 
Tissue.d3 = 3;  
Tissue.d4 = 12;                                                             % Tickness of second layer

Tissue.Tr = 0;

Tissue.S_Map = zeros(Bound.Nz,Bound.Nr);                                                 % Variable matrix to store photon trajectories
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_photons = 1e5;                                                                      % Total number of Photons to be simulated
W = 0.0001;                                                                           % Threshold weight for Roulette

% [Bound,Tissue] = n_LAYER_Banana_traj_3Det(Bound,Tissue,n,Radius_det,n_photons,W);               % Main calling function to simulate the Monte Carlo
[Bound,Tissue] = n_LAYER_Banana_traj_3Det_mex(Bound,Tissue,n,Radius_det,n_photons,W);

figure(14)
    
imagesc(Bound.r,Bound.z,log10(Tissue.S_Map))                                            % For plotting the image of banana trajectories  

colormap jet

hold on

% Down code is for creating the ellipse in the banana trajectory plot
        
b = 0.5*16e-3;                                                             % Major axis of ellipse                                           
a = 0.5*3e-3;                                                              % Minor axis of ellipse    

T = 0:pi/180:2*pi;                                                         % Sampling the theta of ellipse
%
r = a*b./sqrt(a^2*sin(T).*sin(T) + b^2*cos(T).*cos(T));                    % Calculating the r for ellipse (the equation is in polar form)      

x = 15e-3+r.*cos(T);                                                       % shift the ellipse 15 mm in x 
y = 14e-3+r.*sin(T);                                                       % shift the ellipse 14 mm in y

            
figure(14)   
fill(x*1e3,y*1e3,'k','FaceColor','r','FaceAlpha',0.2,'EdgeAlpha',0 )       % Plot the ellipse

xlim([0 45])
ylim([0 25])                                                                      % Limit the x and y axis
% zlim([-9.5 9.5])

ax = gca;
ax.YDir = 'reverse';




















toc