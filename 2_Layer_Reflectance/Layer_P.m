function [Layer] = Layer_P(Photon,Tissue)
%% The function Layer_P  initializes the number of layers with their thickness and optical properties
% Inputs:
% Photon: Structure to photon variables
% Tissue: Structure to tissue variables

% Output:
% Layer: Structure to Layer parameters

% NOTE: These optical properties are taken from
% Bykov, A. V., et al. "Simulation of light propagation in highly scattering media mimicking biotissues: comparison of different algorithms." Fourth
% International Conference on Photonics and Imaging in Biology and Medicine. Vol. 6047. International Society for Optics and Photonics, 2006.
%%
if Photon.Layer == 1                                            % Check if the photon is 1st Layer
    Layer.sz0 = 0;                                              % Top layer
    Layer.sz1 = Tissue.d1;                                      % The thickness "d1" of first layer
    Layer.mu_a = 0.025;                                         % Absorption coefficient of first layer
    Layer.mu_s = 7.5;                                           % Scattering coefficient of first layer
    Layer.g = 0.8;                                              % Anisotropy coefficient (g) of first layer
% 
% elseif Photon.Layer == 2
% 
% 
%     Layer.sz0 = Tissue.d1;
%     Layer.sz1 =  Tissue.d1 + Tissue.d2;
%     Layer.mu_a = 0.016;
%     Layer.mu_s = 80;
%     Layer.g = 0.8;


else

    Layer.sz0 = Tissue.d1;                                      % The start of the second layer
    Layer.sz1 =  Tissue.d1 + Tissue.d2;                         % The thickness of second layer
    Layer.mu_a = 0.025;                                         % Absorption coefficient of second layer
    Layer.mu_s = 17.5;                                          % Scattering coefficient of second layer
    Layer.g = 0.8;                                              % Anisotropy coefficient (g) of first layer

end