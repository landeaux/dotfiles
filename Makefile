.PHONY: install-nvim
install-nvim:
	./scripts/install_neovim.sh

.PHONY: install-nvim
install-nvim-nightly:
	./scripts/install_neovim.sh --nightly

.PHONY: install-nvim
update:
	git fetch && git pull
	./install
	nvim -c 'autocmd User PackerComplete Mason' -c 'PackerSync'
