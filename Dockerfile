# --- ETAPA 1: Compilación (Builder) ---
FROM python:3.12-slim AS builder

# Instalamos las herramientas necesarias para compilar C
RUN apt-get update && apt-get install -y --no-install-recommends \
    make \
    gcc \
    nasm \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

# Copiamos solo lo necesario para la compilación desde la carpeta iteracion-2
# Nota: Docker busca los archivos relativos al "contexto de construcción"
COPY iteracion-2/ .

# Ejecutamos el Makefile
RUN make compile

# --- ETAPA 2: Ejecución (Runtime) ---
FROM python:3.12-slim

WORKDIR /iteracion-2

# Instalamos dependencias de Python (aprovechando caché)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiamos el código fuente de Python (.py)
#COPY iteracion-2/*.py ./

# Copiamos los binarios o archivos generados en la Etapa 1 
# (Ajusta 'archivo_generado' al nombre del output de tu Makefile)
COPY --from=builder /build/ /iteracion-2/

# Configuración de Flask
EXPOSE 5000
ENV FLASK_APP=interface.py
ENV FLASK_RUN_HOST=0.0.0.0

CMD ["flask", "run"]