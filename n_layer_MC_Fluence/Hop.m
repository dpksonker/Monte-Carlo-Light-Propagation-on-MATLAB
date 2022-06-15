function [Photon] = Hop(Photon)
%% The function Hop calculates the movement of photons inside the medium

% Inputs:
% Photon: Structure of photon variables. 
% Output:
% Photon: The updated position of photons

%% 
    
    Photon.x_old = Photon.x;
    Photon.y_old = Photon.y;                % Here the current position of photons are stored in the old variable
    Photon.z_old = Photon.z;
    
    Photon.x = Photon.x_old + Photon.s*Photon.ux;
    Photon.y = Photon.y_old + Photon.s*Photon.uy;      % Current position of photons
    Photon.z = Photon.z_old + Photon.s*Photon.uz;

end





