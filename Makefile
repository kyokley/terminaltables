shell: build
	docker run --rm -it -v $$(pwd):/code kyokley/terminaltables /bin/sh

build:
	docker build -t kyokley/terminaltables .
