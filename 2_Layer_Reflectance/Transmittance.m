function [Photon,Tissue] = Transmittance(Photon,Tissue)
%% The function Transmittance records the angle and coordinate in transmitttance matrix and also records weight of photon escaping the last layer
% Inputs:

% Photon: Structure to photon variables
% Tissue: Structure to tissue variables

% Outputs:
% Photon: Updated photon is dead
% Tissue: Stores the weight of exiting photon in Tissue.Tr variable
%%
Tissue.Tr = Tissue.Tr + Photon.weight;                                      % store the weight of transmitting photon from last layer
end




