# Especificación: Reporte Técnico: Análisis Climatológico.
## 1.Proposito.
Procesar, limpiar y analizar estadísticamenta la serie de registros históricos de temperatura y precipitación de la estación meteorológica de La Paz, clave 03026, proporcionada por CONAGUA en formato de .txt
Se análisa:
  1. **Control de calidad** sobre datos faltantes y años con datos insuficientes.
  2. **Estadística descriptiva** mensual y anual(max, min, prom y precipitación).
  3. **Análisis espectral** mediante FFT.
  4. **Visualización** de resultados en diferentes graficás.

## 2.Estructura del Archivo.
```
Proyecto_CONAGUA/
├── Lectura de archivos                     # 
├── Control de validación                   # 
├── Imputación mensual                      # 
├── Estadísticas mensuales y anuales        # 
└── FFT continuo                            #
```

## 3.Fuente de datos.
