function OperacionesXT()
    % Creamos un array de -3 a 3
    T = -3:3;
    
    % Array de resultados de la funcion de XT
    XT = 5 * (T.^2) + (2 * T);
    
    % Parte par, parte impar
    % Asegurarse de que 'par_impar' esté definida en un archivo separado o aquí mismo
    [xe_vals, xo_vals, ~] = par_impar(T, XT); % Asegúrate de que T sea un vector fila para la función par_impar
                                             % y XT también si tu 'par_impar' espera vectores columna/fila consistentes.

    % Comprobacion : par + impar = deberia dar la original
    xc_vals = xe_vals + xo_vals; % Corregido de xc_vlas
    
    figure('Name', 'Operaciones XT - Todas las Operaciones'); % Crear una ÚNICA figura para XT
    
    %% Sección 1: Operaciones de Transformación
    % Vamos a usar una cuadrícula total de 5 filas por 2 columnas para toda la figura
    % Esto nos da 10 espacios disponibles.

    % Plot 1: XT Original y YT (Escalamiento de amplitud)
    subplot(5, 2, 1); % Fila 1, Columna 1
    plot(T, XT, 'b', 'LineWidth', 2, 'DisplayName', 'XT Original'); 
    hold on; 
    K = 2;
    YT = K * XT;
    plot(T, YT, 'r-', 'LineWidth', 2, 'DisplayName', 'YT = 2 * XT'); 
    xlabel('T');
    ylabel('Valores');
    title('1. XT Original y Escalamiento (YT)');
    legend('show'); 
    grid on; 
    hold off;

    % Plot 2: x(-t) (Reflexión Temporal)
    subplot(5, 2, 2); % Fila 1, Columna 2
    plot(T * -1, XT, 'g--', 'LineWidth', 2, 'DisplayName', 'x(-t)'); 
    xlabel('T');
    ylabel('Valores');
    title('2. Reflexión Temporal: x(-t)');
    legend('show');
    grid on;

    % Plot 3: x(2t) (Compresión Temporal)
    subplot(5, 2, 3); % Fila 2, Columna 1
    plot(T / 2, XT, 'm-.', 'LineWidth', 2, 'DisplayName', 'x(2t)'); % Corregido para compresión
    xlabel('T');
    ylabel('Valores');
    title('3. Compresión Temporal: x(2t)');
    legend('show');
    grid on;

    % Plot 4: x(t/3) (Expansión Temporal)
    subplot(5, 2, 4); % Fila 2, Columna 2
    plot(T * 3, XT, 'c:', 'LineWidth', 2, 'DisplayName', 'x(t/3)'); % Corregido para expansión
    xlabel('T');
    ylabel('Valores');
    title('4. Expansión Temporal: x(t/3)');
    legend('show');
    grid on;
    
    % Plot 5: x(t+5) (Desplazamiento Temporal Adelante)
    subplot(5, 2, 5); % Fila 3, Columna 1
    plot(T + 5, XT, 'w-', 'LineWidth', 2, 'DisplayName', 'x(t+5)'); 
    xlabel('T');
    ylabel('Valores');
    title('5. Desplazamiento Temporal: x(t+5)');
    legend('show');
    grid on;

    % Plot 6: x(4-2t) (Operación Combinada)
    subplot(5, 2, 6); % Fila 3, Columna 2
    plot((4 - (2 * T)), XT, 'y--', 'LineWidth', 2, 'DisplayName', 'x(4-2t)'); 
    xlabel('T');
    ylabel('Valores');
    title('6. Operación Combinada: x(4-2t)');
    legend('show');
    grid on;

    %% Sección 2: Descomposición en Parte Par e Impar
    % Ahora utilizamos los espacios restantes de la cuadrícula de 5x2
    
    % Plot 7: Parte Par de XT
    subplot(5, 2, 7); % Fila 4, Columna 1
    plot(T, xe_vals, 'b', 'LineWidth', 2, 'DisplayName', 'Parte Par (xe(t))'); 
    xlabel('T');
    ylabel('Valores');
    title('7. Parte Par de XT');
    legend('show');
    grid on;

    % Plot 8: Parte Impar de XT
    subplot(5, 2, 8); % Fila 4, Columna 2
    plot(T, xo_vals, 'r--', 'LineWidth', 2, 'DisplayName', 'Parte Impar (xo(t))'); 
    xlabel('T');
    ylabel('Valores');
    title('8. Parte Impar de XT');
    legend('show');
    grid on;

    % Plot 9: Comprobación (Parte Par + Parte Impar)
    subplot(5, 2, [9 10]); % Ocupa ambas columnas de la última fila (Fila 5, Columnas 1 y 2)
    plot(T, xc_vals, 'g', 'LineWidth', 2, 'DisplayName', 'xe(t) + xo(t)'); 
    hold on;
    plot(T, XT, 'b:', 'LineWidth', 1, 'DisplayName', 'XT Original (referencia)');
    xlabel('T');
    ylabel('Valores');
    title('9. Comprobación: Parte Par + Parte Impar vs. Original');
    legend('show');
    grid on;
    hold off;
