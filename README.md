# Análisis Espectral de la Temperatura de BCS 
Proyecto Matemáticas IV - Este proyecto va a aplicar la transformada rápida de fourier para identificar la frecuencia dominante, de los registros históricos de la tmperatura máxima de la estación climatológica **3026 (La Paz, BCS)** de la CONAGUA.

El objetivo es procesar la señal temporal para extraer componentes periódicos, con el ciclo diario de temperatura.

# Estructura 
leer_datos.m &nbsp; # Lee el archivo de texto y realiza la limpieza de datos nulos.  
main.m &nbsp;&nbsp;&nbsp; # Implementa la FFT y calcula el espectro de la magnitud.  
procesar_fft.m &nbsp;&nbsp; # Script principal que integra todo y ejecuta el análisis completo.  

dia03026.txt    # Aquí se encuentran todos los datos.

# Uso - Hacer cambios
1. **Preparación**: Asegúrate de que el archivo `dia03026.txt` esté en la carpeta `/data`.
2. **Ejecución**: Corre el script principal desde la raíz:
   *main*

# Licencia
**MIT**: Libre para uso academico y personal.
