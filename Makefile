install-nvim:
	./scripts/install_neovim.sh

install-nvim-nightly:
	./scripts/install_neovim.sh --nightly

update:
	git fetch && git pull
	./install
	nvim -c 'autocmd User PackerComplete Mason' -c 'PackerSync'