end


function OperacionesST()

    % Parámetros de la señal
    F = 10; % Frecuencia en Hz
    A = 5;  % Amplitud en volts
    Fs = 100; % Frecuencia de muestreo en Hz (debe ser mayor que 2*F)
    t = 0:1/Fs:1; % Eje temporal de 0 a 1 segundo
    
    % Generar la señal senoidal
    SENOIDAL = A * sin(2 * pi * F * t);
    
    % Parte par, parte impar de la señal senoidal
    % Nota: Tu función 'par_impar' usa T y XT como entrada.
    % Aquí necesitas usar 't' y 'SENOIDAL'.
    % También, asegúrate de que 'par_impar' maneje bien el caso de t con muchos puntos
    % o que tu función 'par_impar_duplicados' sea adecuada para esto.
    % La función 'par_impar' que proporcionaste trabaja bien si t es uniforme y simétrico alrededor de cero.
    % Para la senoidal (que no está centrada en 0 en tu t=0:1/Fs:1), la descomposición
    % par/impar estándar de señales es más compleja y generalmente requiere un dominio de tiempo simétrico.
    % Voy a asumir que quieres aplicar tu misma lógica 'par_impar' aunque el dominio 't' no es simétrico.
    [xe_vals_st, xo_vals_st, ~] = par_impar(t, SENOIDAL);
    
    % Comprobacion : par + impar = deberia dar la original
    xc_vals_st = xe_vals_st + xo_vals_st; % Corregido de xc_vlas
    
    figure('Name', 'Operaciones ST - Todas las Operaciones'); % Crear una ÚNICA figura para ST

    %% Sección 1: Operaciones de Transformación
    % Usaremos una cuadrícula total de 5 filas por 2 columnas para toda la figura
    % Esto nos da 10 espacios disponibles.

    % Plot 1: Senoidal Original y Escalamiento de Amplitud
    subplot(5, 2, 1); 
    plot(t, SENOIDAL, 'b', 'LineWidth', 2, 'DisplayName', 'Señal Senoidal Original'); 
    hold on;
    K = 3;
    YTSenoidal = K * SENOIDAL;
    plot(t, YTSenoidal, 'r--', 'LineWidth', 2, 'DisplayName', 'Señal Senoidal * 3'); 
    xlabel('Tiempo (s)');
    ylabel('Amplitud (V)');
    title('1. Señal Senoidal y Escalamiento');
    legend('show'); 
    grid on; 
    hold off;

    % Plot 2: s(-t) (Reflexión Temporal)
    subplot(5, 2, 2); 
    plot(t * -1, SENOIDAL, 'g--', 'LineWidth', 2, 'DisplayName', 's(-t)'); 
    xlabel('Tiempo (s)');
    ylabel('Amplitud (V)');
    title('2. Reflexión Temporal: s(-t)');
    legend('show');
    grid on;

    % Plot 3: s(2t) (Compresión Temporal)
    subplot(5, 2, 3); 
    plot(t / 2, SENOIDAL, 'm-.', 'LineWidth', 2, 'DisplayName', 's(2t)'); % Corregido para compresión
    xlabel('Tiempo (s)');
    ylabel('Amplitud (V)');
    title('3. Compresión Temporal: s(2t)');
    legend('show');
    grid on;

    % Plot 4: s(t/3) (Expansión Temporal)
    subplot(5, 2, 4); 
    plot(t * 3, SENOIDAL, 'c:', 'LineWidth', 2, 'DisplayName', 's(t/3)'); % Corregido para expansión
    xlabel('Tiempo (s)');
    ylabel('Amplitud (V)');
    title('4. Expansión Temporal: s(t/3)');
    legend('show');
    grid on;
    
    % Plot 5: s(t-2) (Desplazamiento Temporal Retrasado)
    subplot(5, 2, 5); 
    plot(t - 2, SENOIDAL, 'w-', 'LineWidth', 2, 'DisplayName', 's(t-2)'); 
    xlabel('Tiempo (s)');
    ylabel('Amplitud (V)');
    title('5. Desplazamiento Temporal: s(t-2)');
    legend('show');
    grid on;

    % Plot 6: s(-t + 3) - 4 (Operación Combinada)
    subplot(5, 2, 6); 
    plot((-t + 3), (SENOIDAL - 4), 'y--', 'LineWidth', 2, 'DisplayName', 's(-t + 3) - 4'); 
    xlabel('Tiempo (s)');
    ylabel('Amplitud (V)');
    title('6. Operación Combinada: s(-t + 3) - 4');
    legend('show');
    grid on;

    %% Sección 2: Descomposición en Parte Par e Impar
    
    % Plot 7: Parte Par de ST
    subplot(5, 2, 7); 
    plot(t, xe_vals_st, 'b', 'LineWidth', 2, 'DisplayName', 'Parte Par (xe(t))'); 
    xlabel('Tiempo (s)');
    ylabel('Amplitud (V)');
    title('7. Parte Par de ST');
    legend('show');
    grid on;

    % Plot 8: Parte Impar de ST
    subplot(5, 2, 8); 
    plot(t, xo_vals_st, 'r--', 'LineWidth', 2, 'DisplayName', 'Parte Impar (xo(t))'); 
    xlabel('Tiempo (s)');
    ylabel('Amplitud (V)');
    title('8. Parte Impar de ST');
    legend('show');
    grid on;

    % Plot 9: Comprobación (Parte Par + Parte Impar)
    subplot(5, 2, [9 10]); % Ocupa ambas columnas de la última fila
    plot(t, xc_vals_st, 'g', 'LineWidth', 2, 'DisplayName', 'xe(t) + xo(t)'); 
    hold on;
    plot(t, SENOIDAL, 'b:', 'LineWidth', 1, 'DisplayName', 'Señal Original (referencia)');
    xlabel('Tiempo (s)');
    ylabel('Amplitud (V)');
    title('9. Comprobación: Parte Par + Parte Impar vs. Original');
    legend('show');
    grid on;
    hold off;

