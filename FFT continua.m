% Paso 1: Convertir cada fecha a número serial
dias_serial = datenum(anios, meses, dias_num);

% Paso 2: Generar el vector de días consecutivos sin huecos
dia_inicio = min(dias_serial);
dia_fin    = max(dias_serial);
serie_dias = (dia_inicio:dia_fin)';
N_fft      = length(serie_dias);

% Paso 3: Rellenar la serie continua con los datos conocidos
Tmax_serie = NaN(N_fft, 1);
for k = 1:length(dias_serial)
    idx = dias_serial(k) - dia_inicio + 1;
    Tmax_serie(idx) = Tmax(k);
end

% Paso 4: Interpolación lineal de los huecos
idx_conocidos = find(~isnan(Tmax_serie));
idx_todos     = (1:N_fft)';
Tmax_interp   = interp1(idx_conocidos, Tmax_serie(idx_conocidos), ...
                        idx_todos, 'linear', 'extrap');

% Paso 5: Detrending lineal + FFT
senial_detrend    = detrend(Tmax_interp);
X                 = fft(senial_detrend);
mitad             = floor(N_fft/2) + 1;

% Espectro unilateral de amplitud en °C
magnitud          = abs(X(1:mitad)) / N_fft;
magnitud(2:end-1) = 2 * magnitud(2:end-1);
frecuencias       = (0:(mitad-1)) / N_fft;   % ciclos/día
