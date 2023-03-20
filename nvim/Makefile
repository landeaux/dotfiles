all: build attach

.PHONY: build
build:
	docker build -t my_neovim .

.PHONY: attach
attach:
	docker run -it --rm my_neovim

.PHONY: format
format:
	stylua .