end

% --- Función auxiliar para descomposición par/impar ---
% Esta función es la que proporcionaste. La he movido aquí para que sea accesible
% por ambas funciones OperacionesXT y OperacionesST si están en el mismo archivo.
% Si 'par_impar' está en un archivo separado, no es necesario incluirla aquí.
function [xe_vals, xo_vals, x_minus_vals] = par_impar(t_in, x_in)
    n = numel(t_in);
    xe_vals = zeros(n,1);
    xo_vals = zeros(n,1);
    x_minus_vals = zeros(n,1); 

    Tkeys = unique(t_in(:).','stable');
    valuesMap = containers.Map('KeyType','double','ValueType','any');
    for i = 1:numel(Tkeys)
        tk = Tkeys(i);
        idxs = find(t_in == tk);
        valuesMap(tk) = x_in(idxs); 
    end

    function val = get_last_or_zero(key)
        if isKey(valuesMap, key)
            vec = valuesMap(key);
            val = vec(end);
        else
            val = 0;
        end
    end

    for k = 1:n
        tk = t_in(k);
        x_t  = x_in(k);                 
        x_mt = get_last_or_zero(-tk);   

        xe_vals(k) = 0.5 * (x_t + x_mt);
        xo_vals(k) = 0.5 * (x_t - x_mt);
        x_minus_vals(k) = x_mt;         
    end
end

% Llama a las funciones
OperacionesXT();
OperacionesST();