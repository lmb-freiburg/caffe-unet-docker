SHELL:=/bin/bash
basename:=lmb-unet-server

default: bin

.PHONY: bin

bin:
	docker build -f Dockerfile-$@ -t $(basename) .

src:
	docker build -f Dockerfile-$@ -t $(basename)-src .
