function [R_sp] = specularR(n)
%% The function specularR calculates the coeficient of reflection 

% Inputs:
% n: Refractive index row vector e.g. [n1 n2 n3 n1] where "n1 is air medium"
%
% Output:
% R_sp: Specular reflection coefficient
%%
r1 = n(1);                                                                 % Refractive index of current layer
r2 = n(2);                                                                 % Refractive of next layer where the photon is crossing

R_sp = ((r1 - r2)/(r1 + r2))*((r1 - r2)/(r1 + r2));                        % Calculate the specular reflectance
end