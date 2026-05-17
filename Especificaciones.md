# Especificación: Análisis Climatológico y Espectral

## Estación La Paz, BCS — CONAGUA 03026

**Curso:** Matemáticas IV — Departamento Académico de Sistemas Computacionales (DASC), UABCS  

---

## 1. Propósito

Procesar, limpiar y analizar estadísticamente la serie de registros diarios históricos
de temperatura y precipitación de la estación **La Paz (OBS), BCS (clave 03026)**,
proporcionada por CONAGUA en formato de texto plano.

El análisis aplica:
1. **Control de calidad** sobre datos faltantes y años con cobertura insuficiente.
2. **Estadística descriptiva** mensual y anual (Tmax, Tmin, Tprom, precipitación).
3. **Análisis espectral** mediante FFT sobre serie temporal continua interpolada.
4. **Visualización** de resultados en cuatro figuras complementarias.

---

## 2. Estructura del proyecto

```
Proyecto_Clima/
├── dia03026.txt               # Base de datos CONAGUA (no se modifica)
└── analisis_climatologico.m   # Script principal (único archivo de código)
```

---

## 3. Fuente de datos

| Campo | Valor |
|-------|-------|
| Archivo | `dia03026.txt` |
| Fuente | CONAGUA — Base de Datos Climatológica Nacional |
| Estación | 03026 — La Paz (OBS) |
| Período | Febrero 1943 – Febrero 2026 |
| Total de registros | 11,143 días |

---

## 4. Preprocesamiento

### Lectura del archivo
```octave
fid = fopen('dia03026.txt', 'r');
datos = textscan(fid, '%s %s %s %s %s', 'HeaderLines', 25, 'Delimiter', '\t');
fclose(fid);
```

### Parseo de fechas y clave mes-año
Las fechas se parsean celda por celda sobre la matriz producida por `char(fechas_str)`.
Los registros con fecha malformada se descartan antes de cualquier cálculo.

Para agrupar sin errores de precisión flotante se define la clave entera:
$$\text{clave}(a, m) = a \times 100 + m$$

Ejemplo: julio de 1998 → $199807$.

---

## 5. Control de calidad
Un año es **válido** para análisis gráfico si cumple simultáneamente:

$$\frac{N_{\text{días con dato real}}^{(a)}}{N_{\text{días registrados}}^{(a)}} \geq 0.70 \qquad \text{y} \qquad N_{\text{días registrados}}^{(a)} \geq 300$$

Este cálculo se realiza **antes** de imputar valores faltantes.

| Parámetro | Valor |
|-----------|-------|
| `umbral_pct` | 0.70 |
| `umbral_dias` | 300 |

Los años inválidos se marcan con `*` en la tabla de consola y se grafican como
puntos grises punteados en la figura anual. Se excluyen de las gráficas mensuales
y del climograma.

---

## 6. Imputación de valores faltantes
- **Tmax y Tmin:** los `NaN` se sustituyen por la media del mismo mes-año al
  que pertenece el día. Si el mes-año completo está vacío, se usa la media global.
- **Precipitación y evaporación:** los `NaN` se sustituyen por `0`.
- **Temperatura promedio diaria:** $T_{\text{prom}} = (T_{\max} + T_{\min}) / 2$,
  calculada después de la imputación.

---

## 7. Estadísticas calculadas
### Agrupación mensual

| Variable | Cálculo |
|----------|---------|
| `Tmax_mensual` | `max(Tmax)` |
| `Tmin_mensual` | `min(Tmin)` |
| `Tprom_mensual` | `mean(Tprom)` |
| `Prec_mensual` | `sum(Precip)` |

### Agrupación anual

| Variable | Cálculo |
|----------|---------|
| `Tmax_anual` | `max(Tmax)` |
| `Tmin_anual` | `min(Tmin)` |
| `Tprom_anual` | `mean(Tprom)` |
| `Prec_anual` | `sum(Precip)` |

El climograma usa el promedio histórico de cada mes calendario, 
calculado únicamente sobre meses pertenecientes a años válidos.

---

## 8. Análisis espectral
La base de datos presenta años completos sin registros. Aplicar la FFT
directamente sobre los datos disponibles produce un ciclo detectado de ≈ 348 días
en lugar de los 365.25 esperados, porque los huecos comprimen el eje temporal.

**Solución:** se construye una serie diaria continua desde el primer hasta el
último día del registro, interpolando los huecos linealmente. Esta serie se
usa solo para el FFT, no para las estadísticas descriptivas.

Antes de aplicar la FFT se elimina la tendencia lineal con `detrend()` para
evitar que el calentamiento histórico enmascare el ciclo anual en el espectro.

La búsqueda del ciclo dominante se restringe a la ventana:

$$f \in \left(\frac{1}{600\,\text{días}},\; \frac{1}{60\,\text{días}}\right) \text{ ciclos/día}$$

---

## 9. Visualizaciones
El script genera exactamente **cuatro figuras**:

| Figura | Contenido |
|--------|-----------|
| 1 — Análisis espectral | Panel superior: serie Tmax diaria + tendencia. Panel inferior: espectro de potencia con ciclo dominante anotado. |
| 2 — Evolución mensual | Tmax, Tmin y Tprom mensual solo de años válidos, con área sombreada y tendencia. |
| 3 — Climograma | Panel superior: ciclo anual típico de temperatura. Panel inferior: precipitación media mensual con el mes más lluvioso resaltado. Ejes sincronizados con `linkaxes`. |
| 4 — Estadísticas anuales | Panel superior: Tprom de todos los años (válidos en negro, inválidos en gris). Panel inferior: rango Tmax–Tmin solo de años válidos. Ejes sincronizados con `linkaxes`. Eje X cada 5 años. |

---

## 10. Restricciones de implementación

| Elemento | Permitido | No permitido |
|----------|-----------|--------------|
| Parseo de fechas | `char()` + bucle celda por celda | `str2num` sobre matriz completa |
| Doble eje Y | Dos subplots con `linkaxes` | `yyaxis` (no disponible en Octave) |
| Ubicación de leyenda | `'northeast'`, `'northwest'` | `'best'` (no disponible en Octave) |
| Imputación de temperatura | Media del mes-año correspondiente | Media global directa |
| Serie para FFT | Serie continua interpolada | Índice de posición como eje temporal |

---

## 11. Entregables

1. Archivo `analisis_climatologico.m` ejecutable sin modificaciones.
2. Archivo `dia03026.txt` en el mismo directorio de trabajo.
3. Reporte técnico en Markdown (`REPORTE.md`) que incluya:
   - Lectura de la gráfica FFT: ¿qué ciclo se detecta y qué significa físicamente?
   - Análisis de la tendencia de calentamiento: tasa, cambio total e interpretación.
   - Capturas de pantalla de las cuatro figuras generadas.

---
