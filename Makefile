IMAGE ?= sdc-tp2
CONTAINER ?= sdc-tp2
PORT ?= 5000

.PHONY: build run stop rm logs rebuild

build:
	docker build -t $(IMAGE) .

run:
	docker run --rm -it -p $(PORT):5000 --name $(CONTAINER) $(IMAGE)

stop:
	docker stop $(CONTAINER)

rm:
	docker rm -f $(CONTAINER)

logs:
	docker logs -f $(CONTAINER)

rebuild:
	-docker rm -f $(CONTAINER)
	docker build --no-cache -t $(IMAGE) .
