IMAGE ?= sdc-tp2
CONTAINER ?= sdc-tp2
PORT ?= 5000

.PHONY: build run stop rm logs rebuild

build:
	docker build -t $(IMAGE) .

run:
	docker run -d -it -p $(PORT):5000 --name $(CONTAINER) $(IMAGE)

stop:
	docker stop $(CONTAINER)

rm:
	docker rm -f $(CONTAINER)

logs:
	docker logs -f $(CONTAINER)

rebuild:
	-docker rm -f $(CONTAINER)
	docker build --no-cache -t $(IMAGE) .

help:
	@echo "Opciones disponibles:"
	@echo "  make install  - Instala Docker, Docker Compose y configura el usuario"
	@echo "  make clean    - Desinstala Docker y elimina archivos de configuración"