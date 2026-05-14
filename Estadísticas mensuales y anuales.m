% Agrupación mensual: para cada mes-año calculamos el máximo, mínimo y promedio de temperatura, y la precipitación total
for i = 1:N_meses
    mask = (clave_mes_anio == claves_unicas(i));
    Tmax_mensual(i)  = max(Tmax(mask));       % máxima absoluta del mes
    Tmin_mensual(i)  = min(Tmin(mask));       % mínima absoluta del mes
    Tprom_mensual(i) = mean(Tprom(mask));     % promedio de los días del mes
    Prec_mensual(i)  = sum(Precip(mask));     % precipitación acumulada del mes
    anios_vec(i)     = floor(claves_unicas(i) / 100);
    meses_vec(i)     = mod(claves_unicas(i), 100);
end

% Agrupación anual: para cada año tomamos el extremo absoluto
for i = 1:N_anios
    mask_a         = (anios == anios_unicos(i));
    Tmax_anual(i)  = max(Tmax(mask_a));       % máxima absoluta del año
    Tmin_anual(i)  = min(Tmin(mask_a));       % mínima absoluta del año
    Tprom_anual(i) = mean(Tprom(mask_a));     % promedio anual
    Prec_anual(i)  = sum(Precip(mask_a));     % precipitación anual total
end

% La máscara de validez
mask_valido = (pct_graf >= umbral_pct) & (dias_graf >= umbral_dias);
