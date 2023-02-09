SHELL:=/bin/bash
basename:=lmb-unet

default: bin

.PHONY: bin

bin:
	docker build -f Dockerfile-$@ -t $(basename)-server .

src:
	docker build -f Dockerfile-$@ -t $(basename)-server-src .

local:
	docker build -f Dockerfile-$@ -t $(basename)-local .