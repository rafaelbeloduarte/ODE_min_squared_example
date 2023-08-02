%{
This program is part of an example on how to fit the parameters of a system of ordinary differential equations on octave. This script defines the function that describes the set of ODEs.
Copyright (C) 2023  Rafael Belo Duarte

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

contact me at rafaelbeloduarte@pm.me
%}
function [dx] = odes(t, x, param)
  k1 = param(1);
  k2 = param(2);
  k3 = param(3);
  k4 = param(4);
  k5 = param(5);
  k6 = param(6);
  k7 = param(7);
  V_L = 0.06; % L
  V_G = 0.3 - V_L; % L
  m_T = 1.26*V_L*1000; % g
  MM_G = 92.094;
  MM_12P = 76.095;
  MM_13P = 76.095;
  MM_EG = 62.068;
  MM_I = 158.24;
  MM_M = 16;
  MM_S = 192.16;
  n_T = m_T/(x(2)*MM_12P + x(3)*MM_13P + x(1)*MM_EG + x(5)*MM_S + x(6)*MM_I + x(4)*MM_G + x(7)*MM_M);
  dx = zeros(7,1);
  dx(1) = (V_L/n_T)*k1*x(4); % EG
  dx(2) = (V_L/n_T)*k2*x(4); % 12PDO
  dx(3) = (V_L/n_T)*k3*x(4); % 13PDO
  dx(4) = -(V_L/n_T)*k4*x(4); % G
  dx(5) = (V_L/n_T)*k5*x(4); % S
  dx(6) = (V_L/n_T)*k6*x(4); % I
  dx(7) = (V_G/n_T)*k7*x(4); % M
end
