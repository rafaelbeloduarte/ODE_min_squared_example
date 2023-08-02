%{
This program is part of an example on how to fit the parameters of a system of ordinary differential equations on octave. This is the main script. It calls the minimizer to find the parameters using "f.m" as the objective. At the end the solution is plotted.
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

t_range = 0:0.01:6;

t_exp = [0
1
2
3
4
5
6];

% x_EG	x_12PDO	x_13PDO	x_G	x_S	x_I	x_M
x_exp = [0.00319405967940873	0.00115000920151936	0.00100554616685905	0.686869092252988	0.000341420115327106	0.00179131307316157	0
0.00164746168966925	0.00380478917780572	0.0014772555551388	0.676493129296004	0.000426603985522671	0.00831071357286639	0.000174004665326753
0.00435408264677295	0.0124775300589343	0.00460166905850865	0.638162863495403	0.00108735858928111	0.016942263801206	0.000646946165080168
0.00589579091204543	0.019092303031449	0.00506590213686923	0.606250894581066	0.00241640184469882	0.0308377822128105	0.00201749538678801
0.00992218399142204	0.043354883076482	0.00808372637740095	0.558821105504511	0.00347481766937655	0.0339635701478891	0.00376287564759685
0.00937843951006319	0.0423689731539057	0.00781953032911614	0.552794270844725	0.00473875896011334	0.043927190520503	0.00511481833480095
0.00891449586710536	0.0394945343091346	0.00879400824953602	0.533776665929079	0.00651928920190128	0.0545461053880125	0.00516357942031069];

  x_EG_exp = x_exp(:,1);
  x_12PDO_exp = x_exp(:,2);
  x_13PDO_exp = x_exp(:,3);
  x_G_exp = x_exp(:,4);
  x_S_exp = x_exp(:,5);
  x_I_exp = x_exp(:,6);
  x_M_exp = x_exp(:,7);

  x0 = [0.0001 0.0001 0.0001 0.686869092252988 0.0001  0.0001  0.0001];
  % starting guess
   p0 = zeros(7,1);
  % calling the minimizer
  % "fminsearch" begins at the point p0 and iterates using the Nelder & Mead Simplex algorithm (a derivative-free method). This algorithm is better-suited to functions which have discontinuities or for which a gradient-based search such as fminunc fails.
  %[xmin, fval]=fminsearch(@f,p0, optimset ("Display", "iter", "MaxFunEvals", 1e24, "MaxIter", 1e24, "TolFun", 1e-5))
  [param, fval]=fminunc(@(p0)f(p0, t_exp, x_exp, x0, t_range), p0)

  % The code below is just to solve the set of ODEs using the parameters found by "fminunc" and plot the solution.
  % Resolução das EDOs
  [t x] = ode15s(@(t, x)odes(t, x, param), t_range, x0);

  % x_EG	x_12PDO x_13PDO x_G x_S	x_I x_M
  x_EG = x(:,1);
  x_12PDO = x(:,2);
  x_13PDO = x(:,3);
  x_G = x(:,4);
  x_S = x(:,5);
  x_I = x(:,6);
  x_M = x(:,7);

line_width = 1;
font_size = 14;
figure(1);
clf;
# 1,2-PDO
c = [0 0.443 0.737];
plot(t, x_12PDO, 'linewidth', line_width, 'color', c);
hold on;
scatter(t_exp, x_12PDO_exp, 20*line_width, c, "+", 'linewidth', line_width);
hold on;
#1,3-PDO
c = [0.847 0.322 0.094];
plot(t, x_13PDO, 'linewidth', line_width, 'color', c);
hold on;
scatter(t_exp, x_13PDO_exp, 20*line_width, c, "o", 'linewidth', line_width);
hold on;
# EG
c = [0.925 0.690 0.122];
plot(t, x_EG, 'linewidth', line_width, 'color', c);
hold on;
scatter(t_exp, x_EG_exp, 20*line_width, c, "*", 'linewidth', line_width);
hold on;
# isobutil
c = [0.490 0.180 0.553];
plot(t, x_I, 'linewidth', line_width, 'color', c);
hold on;
scatter(t_exp, x_I_exp, 20*line_width, c, "^", 'linewidth', line_width);
hold on;
# methane
c = [0.463 0.671 0.184];
plot(t, x_M, 'linewidth', line_width, 'color', c);
hold on;
scatter(t_exp, x_M_exp, 20*line_width, c, "v", 'linewidth', line_width);
hold on;
# scopoletin
c = [0.298 0.741 0.929];
plot(t, x_S, 'linewidth', line_width, 'color', c);
hold on;
scatter(t_exp, x_S_exp, 20*line_width, c, "p", 'linewidth', line_width);
hold on;

xlabel ("time (h)");
ylabel ("Molar fraction");
title("285^oC");
set(gca, "linewidth", line_width, "fontsize", font_size, 'fontweight', "bold", "fontname", "Liberation Serif", "ylim", [-inf inf], "xlim", [-inf inf]);
legend('x_{1,2-PDO}', 'x_{1,2-PDO, exp}','x_{1,3-PDO}', 'x_{1,3-PDO, exp}', 'x_{EG}', 'x_{EG,exp}', 'x_{I}', 'x_{I, exp}', 'x_{CH_4}', 'x_{CH_4, exp}', 'x_{S}', 'x_{S, exp}', 'fontsize', 14, 'fontweight', "bold", "linewidth", line_width,  'location', "eastoutside", "fontname", "Liberation Serif", "numcolumns", 1);

figure(2);
clf;
plot(t, x_G, 'k', 'linewidth', line_width);
hold on;
scatter(t_exp, x_G_exp, 'k', 'linewidth', line_width);
hold on;
xlabel ("time (h)");
ylabel ("Molar fraction");
set(gca, "linewidth", line_width, "fontsize", font_size, 'fontweight', "bold", "fontname", "Liberation Serif", "ylim", [-inf inf], "xlim", [-inf inf]);
legend('x_{Glicerol}', 'x_{Glicerol, exp}', 'fontsize', font_size, 'location', "eastoutside");

