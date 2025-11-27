function demoduladorCancion
% demoduladorCancion - Carga un MP3 de música, lo modula en AM, lo demodula
% con multiplicador y recupera el mensaje con filtrado. El script es robusto:
% - verifica existencia del archivo (si no encuentra, abre diálogo)
% - si Fs original no permite la portadora elegida, remuestrea automáticamente
% - muestra gráficas en tiempo y frecuencia
%
% Nota: coloca tu archivo .mp3 en la carpeta que elijas o selecciónalo en el diálogo.

clc; clear; close all;

%% ---------------- 1) Selección / carga del archivo --------------------
% Cambia aquí por una ruta absoluta si prefieres (p. ej. '/Users/.../cancion.mp3')
archivoMusica = "/Users/alexandermunoznava/Downloads/totoAfrica.mp3";

% Si el archivo no existe en la ruta dada, abrir diálogo para elegir archivo
if ~isfile(archivoMusica)
    [file, path] = uigetfile({'*.mp3;*.wav','Audio Files (*.mp3,*.wav)'}, ...
                             'Selecciona el archivo de música');
    if isequal(file,0)
        error('No se seleccionó archivo. Coloca el MP3 en la carpeta o usa ruta absoluta.');
    end
    archivoMusica = fullfile(path,file);
end

% Intentar leer el archivo
try
    [x, Fs] = audioread(archivoMusica);
catch ME
    error('Error leyendo el archivo con audioread: %s\nComprueba que el archivo exista y tenga formato compatible.', ME.message);
end

% Convertir a mono si viene estéreo
if size(x,2) > 1
    x = mean(x,2);
end

% Normalizar amplitud
if max(abs(x)) > 0
    x = x / max(abs(x));
end

%% ---------------- 2) Parámetros del modulador / demodulador ------------
% Elegimos una portadora representativa; se remuestreará si Fs no la permite.
fc = 300e3;            % Frecuencia de portadora deseada (300 kHz)
max_allowable_fc = floor(Fs/2) - 1; % por Nyquist

% Si la Fs original no permite representar fc, remuestreamos
if Fs <= 2*fc
    % Determinar nueva Fs práctica: usar factor de oversampling sobre 2*fc
    % Elegimos Fs_new = max(Fs, ceil(5*fc)) -> 5 veces fc suele ser suficiente
    Fs_new = max(Fs, ceil(5*fc));
    fprintf('Fs original = %d Hz no puede representar fc=%d Hz.\n', Fs, round(fc));
    fprintf('Remuestreando a Fs_new = %d Hz para permitir la portadora...\n', Fs_new);
    x = resample(x, Fs_new, Fs);   % remuestreo
    Fs = Fs_new;
else
    fprintf('Fs original = %d Hz es suficiente para fc = %d Hz.\n', Fs, round(fc));
end

N = length(x);
t = (0:N-1)'/Fs;

%% ---------------- 3) Modulación AM (DSB-SC) ---------------------------
% Generamos portadora (coseno) con la nueva Fs
c = cos(2*pi*fc*t);

% Señal modulada (producto)
xM = x .* c;

%% ---------------- 4) Demodulación por multiplicación -----------------
% Multiplicador (producto) - Señal demodulada antes de filtrar
xD = xM .* c;

%% ---------------- 5) Filtrado pasa-bajas para recuperar el mensaje ----
% Elegimos cutoff según contenido musical (hasta 15 kHz típico); adaptativo:
f_cutoff = min(15000, Fs/2*0.9);  % no superar Nyquist
Wn = f_cutoff / (Fs/2);           % frecuencia normalizada para fir1

filter_order = 128;               % orden del FIR (más alto = transición más nítida)
b = fir1(filter_order, Wn, 'low');

% Filtrado (con filter)
xF = filter(b, 1, xD);

%% ---------------- 6) Cálculo de FFTs centradas -----------------------
f = (-N/2:N/2-1) * (Fs / N);

X  = abs(fftshift(fft(x)))  / N;
XM = abs(fftshift(fft(xM))) / N;
XD = abs(fftshift(fft(xD))) / N;
XF = abs(fftshift(fft(xF))) / N;

%% ---------------- 7) Graficación (tiempo y frecuencia) ----------------
% Tiempo: mostrar solo los primeros instantes para mejor visual (ajusta si quieres)
tZoom = 0 : 1/Fs : min(0.05, (N-1)/Fs); % 50 ms o menos si la señal es corta
idxZoom = 1 : min(length(tZoom), N);

figure('Name','Tiempo - modulacion/demodulacion (musica)','NumberTitle','off');
subplot(4,1,1); plot(t(idxZoom), x(idxZoom)); title('Señal original (tiempo)'); xlabel('s'); ylabel('Amp'); grid on;
subplot(4,1,2); plot(t(idxZoom), xM(idxZoom)); title('Señal modulada (tiempo)'); xlabel('s'); ylabel('Amp'); grid on;
subplot(4,1,3); plot(t(idxZoom), xD(idxZoom)); title('Señal demodulada (tiempo)'); xlabel('s'); ylabel('Amp'); grid on;
subplot(4,1,4); plot(t(idxZoom), xF(idxZoom)); title('Señal filtrada / recuperada (tiempo)'); xlabel('s'); ylabel('Amp'); grid on;

figure('Name','Frecuencia - modulacion/demodulacion (musica)','NumberTitle','off');
subplot(4,1,1); plot(f, X); title('Espectro original'); xlim([-25e3 25e3]); grid on;
subplot(4,1,2); plot(f, XM); title('Espectro modulada (mostrar alrededor de fc)'); xlim([fc-200e3 fc+200e3]); grid on;
subplot(4,1,3); plot(f, XD); title('Espectro demodulada'); xlim([-50e3 50e3]); grid on;
subplot(4,1,4); plot(f, XF); title('Espectro filtrada / recuperada'); xlim([-25e3 25e3]); grid on;

fprintf('Demodulador (canción) ejecutado correctamente.\n');
fprintf('Archivo usado: %s\n', archivoMusica);

end

