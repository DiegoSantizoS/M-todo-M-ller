% Ejercicio - Método de Müller
clc; clear;

% Definir función
f = @(x) x.^3 - 13*x - 12;

% Valores iniciales
x0 = 4.5;
x1 = 5.5;
x2 = 5;

% Parámetros de tolerancia y máximo de iteraciones
tol = 1e-6;
max_iter = 100;

% Inicializar tabla para guardar resultados
iteraciones = [];

for iter = 1:max_iter
    % Evaluar la función en los puntos
    f0 = f(x0);
    f1 = f(x1);
    f2 = f(x2);

    % Calcular diferencias divididas
    h1 = x1 - x0;
    h2 = x2 - x1;
    delta1 = (f1 - f0) / h1;
    delta2 = (f2 - f1) / h2;
    d = (delta2 - delta1) / (h2 + h1);

    % Coeficientes del polinomio cuadrático
    a = d;
    b = delta2 + h2 * d;
    c = f2;

    % Calcular discriminante y nueva aproximación
    discriminante = sqrt(b^2 - 4*a*c);
    if abs(b + discriminante) > abs(b - discriminante)
        denom = b + discriminante;
    else
        denom = b - discriminante;
    end

    x3 = x2 - (2 * c) / denom;

    % Guardar resultados de la iteración
    iteraciones = [iteraciones; iter, x0, x1, x2, x3, f(x3)];

    % Verificar convergencia
    if abs(x3 - x2) < tol
        fprintf('Raíz encontrada: %.10f\n', x3);
        break;
    end

    % Actualizar puntos
    x0 = x1;
    x1 = x2;
    x2 = x3;
end

% Mostrar tabla de iteraciones
T = array2table(iteraciones, ...
    'VariableNames', {'Iter', 'x0', 'x1', 'x2', 'x3', 'f(x3)'});
disp(T);

% Verificación si no convergió
if iter == max_iter
    warning('No se alcanzó convergencia en %d iteraciones.', max_iter);
end
