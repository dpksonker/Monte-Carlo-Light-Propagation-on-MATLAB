function [Photon,Tissue] = Drop(Photon,Bound,Tissue)
%% The function Drop calculates the amount of weight dropped and the remaining weight left with the photon

% Inputs:
% Photon: Structure to photon variables.
% Bound:  Structure to medium dimensions.
% Tissue: Structure to tissue variables.
% Output:
% Photon: The updated weight of photon
% Tissue: Updated A(r,z) absorption matrix
%%
[Layer] = Layer_P(Photon,Tissue);                                          % Call the layer function to get the current layer of photon

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

u_t =  Layer.mu_a + Layer.mu_s;
dwa = Photon.weight*(Layer.mu_a/u_t);                                      % Calculating the amount of weight to be dropped
Photon.weight = Photon.weight - dwa;                                       % amount of weight left after the drop

Tissue.A_rz(iz+1,ir+1) = Tissue.A_rz(iz+1,ir+1) + (dwa/Layer.mu_a);                     % Drop the weight of photon in the A(r,z) matrix for fluence distribution
end
