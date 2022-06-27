function [Photon,Tissue,SM] = Hop(Photon,Bound,Tissue,SM)
%% The function Hop calculates the movement of photons inside the medium and aslo saves the trajectories of current photon

% Inputs:
% Photon: Structure of photon variables.
% Bound:  Structure of tissue dimension variables.
% Tissue:  Structure of tissue variables.
% SM:     Temporary variable to store the current photon trajectories
% Output:
% Photon: The updated position of photons
% Tissue:  Structure of tissue variables.
% SM:     The updated trajectories of photon

%%
Photon.x_old = Photon.x;
Photon.y_old = Photon.y;                                                   % Here the current position of photons are stored in the old variable
Photon.z_old = Photon.z;

Photon.x = Photon.x_old + Photon.s*Photon.ux;
Photon.y = Photon.y_old + Photon.s*Photon.uy;                              % Current position of photons
Photon.z = Photon.z_old + Photon.s*Photon.uz;


izd = round(Photon.z/Bound.dz);                                            % Calculate the index of photon in z
if izd > (Bound.Nz-1)                                                      % Check if the converted index is in the bounds of the total index

    iz = Bound.Nz-1;                                                       % if not then take the last index

else
    iz = izd;                                                              % if yes then take the converted index

end

ird = round(sqrt(Photon.x*Photon.x + Photon.y*Photon.y)/Bound.dr);         % Calculate the coordinate of exiting photon and convert it into index

if ird > (Bound.Nr-1)                                                      % Check if the converted index is in the bounds of the total index

    ir = Bound.Nr-1;                                                       % if not then take the last index

else
    ir = ird;                                                              % if yes then take the converted index

end

SM(iz+1,ir+1) = SM(iz+1,ir+1) + 1;                                         % SM variable tracks the position of photon by placing 1 to the current position in SM(z,r)
end






