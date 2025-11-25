import sympy as sp
import numpy as np
import matplotlib.pyplot as plt

# ---------------------------
# 1. Definición de variables
# ---------------------------
t, tau = sp.symbols('t tau', real=True)

# ---------------------------
# 2. Solicitar señales
# ---------------------------
print("Definición de señales por tramos")

# Señal x(t)
expr_x = input("Ingresa la expresión de x(tau) en función de tau (ej: 1, tau+1, etc): ")
a_x = float(input("Límite inferior de x(tau): "))
b_x = float(input("Límite superior de x(tau): "))
x_tau = sp.Piecewise((sp.sympify(expr_x), (tau >= a_x) & (tau <= b_x)), (0, True))

# Señal h(t)
expr_h = input("Ingresa la expresión de h(tau) en función de tau (ej: 1, 1-Abs(tau), etc): ")
a_h = float(input("Límite inferior de h(tau): "))
b_h = float(input("Límite superior de h(tau): "))
h_tau = sp.Piecewise((sp.sympify(expr_h), (tau >= a_h) & (tau <= b_h)), (0, True))

# ---------------------------
# 3. Definir convolución simbólica
# ---------------------------
h_shifted = h_tau.subs(tau, t - tau)
conv_integral = sp.integrate(x_tau * h_shifted, (tau, -sp.oo, sp.oo))

print("\nFunción resultante de la convolución:")
sp.pprint(conv_integral)

# ---------------------------
# 4. Graficar
# ---------------------------
f_conv = sp.lambdify(t, conv_integral, 'numpy')

T = np.linspace(a_x + a_h - 1, b_x + b_h + 1, 400)
Y = [f_conv(val) for val in T]

plt.plot(T, Y, label="x*h")
plt.title("Convolución de x(t) y h(t)")
plt.xlabel("t")
plt.ylabel("y(t)")
plt.grid(True)
plt.legend()
plt.show()
