function [Photon,Tissue] = Reflectance(Photon,Tissue,Radius_det,SM)
%% The function Reflectance records trajectory of photon that is detected by the detector
% Inputs:
% Photon: Structure to photon variables
% Tissue: Structure to tissue variables
% Radius_det: Radius of the detector
% SM: temporary variable that stores the trajectories of photon

% Outputs:
% Photon: Updated photon is dead
% Tissue: Stores the trajectory of photon for banana shape image for all
% the detectors
%%
D1 = Tissue.D1;                                                             % distance of detector D1 from source    

r_p1  = sqrt((Photon.x - D1)*(Photon.x - D1) + (Photon.y)*(Photon.y));      % Calculate the distance of a photon from the detector

if  r_p1 <= Radius_det                                                      % Check if the photon is inside the detector 
    
    Tissue.count_D1 = Tissue.count_D1 + 1;                                  % Counter to count the number of photons detected by D1
    Tissue.S_Map = Tissue.S_Map + SM;                                       % Take the trajectories of the detected photon and save it to new variable  Tissue.S_Map
end

D2 = Tissue.D2;                                                             % distance of detector D2 from source  
    
r_p2  = sqrt((Photon.x - D2)*(Photon.x - D2) + (Photon.y)*(Photon.y));

if  r_p2 <= Radius_det
    
    Tissue.count_D2 = Tissue.count_D2 + 1;
    Tissue.S_Map = Tissue.S_Map + SM;
end

D3 = Tissue.D3;                                                              % distance of detector D3 from source  

r_p3  = sqrt((Photon.x - D3)*(Photon.x - D3) + (Photon.y)*(Photon.y));

if  r_p3 <= Radius_det
    
    Tissue.count_D3 = Tissue.count_D3 + 1;
    Tissue.S_Map = Tissue.S_Map + SM;
end

end


