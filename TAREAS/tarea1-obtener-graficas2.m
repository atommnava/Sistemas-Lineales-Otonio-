% INCISO B
clc; clear; close all;

% ==========================
% 1. Definir señal original x(tau)
% ==========================
% Evitamos duplicados usando pequeños desplazamientos manuales
tau_orig = [-1, 0, 1, 1.0001, 2, 2.0001, 3];
x_orig   = [ 0, 1, 1,      2, 2,     -1, 0];

% Vector denso para graficar x(tau)
tau = linspace(min(tau_orig), max(tau_orig), 1000);
x_tau = interp1(tau_orig, x_orig, tau, 'linear');

% ==========================
% 2. Definir transformación g(t)
% ==========================
t = linspace(-10, 10, 2000);

% Cambio de variable: tau = -3/2 * (t + 8/3)
tau_trans = (3/7) * t - 3/4;

% Evaluar x en tau_trans (fuera del dominio => 0)
x_tau_trans = interp1(tau_orig, x_orig, tau_trans, 'linear', 0);

% Definir g(t)
h_t = 2 * x_tau_trans + 0;

% ==========================
% 3. Graficar resultados
% ==========================
figure;

subplot(2,1,1);
plot(tau, x_tau, 'b', 'LineWidth', 2); hold on;
plot(tau_orig, x_orig, 'ro', 'MarkerFaceColor','r');
grid on;
title('Señal Original x(\tau)');
xlabel('\tau'); ylabel('x(\tau)');

subplot(2,1,2);
plot(t, h_t, 'm', 'LineWidth', 2);
grid on;
title('Señal Transformada h(t) = 2x(3t/7 - 3/4)');
xlabel('t'); ylabel('h(t)');