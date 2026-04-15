# 1. Usamos una imagen ligera de Python como base
FROM python:3.12-slim

# 2. Establecemos el directorio de trabajo dentro del contenedor
WORKDIR /app

# 3. Copiamos el archivo de requerimientos primero para aprovechar la caché de Docker
# (Asegúrate de crear un archivo requirements.txt con la palabra 'Flask')
COPY requirements.txt .

# 4. Instalamos las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiamos el resto del código de tu proyecto
COPY iteracion-1 .

# 6. Exponemos el puerto que usa Flask por defecto
EXPOSE 5000

# 7. Definimos la variable de entorno para que Flask sea visible externamente
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# 8. Comando para ejecutar la aplicación
CMD ["flask", "run"]