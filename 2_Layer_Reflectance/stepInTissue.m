function [Photon] = stepInTissue(Tissue,Photon)
%% The function stepInTissue calculates the step size of photon

% Inputs:
% Photon: Structure to photon variables.
% Tissue: Structure to tissue variables.
% Output:
% Photon: The updated step-size of photons

%%
[Layer] = Layer_P(Photon,Tissue);                                          % Call the Layer function to get the current layer of photon
u_t = Layer.mu_a + Layer.mu_s;

if Photon.s_left == 0                                                      % Checks if step size is zero
    rn = rand();                                                           % generate random number
    Photon.s = -log(rn)/(u_t);                                             % Calculate the step size

else                                                                       % Checks if step size is not zero
    Photon.s = Photon.s_left/(u_t);                                        % calculate the step size from the left step size

    Photon.s_left = 0;                                                     % Make s_left to zero

end

end
