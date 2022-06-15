function [Photon,Tissue] = CrossDOWN(Tissue,Photon,Bound,n)
%% The function CrossDOWN calculates the fate of photon if it crosses the +ve z direction layer (the +ve z direction is the downward direction)
%  this function calculates if "the photon is reflected" or "is went out of top most layer" or "it travelled to the next layer".  

% Inputs:
% Tissue: Structure to tissue variables.
% Photon: Structure to photon variables.
% Bound:  Structure to medium dimensions.
% n:      The row vector of refractive indexes of all the layers
% Output:
% Photon: The updated direction of photon or photon is dead
% Tissue: saved weight of photon which went out of the medium
%%
 layer = Photon.Layer;                                                     % Call the current layer of photon
 
 n_i = n(layer+1);                                                         % Calculate the refractive index of the current layer
 n_t = n(layer+2);                                                         % Calculate the refractive index of the next layer where the photon is going
 
 [Ref] = Rfresnel(Photon,n_i,n_t);                                         % Call the function Rfresnel to calculate the reflection coefficient
 
 ee = rand();                                                              % Generate the random number
 
 if ee <= Ref || Ref == 1                                                  % Check for reflection at boundary
     
     Photon.uz = -Photon.uz;                                               % if reflected then just change the direction of photon
     
 else                                                                      % Otherwise
        
     if Photon.Layer == length(n)-2                                                  % Check if the photon is at top-most layer          
         
         [Photon,Tissue] = Transmittance(Bound,Photon,Tissue);             % Then call the function to check for Transmittance from last layer

            Photon.dead = true;                                            % Make photon dead
            
     else                                                                  % Otherwise
        uux = Photon.ux;
        uuy = Photon.uy;                                                   % Store the Direction in new variables
        uuz = Photon.uz;
        
        a_t = acos(abs(uuz));                                              % Calculate the angle of incidence
        
        Photon.Layer = Photon.Layer + 1;                                   % Increase the layer of photon by one

        Photon.ux = uux*(n_i/n_t);
        Photon.uy = uuy*(n_i/n_t);                                         % Calculate the new direction of photon in another layer it entered
        Photon.uz = sign(uuz)*cos(a_t);
        
    end
end