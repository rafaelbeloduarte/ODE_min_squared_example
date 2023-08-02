%{
This program is part of an example on how to fit the parameters of a system of ordinary differential equations on octave. This file defines the objective function (calculates the squared differences between calculated and experimental values).
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
function Y = f(param, t_exp, x_exp, x0, t_range)

  x_EG_exp = x_exp(:,1);
  x_12PDO_exp = x_exp(:,2);
  x_13PDO_exp = x_exp(:,3);
  x_G_exp = x_exp(:,4);
  x_S_exp = x_exp(:,5);
  x_I_exp = x_exp(:,6);
  x_M_exp = x_exp(:,7);

  [t x] = ode15s(@(t, x)odes(t, x, param), t_range, x0);

  x_EG = x(:,1);
  x_12PDO = x(:,2);
  x_13PDO = x(:,3);
  x_G = x(:,4);
  x_S = x(:,5);
  x_I = x(:,6);
  x_M = x(:,7);

  squared_diff_sum = 0;

  for i = 1:1:length(t_exp)
    for j = 1:1:length(t_range)
      if t_exp(i) == t_range(j)
        % FFA	ALC	HDO	DCOx	ALD
          squared_diff_sum = squared_diff_sum + real((x_EG(j) - x_EG_exp(i))^2 + (x_12PDO(j) - x_12PDO_exp(i))^2 + (x_13PDO(j) - x_13PDO_exp(i))^2 + (x_G(j) - x_G_exp(i))^2 + (x_S(j) - x_S_exp(i))^2 + (x_I(j) - x_I_exp(i))^2 + (x_M(j) - x_M_exp(i))^2);
      endif
    endfor
  endfor
  Y = squared_diff_sum
endfunction
