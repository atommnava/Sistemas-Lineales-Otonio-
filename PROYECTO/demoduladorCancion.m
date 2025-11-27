function demoduladorCancion
% demoduladorCancion.m (versión corregida)
% Modula un archivo MP3 en AM, lo demodula con multiplicador y recupera
% el mensaje mediante filtrado FIR. Corrige errores de dimensiones en las FFT
% y garantiza reproducción una sola vez.

clc; clear; close all;

%% 1) Cargar archivo MP3
archivoMusica = "/Users/alexandermunoznava/Downloads/totoAfrica.mp3";

if ~isfile(archivoMusica)
    [file, path] = uigetfile({'*.mp3','Archivos MP3'}, 'Seleccionar canción');
    if isequal(file,0)
        error("No se seleccionó archivo.");
    end
    archivoMusica = fullfile(path, file);
end

[x, Fs] = audioread(archivoMusica);

% Convertir a mono
if size(x,2) > 1
    x = mean(x, 2);
end

% Normalizar y asegurar tipo double
if max(abs(x)) > 0
    x = x / max(abs(x));
end
x = double(x);

N = length(x);
t = (0:N-1)'/Fs;

%% 2) Selección automática de la portadora (cumple Nyquist)
fc = round(0.4 * (Fs/2));  % seguro: fc < Fs/2
fprintf("Fs = %d Hz -> fc seleccionada = %d Hz\n", Fs, fc);

c = cos(2*pi*fc*t);

%% 3) Modulación AM (producto)
xM = x .* c;

%% 4) Demodulación AM (producto)
xD = xM .* c;

%% 5) Filtrado pasa-bajas FIR
filter_order = 128;
f_cutoff = min(15000, Fs/2 * 0.9);  % corte en Hz (no superar Nyquist)
Wn = f_cutoff / (Fs/2);

b = fir1(filter_order, Wn, "low");
xF = filter(b, 1, xD);

%% 6) Corrección del retardo del filtro FIR
delay = round(filter_order/2);

if length(xF) > 2*delay
    xF_rec = xF(delay+1:end-delay);
else
    xF_rec = xF; % señal muy corta → usar completa
end

% Normalizar salida recuperada (proteger contra división por cero)
if max(abs(xF_rec)) > 0
    xF_rec = xF_rec / max(abs(xF_rec));
end

%% 7) Reproducción de audio (una vez por señal)
fprintf("▶ Reproduciendo señal ORIGINAL...\n");
sound(x, Fs);
pause(length(x)/Fs + 0.2);

fprintf("▶ Reproduciendo señal RECUPERADA...\n");
sound(xF_rec, Fs);
pause(length(xF_rec)/Fs + 0.2);

%% 8) FFTs y vectores de frecuencia (cada señal con su N)
% Original y señales relacionadas (tienen longitud N)
X  = abs(fftshift(fft(x)))  / N;
XM = abs(fftshift(fft(xM))) / N;
XD = abs(fftshift(fft(xD))) / N;
f_orig = (-N/2:N/2-1) * (Fs/N);  % vector frecuencia para las señales de longitud N

% Recuperada (puede tener distinta longitud Nrec)
Nrec = length(xF_rec);
XF_rec = abs(fftshift(fft(xF_rec))) / Nrec;
f_rec = (-Nrec/2:Nrec/2-1) * (Fs / Nrec);

%% 9) Gráficas
% --- Tiempo (zoom 50 ms) ---
tZoom = 0:1/Fs:min(0.05, (N-1)/Fs);
idx = 1:length(tZoom);

figure("Name","Tiempo - Señales AM (Música)");
subplot(4,1,1); plot(t(idx), x(idx));      title("Señal Original");  grid on;
subplot(4,1,2); plot(t(idx), xM(idx));     title("Señal Modulada");  grid on;
subplot(4,1,3); plot(t(idx), xD(idx));     title("Señal Demodulada");grid on;
% Para la recuperada usamos su propio vector tiempo
t_rec = (0:Nrec-1)'/Fs;
lenPlotRec = min(length(t_rec), length(tRecClip(t_rec,0.05))); % segura
subplot(4,1,4); plot(t_rec(1:min(length(t_rec),length(idx))), xF_rec(1:min(length(xF_rec),length(idx))));
title("Señal Filtrada / Recuperada"); grid on;
xlabel("Tiempo (s)"); ylabel("Amplitud");

% --- Frecuencia ---
figure("Name","Frecuencia - Señales AM (Música)");
subplot(4,1,1); plot(f_orig, X);  title("Espectro Original"); xlim([-25e3 25e3]); grid on;
subplot(4,1,2); plot(f_orig, XM); title("Modulada (alrededor fc)"); xlim([fc-40e3 fc+40e3]); grid on;
subplot(4,1,3); plot(f_orig, XD); title("Demodulada"); xlim([-40e3 40e3]); grid on;
subplot(4,1,4); plot(f_rec, XF_rec); title("Recuperada"); xlim([-20e3 20e3]); grid on;

fprintf("\nProceso finalizado correctamente.\nArchivo usado: %s\n", archivoMusica);

end

%% Helper local function (pequeño util para proteger plots de tiempo)
function tOut = tRecClip(tVec, maxDur)
% devuelve vector de tiempo hasta maxDur (o completo si es menor)
if isempty(tVec)
    tOut = tVec;
    return;
end
idx = find(tVec <= maxDur);
if isempty(idx)
    tOut = tVec(1:min(1,end));
else
    tOut = tVec(1:idx(end));
end
end
