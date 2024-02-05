%Vector generation test
% This file is a Matlab script that compares 2 different ways to generate a
% vector.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2, or (at your option)
% any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

clc;
L=10;
Ts=0.1;
fprintf('Sampling freq: %d Lenght: %d \n', Ts, L);

method1=[0:Ts:L-1]*Ts;
size_m1=size(method1);
size_m1=size_m1(2);
fprintf('Method1=[0:Ts:L-1], size: %d max: %d \n', size_m1, max(method1));


method2=[0:L-1]*Ts;
size_m2=size(method1);
size_m2=size_m2(2);
fprintf('Method2=[0:L-1]*Ts, size: %d max: %d \n', size_m2, max(method2));