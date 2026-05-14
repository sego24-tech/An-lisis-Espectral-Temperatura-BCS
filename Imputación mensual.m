% Iteramos sobre cada combinación única de mes-año
for i = 1:N_meses
    mask = (clave_mes_anio == claves_unicas(i));

    % Tmax: rellenar NaN con la media de ese mes-año específico
    media_tmax_mes = mean(Tmax(mask), 'omitnan');
    Tmax(mask & isnan(Tmax)) = media_tmax_mes;

    % Tmin: igual procedimiento
    media_tmin_mes = mean(Tmin(mask), 'omitnan');
    Tmin(mask & isnan(Tmin)) = media_tmin_mes;

    % Precipitación y evaporación: NaN → 0 (sin registro = sin evento)
    Precip(mask & isnan(Precip)) = 0;
    Evap(mask & isnan(Evap))     = 0;
end

% Caso extremo: meses completamente vacíos = media global como último recurso
Tmax(isnan(Tmax)) = mean(Tmax, 'omitnan');
Tmin(isnan(Tmin)) = mean(Tmin, 'omitnan');

% Temperatura promedio diaria (definición estándar climatológica)
Tprom = (Tmax + Tmin) / 2;
