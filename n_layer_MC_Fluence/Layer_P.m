function [Layer] = Layer_P(Photon,Tissue)
%% The function Layer_P  initializes the number of layers with their thickness and optical properties
% Inputs:
% Photon: Structure to photon variables
% Tissue: Structure to tissue variables

% Output:
% Layer: Structure to Layer parameters
%%
if Photon.Layer == 1                                                       % Check if the photon is 1st Layer
    Layer.sz0 = 0;                                                         % Top layer Scalp
    Layer.sz1 = Tissue.d1;                                                 % The thickness "d1" of first layer
    Layer.mu_a = 0.0375;                                                    % Absorption coefficient of first layer
    Layer.mu_s = 9.5;                                                       % Scattering coefficient of first layer
    Layer.g = 0.81;                                                         % Anisotropy coefficient (g) of first layer


elseif Photon.Layer == 2                                                    % layer Skull

    Layer.sz0 = Tissue.d1;
    Layer.sz1 =  Tissue.d1 + Tissue.d2;
    Layer.mu_a = 0.028;
    Layer.mu_s = 27;
    Layer.g = 0.94;

% 
elseif Photon.Layer == 3                                                    % layer CSF

    Layer.sz0 = Tissue.d1 + Tissue.d2;
    Layer.sz1 = Tissue.d1 + Tissue.d2 + Tissue.d3;
    Layer.mu_a = 0.00433;
    Layer.mu_s = 0.0158;
    Layer.g = 0.9;
% 
else
    Layer.sz0 = Tissue.d1 + Tissue.d2 + Tissue.d3;                                                % The start of the second layer
    Layer.sz1 =  Tissue.d1 + Tissue.d2 + Tissue.d3 + Tissue.d4;                                    % The thickness of second layer
    Layer.mu_a = 0.035;                                                    % Absorption coefficient of second layer
    Layer.mu_s = 8.5;                                                     % Scattering coefficient of second layer
    Layer.g = 0.9;                                                         % Anisotropy coefficient (g) of first layer

end