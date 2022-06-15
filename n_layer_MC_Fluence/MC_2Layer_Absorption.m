clc
clear

tic

Bound.Nx = 600;
Bound.Ny = 600;                                                             % Dimension of the tissue 30 mm X 30 mm X 10 mm
Bound.Nz = 300;
Bound.Nr = 300;                                                             % The total index of Nr
Bound.Na = 30;                                                              % The total index angle of exiting photon

Bound.dx = 0.05;
Bound.dy = 0.05;                                                            % Spacing between grid lines 0.5 mm
Bound.dz = 0.05;
Bound.dr = 0.05;
Bound.da = pi/(2*Bound.Na);                                                 % Spacing between exiting angles (alpha)

Bound.x = zeros(1,600);
Bound.y = zeros(1,600);
Bound.z = zeros(1,250);                                                     % Initialize the x,y,z,r, and a (alpha) to zeros
Bound.r = zeros(1,300);
Bound.a = zeros(1,30);

Bound.xmin = 0;
Bound.xmax = 0;
Bound.ymin = 0;                                                             % Variable initialized to and are for storing min and max tissue dimensions 
Bound.ymax = 0;
Bound.zmin = 0;
Bound.zmax = 0;

Bound.x = ([0:Bound.Nx-1] - Bound.Nx/2)*Bound.dx;                           % The coordinates of x from -15 to 15 mm
Bound.y = ([0:Bound.Ny-1] - Bound.Ny/2)*Bound.dy;                           % The coordinates of y from -15 to 15 mm
Bound.z = ([0:Bound.Nz-1])* Bound.dz;                                       % The coordinates of z from 0 to 10 mm
Bound.r = ([0:Bound.Nr-1])*Bound.dr;                                        % The coordinates of r from 0 to 30 mm
Bound.a = ([0:Bound.Na-1])*Bound.da;                                        % The coordinates of angle a from 0 to pi/2

Bound.xmin = min(Bound.x);
Bound.xmax = max(Bound.x);
Bound.ymin = min(Bound.y);                                                   % Min and Max tissue length
Bound.ymax = max(Bound.y);
Bound.zmin = min(Bound.z);
Bound.zmax = max(Bound.z);


Tissue.RR = zeros(Bound.Na,Bound.Nr);                                      % Variable to score Diffuse Reflectance of photon
Tissue.TT = zeros(Bound.Na,Bound.Nr);                                      %  % Variable to score Transmittance pf photon
Tissue.Tr = 0;                                                             % Variable to score weights of Transmitting photon
Tissue.Rr = 0;                                                             % Variable to score weights of Diffusively reflected photon
Tissue.A_rz = zeros(Bound.Nz,Bound.Nr);                                    % Variable matrix to score Absorption inside the tissue

n = [1,1.37,1.43,1.33,1.37,1];                                                         % Row vector representing the refractive indexes of all the layers
 
Tissue.d1 = 3;                                                             % Tickness of first layer
Tissue.d2 = 5; 
Tissue.d3 = 2;  
Tissue.d4 = 5;                                                             % Tickness of second layer

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_photons = 5e4;                                                                       % Total Number of Photons for simulation
W = 0.0001;                                                                             % Threshold weight for Roulette

% [Bound,Tissue] = Two_Layer_Absorption_final(Bound,Tissue,n,n_photons,W);                % Main calling function to simulate the Monte Carlo
%
[Bound,Tissue] = Two_Layer_Absorption_final_mex(Bound,Tissue,n,n_photons,W);
% % Calculation

Absorbed_Total = sum(sum(Tissue.A_rz));                                    % Total weight absorbed inside the Tissue

Photon_Probab_A = Absorbed_Total/n_photons;                                % Probability of being absorbed by tissue

FF = (Tissue.A_rz');                                                       % Tranpose the matrix to make z as a column                                                                              

FF = sum(FF)/(Bound.dz*n_photons);                                         % Sum all the depth based absorption and convert it into fluence 
Fluence = FF;                                                        % Divide the whole fluence by absorption coefficient 

figure (21)
imagesc(Bound.r,Bound.z,log10(Tissue.A_rz))                                % Figure to display the absorption inside the medium
colorbar east
colormap(makec2f)                                                          % Colorbar function taken from OMLC.org


figure (15)
semilogy(Bound.z,(Fluence),'r')                                            % plot the fluence in z-axis (depth)

xlabel('z (cm)')

ylabel('Fluence')


toc
