% Este cálculo se realiza ANTES de imputar valores faltantes
% para que el porcentaje refleje datos reales y no rellenos
anios_unicos_raw = unique(anios);
N_anios_raw      = length(anios_unicos_raw);

pct_datos_reales = zeros(N_anios_raw, 1);
dias_en_anio     = zeros(N_anios_raw, 1);

for i = 1:N_anios_raw
    mask_a              = (anios == anios_unicos_raw(i));
    n_dias_anio         = sum(mask_a);
    n_reales            = sum(~isnan(Tmax(mask_a)));  % días con dato real
    dias_en_anio(i)     = n_dias_anio;
    pct_datos_reales(i) = n_reales / max(n_dias_anio, 1);
end

% Umbrales definidos como constantes para facilitar su ajuste
umbral_pct  = 0.70;   % 70 % mínimo de días con dato real
umbral_dias = 300; 
