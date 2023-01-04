.PHONY: install-nvim
install-nvim:
	./scripts/install_neovim.sh

.PHONY: install-nvim-nightly
install-nvim-nightly:
	./scripts/install_neovim.sh --nightly

.PHONY: update
update:
	git fetch && git pull
	./install
	nvim -c 'autocmd User PackerComplete Mason' -c 'PackerSync'
