% Inciso 2 - Convolución
% Definir señales
t = -10:0.1:10;
x = (t>=0 & t<=2);  % señal rectangular
h = (t>=0 & t<=3);  % otra señal rectangular

% Graficar señales
figure;
subplot(3,1,1); stem(t,x); title('Señal x(t)'); xlabel('t'); ylabel('x(t)');
subplot(3,1,2); stem(t,h); title('Señal h(t)'); xlabel('t'); ylabel('h(t)');

% Convolución
y = conv(x,h);
ty = -20:0.1:20;  % nuevo eje de tiempo aproximado

subplot(3,1,3); stem(ty,y); title('Convolución x(t)*h(t)'); xlabel('t'); ylabel('y(t)');

% Verificación de conmutatividad
y1 = conv(x,h);
y2 = conv(h,x);
disp('¿Son iguales conv(x,h) y conv(h,x)?')
isequal(y1,y2)
