function [Bound,Tissue] = Two_Layer_Absorption_final(Bound,Tissue,n,n_photons,W)
%% The function Monte_Carlo_Absorption is the main Monte Carlo simulation function it calculates the absorption of photon inside the medium
    
% Inputs:

% Bound     : Structure to tissue dimensions
% Tissue    : Structure to tissue variables
% n         : Row matrix of the refractive indexes of all the layers
% n_photons : Total number of photons to be simulated
% W         : threshold for minimum weight of the photon while in simulatio
%             simulation

% Outputs:
% Bound   : Structure to tissue dimensions
% Tissue  : Structure to updated A(r,z) absorption variable
%%    
for np=1:n_photons                                                              % Main loop to simulate the number of photons

    r_sp = specularR(n);                                                        % Specular Reflection
    [Photon] = LaunchPhoton(r_sp);                                              % Launch Photon
    count_photon = 0;                                                           % Variable to count
    while (Photon.dead == false)                                                % Traverse Photon till it is not dead
        count_photon = count_photon + 1;                                        % Count varible to count the number of times the single photon is inside the medium        

        [Photon] = stepInTissue(Tissue,Photon);                                 % Define step by a random no

        [Photon,hit] = HitBoundary(Photon,Tissue);                              % Check for the boundary hitting

        if  hit == 1                                                            % if hitting

            [Photon] = Hop(Photon);                                             % Move the photon to the boundary

            if  (Bound.xmin <= Photon.x && Photon.x <= Bound.xmax) && ...       % Make a check if photon is still inside the medium
                    (Bound.ymin <= Photon.y && Photon.y <= Bound.ymax)


                if Photon.uz < 0                                               % Check if the photon is at upper boundary

                    [Photon,Tissue] = CrossUP(Tissue,Photon,Bound,n);          % Calculate the fate of photon if its reflected, or out of the medium or traveled to next medium

                else                                                           % Otherwise the photon is crossing the lower boundary

                    [Photon,Tissue] = CrossDOWN(Tissue,Photon,Bound,n);        % Calculate the fate of photon if its reflected, or out of the medium or traveled to next medium
                end

            else
                Photon.dead = true;                                            % Make photon dead
            end

        else

            [Photon] = Hop(Photon);                                                 % if not hitting the boundary then move the photon

            if  (Bound.xmin <= Photon.x && Photon.x <= Bound.xmax) && ...         % Make a check if photon is still inside the medium
                    (Bound.ymin <= Photon.y && Photon.y <= Bound.ymax)

                [Photon,Tissue] = Drop(Photon,Bound,Tissue);                       % Drop weight as absorbance at a new location
                [Photon] = Spin(Photon,Tissue);                                    % Scatter photon to a new locatio
            else
                Photon.dead = true;                                                % Make photon dead                                      

            end

            if  Photon.weight < W  &&  Photon.dead == false || count_photon > 1e4   % Check for photon weight or if it is dead or it has been in a medium > 1e4 
                                                                                                 % then make it to face the Roulette

                Photon.dead = true;                                                  % Roulette
            end
        end
    end
end

end

