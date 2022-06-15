clear all
clc

tic


Bound.Nx = 600;
Bound.Ny = 600;
Bound.Nz = 200;                                                            % Dimension of the tissue 
Bound.Nr = 200;

Bound.dx = 0.05;
Bound.dy = 0.05;                                                           % Spacing between grid lines 0.5 mm
Bound.dz = 0.05;
Bound.dr = 0.05;

Bound.x = zeros(1,600);
Bound.y = zeros(1,600);                                                    % Initialize the x,y,z,r to zeros
Bound.z = zeros(1,200);
Bound.r = zeros(1,200);

Bound.xmin = 0;
Bound.xmax = 0;                                                             % Variable initialized to and are for storing min and max tissue dimensions 
Bound.ymin = 0;
Bound.ymax = 0;
Bound.zmin = 0;
Bound.zmax = 0;

Bound.x = ([0:Bound.Nx-1] - Bound.Nx/2)*Bound.dx;
Bound.y = ([0:Bound.Ny-1] - Bound.Ny/2)*Bound.dy;                          % The coordinates of x,y,z,r
Bound.z = ([0:Bound.Nz-1])* Bound.dz;
Bound.r = ([1:Bound.Nr])* Bound.dr;

Bound.xmin = min(Bound.x);
Bound.xmax = max(Bound.x);
Bound.ymin = min(Bound.y);                                                 % Min and Max tissue length
Bound.ymax = max(Bound.y);
Bound.zmin = min(Bound.z);
Bound.zmax = max(Bound.z);

n = [1,1.4,1.4,1];                                                         % Row vector representing the refractive indexes of all the layers
Tissue.d1 = 5;                                                             % Tickness of first layer
Tissue.d2 = 5;                                                             % Tickness of second layer

Tissue.RR_dz = zeros(1,Bound.Nr-1);                                             % Variable to save diffuse -reflectance
            
Tissue.Tr = 0;                                                                  % Variable to save Transmitting weight of photons

       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_photons = 1e2;                                                                % Total Number of Photons to be simulated
W = 0.0001;                                                                     % Threshold weight for Roulette

[Bound,Tissue] = Two_Layer_DiffReflectance_final(Bound,Tissue,n,n_photons,W);       % Main calling function to simulate the Monte Carlo

for jj = 1:length(Bound.r)-1
    
    r_area(1,jj) = (Bound.r(1,jj+1) - Bound.r(1,jj))*(Bound.r(1,jj+1) + Bound.r(1,jj));    % CALCULATING THE AREA of each detector
end
A_shell = pi*r_area;                                                                       % shell area
Tissue.RR_dz_VV = Tissue.RR_dz./A_shell;                                                   % Dividing the diffuse reflectance with the area of the detector

xx_plot = ([1:Bound.Nr-1])* Bound.dr;                                           
zz_plot = Tissue.RR_dz_VV;
figure(14)

semilogy(xx_plot,zz_plot,'b')                                                              %  plot diffuse reflectance


%

