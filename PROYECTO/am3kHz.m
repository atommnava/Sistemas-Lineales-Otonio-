clc; clear; close all;

%% -----------------------------------------------------------
%   DEFINICIÓN DE LA SEÑAL DE MENSAJE (3 kHz)
% ------------------------------------------------------------
fS = 3e3;                % Frecuencia del mensaje (3 kHz)
n = 10000;               % Número de muestras
tS = linspace(0, 2/fS, n);   % Tiempo total
xS = sin(2*pi*fS*tS);    % Señal senoidal del mensaje


%% -----------------------------------------------------------
%   DEFINICIÓN DE LA PORTADORA (570 kHz)
% ------------------------------------------------------------
fC = 570e3;              % Frecuencia de la portadora
xC = sin(2*pi*fC*tS);    % Señal portadora


%% -----------------------------------------------------------
%   MODULACIÓN Y DEMODULACIÓN
% ------------------------------------------------------------
xM = xS .* xC;           % Señal modulada AM
xD = xM .* xC;           % Señal demodulada (multiplicador)


%% -----------------------------------------------------------
%   FILTRO PASA BAJAS (RECUPERACIÓN DEL MENSAJE)
% ------------------------------------------------------------
cutOff = fS / ((n - 1) * fC / 2);  % Frecuencia normalizada del filtro
order = 30;                        % Orden del filtro FIR
coef = fir1(order, cutOff, "low"); % Diseño
xF = filter(coef, 1, xD);          % Señal filtrada


%% -----------------------------------------------------------
%   TRANSFORMADAS DE FOURIER
% ------------------------------------------------------------
XS = abs(fft(xS)) * 2 / n;
FS = (-(n-1)/2:(n-1)/2) * 2 * fS / n;

XC = abs(fft(xC)) * 2 / n;
FC = (-(n-1)/2:(n-1)/2) * 2 * fC / n;

XM = abs(fft(xM)) * 2 / n;
FM = (-(n-1)/2:(n-1)/2) * (2 * fC + fS) / n;

XD = abs(fft(xD)) * 2 / n;
FD = (-(n-1)/2:(n-1)/2) * (4 * fC + fS) / n;

XF = abs(fft(xF)) * 2 / n;
FF = (-(n-1)/2:(n-1)/2) * 2 * fS / n;


%% -----------------------------------------------------------
%   GRÁFICAS: MODULADOR (DOMINIO DEL TIEMPO)
% ------------------------------------------------------------
figure;
subplot(3,1,1);
plot(tS, xS, 'LineWidth', 1.5);
xlabel('Tiempo (s)'); ylabel('Amplitud');
title('Señal de Mensaje (3 kHz)');
grid on;

subplot(3,1,2);
plot(tS, xC, 'LineWidth', 1.5);
xlabel('Tiempo (s)'); ylabel('Amplitud');
title('Señal Portadora (570 kHz)');
grid on;

subplot(3,1,3);
plot(tS, xM, 'LineWidth', 1.5);
xlabel('Tiempo (s)'); ylabel('Amplitud');
title('Señal Modulada AM');
grid on;


%% -----------------------------------------------------------
%   GRÁFICAS: MODULADOR (DOMINIO DE LA FRECUENCIA)
% ------------------------------------------------------------
figure;
subplot(3,1,1);
plot(FS, XS, 'LineWidth', 1.5);
xlabel('Frecuencia (Hz)'); ylabel('Magnitud');
title('Espectro de la Señal de Mensaje');
grid on;

subplot(3,1,2);
plot(FC, XC, 'LineWidth', 1.5);
xlabel('Frecuencia (Hz)'); ylabel('Magnitud');
title('Espectro de la Señal Portadora');
grid on;

subplot(3,1,3);
plot(FM, XM, 'LineWidth', 1.5);
xlabel('Frecuencia (Hz)'); ylabel('Magnitud');
title('Espectro de la Señal Modulada AM');
grid on;


%% -----------------------------------------------------------
%   GRÁFICAS: DEMODULADOR (DOMINIO DEL TIEMPO)
% ------------------------------------------------------------
figure;
subplot(3,1,1);
plot(tS, xM, 'LineWidth', 1.5);
xlabel('Tiempo (s)'); ylabel('Amplitud');
title('Señal Modulada AM');
grid on;

subplot(3,1,2);
plot(tS, xD, 'LineWidth', 1.5);
xlabel('Tiempo (s)'); ylabel('Amplitud');
title('Señal Demodulada (Multiplicador)');
grid on;

subplot(3,1,3);
plot(tS, xF, 'LineWidth', 1.5);
xlabel('Tiempo (s)'); ylabel('Amplitud');
title('Señal Recuperada (Filtrada)');
grid on;


%% -----------------------------------------------------------
%   GRÁFICAS: DEMODULADOR (DOMINIO DE LA FRECUENCIA)
% ------------------------------------------------------------
figure;
subplot(3,1,1);
plot(FM, XM, 'LineWidth', 1.5);
xlabel('Frecuencia (Hz)'); ylabel('Magnitud');
title('Espectro de la Señal Modulada AM');
grid on;

subplot(3,1,2);
plot(FD, XD, 'LineWidth', 1.5);
xlabel('Frecuencia (Hz)'); ylabel('Magnitud');
title('Espectro de la Señal Demodulada');
grid on;

subplot(3,1,3);
plot(FF, XF, 'LineWidth', 1.5);
xlabel('Frecuencia (Hz)'); ylabel('Magnitud');
title('Espectro de la Señal Filtrada (Mensaje Recuperado)');
grid on;
