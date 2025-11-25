function amProyectoCompleto
clc; clear; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1) CARGA DE ARCHIVOS MP3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file1 = "/Users/alexandermunoznava/Downloads/pedro.mp3";
file2 = "/Users/alexandermunoznava/Downloads/yquh.mp3";
file3 = "/Users/alexandermunoznava/Downloads/chillido.mp3";

[x1, t1, Fs1] = conversorInterno(file1);
[x2, t2, Fs2] = conversorInterno(file2);
[x3, t3, Fs3] = conversorInterno(file3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2) NORMALIZACIÓN DEL TAMAÑO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fs = max([Fs1 Fs2 Fs3]);

if Fs1 ~= Fs, x1 = resample(x1, Fs, Fs1); end
if Fs2 ~= Fs, x2 = resample(x2, Fs, Fs2); end
if Fs3 ~= Fs, x3 = resample(x3, Fs, Fs3); end

N = max([length(x1) length(x2) length(x3)]);
x1(end+1:N) = 0;
x2(end+1:N) = 0;
x3(end+1:N) = 0;

t = (0:N-1)'/Fs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3) MODULACIÓN AM (3 PORTADORAS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fc1 = 530e3;
fc2 = 1223e3;
fc3 = 1710e3;

[xS1, xC1, xM1, XS1, XC1, XM1, FS1, FC1, FM1] = amInterno(x1,t,Fs,fc1);
[xS2, xC2, xM2, XS2, XC2, XM2, FS2, FC2, FM2] = amInterno(x2,t,Fs,fc2);
[xS3, xC3, xM3, XS3, XC3, XM3, FS3, FC3, FM3] = amInterno(x3,t,Fs,fc3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4) MULTIPLEXADO (SUMADOR)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xM_mux = xM1 + xM2 + xM3;
XM_mux = abs(fftshift(fft(xM_mux))) / N;
FM_mux = (-N/2:N/2-1)*(Fs/N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5) DEMODULACIÓN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[xD1, xF1, XD1, XF1, FD1, FF1] = amDetectorInterno(xM_mux, xC1, Fs);
[xD2, xF2, XD2, XF2, FD2, FF2] = amDetectorInterno(xM_mux, xC2, Fs);
[xD3, xF3, XD3, XF3, FD3, FF3] = amDetectorInterno(xM_mux, xC3, Fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6) GRAFICACIÓN (13 FIGURAS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FIGURA 1 — Mensajes (tiempo)
figure;
subplot(3,1,1); plot(t,x1); title('Mensaje 1 (tiempo)');
subplot(3,1,2); plot(t,x2); title('Mensaje 2 (tiempo)');
subplot(3,1,3); plot(t,x3); title('Mensaje 3 (tiempo)');

%% FIGURA 2 — Mensajes (frecuencia)
figure;
subplot(3,1,1); plot(FS1,XS1); title('Mensaje 1 (freq)');
subplot(3,1,2); plot(FS2,XS2); title('Mensaje 2 (freq)');
subplot(3,1,3); plot(FS3,XS3); title('Mensaje 3 (freq)');

%% FIGURA 3 — Portadoras (tiempo)
figure;
subplot(3,1,1); plot(t,xC1); title('Portadora 1');
subplot(3,1,2); plot(t,xC2); title('Portadora 2');
subplot(3,1,3); plot(t,xC3); title('Portadora 3');

%% FIGURA 4 — Portadoras (frecuencia)
figure;
subplot(3,1,1); plot(FC1,XC1); title('Portadora 1 (freq)');
subplot(3,1,2); plot(FC2,XC2); title('Portadora 2 (freq)');
subplot(3,1,3); plot(FC3,XC3); title('Portadora 3 (freq)');

%% FIGURA 5 — Moduladas individualmente (tiempo)
figure;
subplot(3,1,1); plot(t,xM1); title('Modulada 1');
subplot(3,1,2); plot(t,xM2); title('Modulada 2');
subplot(3,1,3); plot(t,xM3); title('Modulada 3');

%% FIGURA 6 — Moduladas individualmente (frecuencia)
figure;
subplot(3,1,1); plot(FM1,XM1); title('Modulada 1 (freq)');
subplot(3,1,2); plot(FM2,XM2); title('Modulada 2 (freq)');
subplot(3,1,3); plot(FM3,XM3); title('Modulada 3 (freq)');

%% FIGURA 7 — Moduladas (tiempo) — 3 EN 1
figure;
subplot(3,1,1);
plot(t,xM1); title('Gráfica de modulada 1'); xlabel('Tiempo de M'); ylabel('Amplitud');

subplot(3,1,2);
plot(t,xM2); title('Gráfica de modulada 2'); xlabel('Tiempo de M'); ylabel('Amplitud');

subplot(3,1,3);
plot(t,xM3); title('Gráfica de modulada 3'); xlabel('Tiempo de M'); ylabel('Amplitud');


%% FIGURA 8 — Moduladas (frecuencia) — 3 EN 1
figure;
subplot(3,1,1);
plot(FM1,XM1); title('Gráfica de modulada 1'); xlabel('Frecuencia de M'); ylabel('Magnitud');

subplot(3,1,2);
plot(FM2,XM2); title('Gráfica de modulada 2'); xlabel('Frecuencia de M'); ylabel('Magnitud');

subplot(3,1,3);
plot(FM3,XM3); title('Gráfica de modulada 3'); xlabel('Frecuencia de M'); ylabel('Magnitud');


%% FIGURA 9 — Demoduladas (tiempo) — 3 EN 1
figure;
subplot(3,1,1);
plot(t,xD1); title('Gráfica de demodulada 1'); xlabel('Tiempo de D'); ylabel('Amplitud');

subplot(3,1,2);
plot(t,xD2); title('Gráfica de demodulada 2'); xlabel('Tiempo de D'); ylabel('Amplitud');

subplot(3,1,3);
plot(t,xD3); title('Gráfica de demodulada 3'); xlabel('Tiempo de D'); ylabel('Amplitud');


%% FIGURA 10 — Demoduladas (frecuencia) — 3 EN 1
figure;
subplot(3,1,1);
plot(FD1,XD1); title('Gráfica de demodulada 1'); xlabel('Frecuencia de D'); ylabel('Magnitud');

subplot(3,1,2);
plot(FD2,XD2); title('Gráfica de demodulada 2'); xlabel('Frecuencia de D'); ylabel('Magnitud');

subplot(3,1,3);
plot(FD3,XD3); title('Gráfica de demodulada 3'); xlabel('Frecuencia de D'); ylabel('Magnitud');


%% FIGURA 11 — Filtradas (tiempo) — 3 EN 1
figure;
subplot(3,1,1);
plot(t,xF1); title('Gráfica de filtrada 1'); xlabel('Tiempo de F'); ylabel('Amplitud');

subplot(3,1,2);
plot(t,xF2); title('Gráfica de filtrada 2'); xlabel('Tiempo de F'); ylabel('Amplitud');

subplot(3,1,3);
plot(t,xF3); title('Gráfica de filtrada 3'); xlabel('Tiempo de F'); ylabel('Amplitud');


%% FIGURA 12 — Filtradas (frecuencia) — 3 EN 1
figure;
subplot(3,1,1);
plot(FF1,XF1); title('Gráfica de filtrada 1'); xlabel('Frecuencia de F'); ylabel('Magnitud');

subplot(3,1,2);
plot(FF2,XF2); title('Gráfica de filtrada 2'); xlabel('Frecuencia de F'); ylabel('Magnitud');

subplot(3,1,3);
plot(FF3,XF3); title('Gráfica de filtrada 3'); xlabel('Frecuencia de F'); ylabel('Magnitud');

%% FIGURA 13 — Señal modulada final (tiempo y frecuencia)
figure;

% --- Señal modulada en tiempo ---
subplot(2,1,1);
plot(t, xM_mux);
title('Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% --- Señal modulada en frecuencia ---
subplot(2,1,2);
plot(FM_mux, XM_mux);
title('Modulated Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FUNCIONES INTERNAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [xMono, t, Fs] = conversorInterno(nombre)
[xAudio, Fs] = audioread(nombre);
if size(xAudio,2) > 1
    xMono = mean(xAudio,2);
else
    xMono = xAudio;
end
xMono = xMono / max(abs(xMono));
t = (0:length(xMono)-1)'/Fs;
end

function [xS,xC,xM,XS,XC,XM,FS,FC,FM] = amInterno(xS,t,Fs,fC)
n = length(xS);
xC = cos(2*pi*fC*t);
xM = xS .* xC;

% FFT vectores
XS = abs(fftshift(fft(xS)))/n;
XC = abs(fftshift(fft(xC)))/n;
XM = abs(fftshift(fft(xM)))/n;

FS = (-n/2:n/2-1)*(Fs/n);
FC = FS;
FM = FS;
end

function [xD,xF,XD,XF,FD,FF] = amDetectorInterno(xM,xC,Fs)
n = length(xC);
xM = xM(1:n);
xD = xM .* xC;

% Pasabajas 20 kHz
cutoff = 20000/(Fs/2);
b = fir1(128, cutoff, 'low');
xF = filter(b,1,xD);

XD = abs(fftshift(fft(xD)))/n;
XF = abs(fftshift(fft(xF)))/n;

FD = (-n/2:n/2-1)*(Fs/n);
FF = FD;
end

