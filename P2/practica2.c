% ============================ Entrada ============================
function [XFunction, YFunction] = getFunctionPoints()

    %num_points = input("Ingresa el numero de puntos que tiene la funcion: ");
    
    %XFunction = zeros(1, num_points);
    %YFunction = zeros(1, num_points);
    %
    %for i = 1 : num_points
    %    fprintf('Punto %d:\n', i);
    %    XFunction(i) = input("  X (t): ");
    %    YFunction(i) = input("  Y (x(t)): ");
    %end
    %

    XFunction = [1, 1, 2, 2, 3, 3];
    YFunction = [0, 2, 2, -2, -2, 0];

    figure('Name','x(t) - puntos');
    plot(XFunction, YFunction, "b-o", 'LineWidth', 2);
    hold("on");
    plot(XFunction * - 1, YFunction, "g", 'LineWidth', 2);
    title('Señal Original x(t)');
    xlabel('t'); ylabel('x(t)'); grid on;
    


    XFunction = [2, 0];
    YFunction = [0, 1];
    figure('Name','x(t) - puntos');
    plot(XFunction, YFunction, "b-o", 'LineWidth', 2);
    hold("on");
    plot(XFunction, YFunction * -1, "g", 'LineWidth', 2);
    hold("on");
    plot(XFunction, YFunction * 1/2, "r", 'LineWidth', 2);
    title('Señal Original x(t)');
    xlabel('t'); ylabel('x(t)'); grid on;
end

getFunctionPoints();