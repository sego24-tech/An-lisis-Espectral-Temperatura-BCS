% Saltamos las 25 líneas de encabezado con HeaderLines
fid = fopen('dia03026.txt', 'r');
datos = textscan(fid, '%s %s %s %s %s', 'HeaderLines', 25, 'Delimiter', '\t');
fclose(fid);

% Extraemos cada variable como vector numérico - Los "NULO" del archivo se convierten en NaN automáticamente
fechas_str = datos{1};
Precip     = str2double(datos{2});   % Precipitación (mm)
Evap       = str2double(datos{3});   % Evaporación (mm)
Tmax       = str2double(datos{4});   % Temperatura máxima (°C)
Tmin       = str2double(datos{5});   % Temperatura mínima (°C)
