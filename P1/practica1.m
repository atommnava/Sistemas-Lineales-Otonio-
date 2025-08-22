% Creamos un array de -3 a 3
T = -3:3;

% Array de resultados de la funcion de XT
% el .^2 es para que en cada elemento del array se aplique el ^2
XT = 5 * (T.^2) + (2 * T);


% Plotear la función XT
figure; % Crear una nueva figura
plot(T, XT, 'b', 'LineWidth', 2); % Graficar XT en función de T
hold on; % Mantener el gráfico para agregar más datos

% Array para YT
K1 = 2;
YT = K1 * XT;


% Plotear la función YT
plot(T, YT, 'r-', 'LineWidth', 2); % Graficar YT en función de T

% Añadir etiquetas y título
xlabel('T');
ylabel('Valores');
title('Gráfica de XT y YT');
legend('Original', 'Desplasada por 2'); % Añadir leyenda
grid on; % Activar la cuadrícula
hold("off");

% ----------------------------------------------------------------------

% Parámetros de la señal
F = 10; % Frecuencia en Hz
A = 5;  % Amplitud en volts
Fs = 100; % Frecuencia de muestreo en Hz (debe ser mayor que 2*F)
% inicio, el avance, numero final
t = 0:1/Fs:1; % Eje temporal de 0 a 1 segundo

% Generar la señal senoidal
SENOIDAL = A * sin(2 * pi * F * t);

% Graficar la señal senoidal
figure; % Crear una nueva figura para la señal senoidal
plot(t, SENOIDAL); % Graficar la señal senoidal
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
title('Señal Senoidal');
grid on; % Activar la cuadrícula

% Comprobar el valor de la frecuencia en la gráfica
text(0.5, A, sprintf('Frecuencia: %d Hz', F), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
hold("on");
K2 = 3;
% Senoidal * K
YTSenoidal = K2 * SENOIDAL;

% Graficar la señal YT senoidal
plot(t, YTSenoidal, 'r--', 'LineWidth', 2); % Graficar YT senoidal en función de t
legend('Señal Senoidal', 'Señal YT Senoidal'); % Actualizar leyenda
% Añadir etiquetas y título para la gráfica de YT senoidal
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
title('Señal YT Senoidal');
grid on; % Activar la cuadrícula
hold("off");
