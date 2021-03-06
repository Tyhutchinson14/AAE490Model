function [ volume_batt, num_series, num_parallel, total_cells ] = volBattery(V_batt, P_elec_total, t_flight)
%
% Description: 
%   Calculate the volume of the resultant battery system based on the
%   previously calculated capacity
%
% Inputs:
%   V_batt - voltage of the battery that is needed
%   P_elec_total - total electric power required
%   t_flight - time the UMASS is in flight
%
% Outputs:
%   volume_batt - volume of the resultant battery system
%   num_series - number of battery cells in series from resulting configuration
%   num_parallel - number of (battery cell blocks in series) in parallel from resulting configuration
%   total_cells - totall number of battery cells in resulting configuration

cap_batt = 3; %AH
E_req = P_elec_total * t_flight * 60; % [W]*[hr]* 3600[s/hr] = W*s = J
%For a 12S battery cell:
S = 12;
V_mean = 3.6; %[V]
V_batt_mean = S*V_mean; %[V] Voltage of the resulting battery
num_series = ceil(V_batt/V_mean); %number of cells in series, round up
numJ = V_mean*num_series*cap_batt*3600; %[V]*[number in series]*[A*hr]*[s/hr] = [W*hr]*[s/hr] = [W*s] = [J]
num_parallel = ceil(E_req/numJ);
total_cells = num_series*num_parallel;

%For 25500 battery cells
%http://www.ebay.com/gds/A-Beginners-Guide-to-Buying-Li-Ion-Batteries-/10000000177590030/g.html 
cell_volume = pi*((0.0193/2)^2)*0.0492;
volume_batt = cell_volume*total_cells;
