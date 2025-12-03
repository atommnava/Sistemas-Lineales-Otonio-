w = logspace(-2, 2, 1000);

jw = 1j.*w;
H = 25*(1 + 1j.*w) ./ ( jw .* ( -w.^2 + 1j*10.*w + 25 ) );

mag = 20*log10(abs(H));
phase_deg = angle(H) * 180/pi;

% Plots
figure;
subplot(2,1,1);
semilogx(w, mag, 'b','LineWidth',1.2);
grid on;
ylabel('magnitud dB)');
title('Bode diagramw - Magnitude');

subplot(2,1,2);
semilogx(w, phase_deg, 'r','LineWidth',1.2);
grid on;
xlabel('Frequency \omega (rad/s)');
ylabel('fase (deg)');
title('Bode diagram - Phase');


