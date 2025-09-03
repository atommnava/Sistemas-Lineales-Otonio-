% Inciso 3 - Correlación con señal de audio (sin usar awgn)
load handel
sound(y)   % reproducir señal original

niveles_ruido = -5:5:40;   % variación del SNR
corr_indices = zeros(size(niveles_ruido));

% Energía de la señal original
Ps = mean(y.^2);

for k=1:length(niveles_ruido)
    SNR_dB = niveles_ruido(k);

    % Calcular potencia de ruido para un SNR deseado
    SNR_linear = 10^(SNR_dB/10);
    Pn = Ps / SNR_linear;

    % Generar ruido gaussiano con la varianza correspondiente
    ruido = sqrt(Pn) * randn(size(y));

    % Señal con ruido
    yn = y + ruido;

    % Correlación
    d = corrcoef(y,yn);
    corr_indices(k) = d(1,2);

    fprintf('Nivel de ruido (SNR = %d dB) --> Índice de correlación = %.4f\n',...
            SNR_dB,corr_indices(k));
end

% Mostrar tabla
tabla = table(niveles_ruido',corr_indices','VariableNames',{'SNR_dB','CorrCoef'});
disp(tabla);

% Graficar relación
figure;
plot(niveles_ruido,corr_indices,'-o','LineWidth',2);
xlabel('Nivel de Ruido (SNR en dB)');
ylabel('Índice de Correlación');
title('Relación entre SNR y CorrCoef (sin awgn)');
grid on;
