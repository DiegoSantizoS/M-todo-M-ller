function raiz = metodoMuller(f, x0, x1, x2, tol, max_iter)
    % Metodo de Muller para encontrar raíces de funciones
    % Entradas:
    % f        : función anónima (ej. @(x) x.^3 - 13*x - 12)
    % x0, x1, x2 : valores iniciales
    % tol      : tolerancia (ej. 1e-6)
    % max_iter : número máximo de iteraciones (ej. 100)

    for iter = 1:max_iter
        % 1. Evaluar la función en los tres puntos
        f0 = f(x0);
        f1 = f(x1);
        f2 = f(x2);

        % 2. Calcular diferencias divididas
        h1 = x1 - x0;
        h2 = x2 - x1;
        delta1 = (f1 - f0) / h1;
        delta2 = (f2 - f1) / h2;
        d = (delta2 - delta1) / (h2 + h1);

        % 3. Calcular coeficientes del polinomio cuadrático
        a = d;
        b = delta2 + h2 * d;
        c = f2;

        % 4. Calcular discriminante y elegir signo
        discriminante = sqrt(b^2 - 4 * a * c);
        if abs(b + discriminante) > abs(b - discriminante)
            denom = b + discriminante;
        else
            denom = b - discriminante;
        end

        % Nueva aproximación
        x3 = x2 - (2 * c) / denom;

        % 5. Verificar convergencia
        if abs(x3 - x2) < tol
            raiz = x3;
            return;
        end

        % 6. Actualizar puntos para la siguiente iteración
        x0 = x1;
        x1 = x2;
        x2 = x3;
    end

    % Si no converge
    error('No se alcanzó convergencia en %d iteraciones', max_iter);
end
