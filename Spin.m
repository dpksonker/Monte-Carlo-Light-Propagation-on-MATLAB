function [Photon] = Spin(Photon,Tissue)
%% The function Spin chooses a new direction for photon propagation 

% Inputs:
% Photon: Structure to photon variables.
% Tissue: Structure to tissue variables.
% Output:
% Photon: The updated direction of photon
%%

[Layer] = Layer_P(Photon,Tissue);                                          % Call the Layer function 
gg = Layer.g;                                                              % Get the anisotropy of the present layer

Photon.ux_old = Photon.ux;
Photon.uy_old = Photon.uy;                                                 % Initialize the direction to the old variables in Photon structure
Photon.uz_old = Photon.uz;

ux_old = Photon.ux;
uy_old = Photon.uy;                                                        % Initialize the direction to the old variables
uz_old = Photon.uz;

if gg == 0                                                                 % Check if g is 0
    
    theta = acos(2*rand() - 1);                                            % Calculate theta using random number
    
else
    
    temp1 = (1 - gg*gg)/(1 - gg + 2*gg*rand());
    theta = acos((1/(2*gg))*((1+gg*gg) - temp1*temp1));                    % Calculate theta using Henyey-Greenstein function
    
end

psi = 2*pi*rand();                                                         % Calculate phi using random number

temp = sqrt(1 - uz_old*uz_old);                                            % temporary variable to store sqrt(1 - z^2)

if abs(uz_old) > 0.99999                                                   % Checks if photon is travelling parallel to z axis
    
    Photon.ux = sin(theta)*cos(psi);
    Photon.uy = sin(theta)*sin(psi);                                       % if parallel then calculate the new direction
    Photon.uz = sign(uz_old)*cos(theta);
    
else                                                                       % Otherwise calculate the new direction
    
    AAx = (ux_old*uz_old/temp)*sin(theta)*cos(psi);
    BBx = (uy_old/temp)*sin(theta)*sin(psi);
    CCx = ux_old*cos(theta);
    
    
    Photon.ux = AAx - BBx + CCx;                                           % new direction of photon in x
    
      
    AAy = (uy_old*uz_old/temp)*sin(theta)*cos(psi);
    BBy = (ux_old/temp)*sin(theta)*sin(psi);
    CCy = uy_old*cos(theta);
    
    Photon.uy = AAy + BBy + CCy;                                           % new direction of photon in y
    
    AAz = temp*sin(theta)*cos(psi);
    BBz = uz_old*cos(theta);
    
    Photon.uz = -AAz + BBz;                                                % new direction of photon in z
    
end

end
