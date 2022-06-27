function [Bound,Tissue] = n_LAYER_Banana_traj_3Det(Bound,Tissue,n,Radius_det,n_photons,W)
%% The function Banana_traj is the main Monte Carlo simulation function it tracks the trajectories of the photons that are detected by the detector

% Inputs:
% Bound     : Structure to tissue dimensions
% Tissue    : Structure to tissue variables
% n         : Row matrix of the refractive indexes of all the layers
% Radius_det: Radius of the detectors
% n_photons : Total number of photons to be simulated
% W         : threshold for minimum weight of the photon while in simulation

% Outputs:
% Bound   : Structure to tissue dimensions
% Tissue  : Structure to updated tissue variables and containes the
% trajectories of photons
%%
for np=1:n_photons                                                          % Main loop to simulate the number of photons

    r_sp = specularR(n);                                                    % Specular Reflection
    [Photon] = LaunchPhoton(r_sp);                                   % Launch Photon

    count_photon = 0;                                                       % counter to count
    SM = zeros(500,900);                                                    % Temporary variable to store the trajectories of photons

    while (Photon.dead == false)                                            % Traverse Photon till it is not dead
        count_photon = count_photon + 1;                                    % Count varible to count the number of times the single photon is inside the medium

        [Photon] = stepInTissue(Tissue,Photon);                             % Define step by a random no.

        [Photon,hit] = HitBoundary(Photon,Tissue);                           % Check for the boundary hitting

        if  hit == 1                                                        % if hitting

            [Photon,Tissue,SM] = Hop(Photon,Bound,Tissue,SM);                                         % Move the photon to the boundary

            if  (Bound.xmin <= Photon.x && Photon.x <= Bound.xmax) && ...
                    (Bound.ymin <= Photon.y && Photon.y <= Bound.ymax)                                % Make a check if photon is still inside the medium


                if Photon.uz < 0                                                                      % If the photon is at upper boundary

                    [Photon,Tissue] = CrossUP(Tissue,Photon,n,Radius_det,SM);                         % Calculate the fate of photon if its reflected, or out of the medium or traveled to next medium

                else                                                                                  % Otherwise the photon is crossing the lower boundary

                    [Photon,Tissue] = CrossDOWN(Tissue,Photon,n);                                     % Calculate the fate of photon if its reflected, or out of the medium or traveled to next medium
                end

            else
                Photon.dead = true;                                                                    % Make photon dead
            end

        else

            [Photon,Tissue,SM] = Hop(Photon,Bound,Tissue,SM);                                           % if not hitting the boundary then move the photon

            if  (Bound.xmin <= Photon.x && Photon.x <= Bound.xmax) && ...                               % Make a check if photon is still inside the medium
                    (Bound.ymin <= Photon.y && Photon.y <= Bound.ymax)

                [Photon,Tissue] = Drop(Photon,Tissue);                                                          % Drop weight as absorbance at a new location
                [Photon] = Spin(Photon,Tissue);                                                         %    Scatter photon to a new locatio

            else
                Photon.dead = true ;                                                                    % Make photon dead

            end

            if  Photon.weight < W  &&  Photon.dead == false || count_photon > 1e4                 % Check for photon weight or if it is dead or it has been in a medium > 1e4
                % then make it to face the Roulette

                Photon.dead = true;                                                  % Roulette
            end
        end
    end
end

end



