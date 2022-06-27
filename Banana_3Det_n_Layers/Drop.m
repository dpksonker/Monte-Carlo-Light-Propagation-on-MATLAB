function [Photon,Tissue] = Drop(Photon,Tissue)
%% The function Drop calculates the amount of weight dropped and the remaining weight left with the photon

% Inputs:
% Photon: Structure to photon variables.
% Bound:  Structure to medium dimensions.
% Tissue: Structure to tissue variables.
% Output:
% Photon: The updated weight of photon

%%
[Layer] = Layer_P(Photon,Tissue);                                           % Call the layer function to get the current layer of photon


u_t =  Layer.mu_a + Layer.mu_s;
dwa = Photon.weight*(Layer.mu_a/u_t);                                      % Calculating the amount of weight to be dropped
Photon.weight = Photon.weight - dwa;                                       % amount of weight left after the drop

end
