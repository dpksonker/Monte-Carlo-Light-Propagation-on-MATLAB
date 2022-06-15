function [Photon,Tissue] = Reflectance(Bound,Photon,Tissue)
%% The function Reflectance records the angle and coordinate in Reflectance matrix and also records weight of photon escaping the first layer

% Inputs:

% Bound:  Structure to medium dimensions and scoring variables
% Photon: Structure to photon variables
% Tissue: Structure to tissue variables

% Outputs:

% Tissue: Stores the weight of exiting photon and and also the photon
% exiting angle and coordinate
%%
Radius_det = Bound.r;                                                       % The radius of detector r axis with 0.05 as the distance between the detectors
r_photon  = sqrt((Photon.x)*(Photon.x) + (Photon.y)*(Photon.y));            % Calculate the distance of a photon from the detector

for ii=1:length(Radius_det)-1                                               % loop untill the length of radius of detector

    if Radius_det(1,ii) < r_photon  && r_photon <= Radius_det(1,ii+1)       % if the photon is inside the detector

        Tissue.RR_dz(1,ii) = Tissue.RR_dz(1,ii) + Photon.weight;            %  Save the weight of the current photon in RR_dz variable

    end

end


end


