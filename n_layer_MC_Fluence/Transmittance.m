function [Photon,Tissue] = Transmittance(Bound,Photon,Tissue)
%% The function Transmittance records the angle and coordinate in transmitttance matrix and also records weight of photon escaping the last layer
% Inputs:
% Bound:  Structure to medium dimensions and scoring variables
% Photon: Structure to photon variables
% Tissue: Structure to tissue variables

% Outputs:
% Photon: Updated photon is dead
% Tissue: Stores the weight of exiting photon and and also the photon
% exiting angle and coordinate
%%

iad = round(acos(Photon.uz)/Bound.da);                                 % Calculate the exiting angle of photon and convert it into index
if iad > (Bound.Na - 1)                                                % Check if the converted index is in the bounds of the total index

    ia = Bound.Na - 1;                                                 % if not then take the last index

else
    ia = iad;                                                          % if yes then take the converted index

end

ird = round(sqrt(Photon.x*Photon.x + Photon.y*Photon.y)/Bound.dr);     % Calculate the coordinate of exiting photon and convert it into index

if ird > (Bound.Nr-1)                                                  % Check if the converted index is in the bounds of the total index

    ir = Bound.Nr-1;                                                   % if not then take the last index

else
    ir = ird;                                                          % if yes then take the converted index

end


Tissue.TT(ia+1,ir+1) = Tissue.TT(ia+1,ir+1) + Photon.weight;           % Transmittance stored as escaping angle of photon and coordinate
Tissue.Tr = Tissue.Tr + Photon.weight;                                 % store the weight of transmitting photon from last layer

end




