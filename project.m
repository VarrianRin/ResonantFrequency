
%% -----------------------------------------------------------------------
% Maxim Spinov
% project
% EECE.2080
%% -----------------------------------------------------------------------

%% -----xxxxx-----xxxxx-----xxxxx-----xxxxx-----xxxxx-----xxxxx-----
% channel 1 is our voltage on resistor in L->C->R circuit
% channel 2 is our input voltage 
% Magnitude1 is channel 1 reference to amplitude
% channel 2 is input voltage reference to amplitude
%% -----xxxxx-----xxxxx-----xxxxx-----xxxxx-----xxxxx-----xxxxx-----
clear all;
clc;

filename    = "data.csv";
amplitude   = 1;                    % Volts
resistance  = 460;                  % Ohm

data        = csvread(filename);
sz          = size(data, 1);
Amplitude   = amplitude .* ones(1, sz);

frequency   = data(:, 1);
Magnitude1  = data(:, 2);
Phase1      = data(:, 3);
Magnitude2  = data(:, 4);
[~, idx]    = max(Magnitude1);
resonance   = frequency(idx);
Voltage1    = Amplitude .* (10 .^ Magnitude1);
Current1    = Voltage1 ./ resistance;

%% ------------------------------- OUTPUT ------------------------------

disp("Resonance Frequency in Hz is");
disp(resonance);
disp("Resonance Frequency in rad/sec is");
disp(resonance*2*pi);
disp("Voltage amplitude at this frequency in Volts is");
disp(Voltage1(idx));
disp("Current amplitude at this frequency in Amps is");
disp(Current1(idx));



%% ---------------------------------- GRAPH -------------------------------

figure;
plot(frequency, Voltage1, 'b', "LineWidth", 2);
hold on
plot(frequency, Current1, 'm', "LineWidth", 2);
plot(resonance, Voltage1(idx),'c*', "LineWidth", 3)
plot(resonance, Current1(idx),'r*', "LineWidth", 3)

leg = {['Voltage curve'], ['Current curve'], ['Voltage at resonance frequency' resonance ' Hz'], ['Current at resonance frequency' resonance ' Hz']};
legend(leg, 'Location', 'southoutside', 'FontSize', 12, 'NumColumns', 2);
set(gca, 'FontSize', 14);
set(gca, 'Box', 'on');
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
set(gcf, 'Color', [1, 1, 1]);
grid on;

title("Voltage analysis with different frequencies", 'FontSize', 16);
xlabel("frequency, Hz" , 'FontSize', 16);
ylabel("voltage, V; current, A", 'FontSize', 16);
hold off


%% ------------------------ MULTISIM --------------------------------------

freq  = [resonance/100, resonance/10, resonance, resonance*10, resonance*100];
volts = [14.6 / 2000, 148 / 2000, 1.95 / 2, 128 / 2000, 12.7 / 2000];
amps  = [31.8 / 2000000, 321 / 2000000, 4.24 / 2000, 277/ 2000000, 27.5/ 2000000];

figure;
plot(freq, volts, "LineWidth", 2);
hold on
plot(freq, amps, "LineWidth", 2);

leg = {['Voltage curve'], ['Current curve']};
legend(leg, 'Location', 'southoutside', 'FontSize', 12, 'NumColumns', 2);
set(gca, 'FontSize', 14);
set(gca, 'Box', 'on');
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
set(gcf, 'Color', [1, 1, 1]);
grid on;

title("Voltage analysis with different frequencies", 'FontSize', 16);
xlabel("frequency, Hz" , 'FontSize', 16);
ylabel("voltage, V; current, A", 'FontSize', 16);
hold off
