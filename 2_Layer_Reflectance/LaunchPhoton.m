function [Photon] = LaunchPhoton(R_specular)
%% The function LaunchPhoton  initializes all the variables in Photon structure that photon carries with itself throughout the simulation
 
% Inputs:
% R_specular: The coefficient of specular reflection 

% Output:
% Photon: Structure containing all the variables that photon carries
%%
Photon.x = 0;
Photon.y = 0;                                       % Variables to store current Coordinates
Photon.z = 0;

Photon.x_old = 0;
Photon.y_old = 0;                                   % Variables to store previous Coordinates
Photon.z_old = 0;

Photon.ux_old = 0;
Photon.uy_old = 0;                                  % Variables to store previous Direction
Photon.uz_old = 0;

Photon.ux = 0;
Photon.uy = 0;                                      % Variables to store previous Direction
Photon.uz = 1;

Photon.weight = 1 - R_specular;                     % Reduction of weight due to specular reflection
Photon.dead = false;                                % Initialized Photon is not dead
Photon.s = 0;                                       % Step size
Photon.s_left = 0;                                  % Step size i.e. left after the photon travels to the boundary

Photon.Layer = 1;                                   % Initialize the layer of photon 
                                                    % NOTE: The photon is initialized to layer 1 because I have considered layer 0 as air         
                                                    % and layer (n+1) as air (where n is total number of layers)           
                                                    
end
