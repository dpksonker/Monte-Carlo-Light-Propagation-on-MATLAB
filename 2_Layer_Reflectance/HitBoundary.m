function [Photon,hit] = HitBoundary(Photon,Tissue)
%% The function HitBoundary calculates the distance of boundary from the current position of photons
%  if the photon is hitting the boundary then it will return hit = 1 otherwise hit = 0

% Inputs:
% Photon: Structure of photon variables.
% Tissue:  Structure of tissue variables.
% Output:
% Photon: Structure containing all the variables that photon carries.
% hit: The Boolean to get if the photon is hitting or not.
%%
[Layer] = Layer_P(Photon,Tissue);                                          % Call the Layer function to get the layer of current photon

if Photon.uz < 0                                                           % Checking if the direction of photon in -ve z drection

    d_b = (Layer.sz0 - Photon.z)/Photon.uz;                                % calculating the distance to the boundary


elseif Photon.uz > 0                                                       % Checking if the direction of photon in +ve z drection

    d_b = (Layer.sz1 - Photon.z)/Photon.uz;                                % calculating the distance to the boundary

else

    d_b = 0;

end

if Photon.uz ~= 0 && Photon.s > d_b                                        % checking if photon direction in 'z' is not zero and step size .....
                                                                           % is greater than the distance to the boundary

    u_t = Layer.mu_a + Layer.mu_s;                                         % Calculate the attenuation coefficient of current layer

    Photon.s_left = (Photon.s - d_b)*u_t;                                  % Keeping the extra length in the s_left

    Photon.s = d_b;

    hit = 1;                                                               % Make hit = 1 because of hitting the boundary

else

    hit = 0;                                                               % Otherwise make Hit = 0 because not hitting the boundary

end
end
