" PLUG

"" automatic installation of vim plugin manager Plug
"" note: must be placed before plug#begin() call
"" repo: https://github.com/junegunn/vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin("~/.vim/plugged")

"" Themes
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'

"" File search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Auto completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

" Function signatures
Plug 'Shougo/echodoc.vim'

Plug 'davidhalter/jedi-vim' " Code jump (go-to) plugin
Plug 'scrooloose/nerdtree' " File explorer
Plug 'scrooloose/nerdcommenter' " Easy Commenting
Plug 'sheerun/vim-polyglot' " Syntax Highlighting
Plug 'dense-analysis/ale' " Linting/Formatting
Plug 'Vimjas/vim-python-pep8-indent' " Indentation
Plug 'vim-airline/vim-airline' " Status bar plugin
Plug 'jiangmiao/auto-pairs' " Automatic quote and bracket completion
Plug 'tpope/vim-fugitive' " Git integration

" should always be last
Plug 'ryanoasis/vim-devicons' " Icons in file explorer

call plug#end()


" SET PYTHON ENVIRONMENT

let g:python_host_prog = $HOME . "/.pyenv/versions/neovim-python2/bin/python"
let g:python3_host_prog = $HOME . "/.pyenv/versions/neovim-python3/bin/python"


" CUSTOM MAPPINGS

"" editing and reloading this file
map <leader>M :tabnew ~/.config/nvim/init.vim<CR>
map <leader>R :source ~/.config/nvim/init.vim<CR>


" ENABLING THEME SUPPORT

if (has("termguicolors"))
  set termguicolors
endif


" THEME

syntax enable
colorscheme dracula
" colorscheme gruvbox


" NERDTREE SETTINGS

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

"" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" Toggle
nnoremap <silent> <C-n> :NERDTreeToggle<CR>


" INTEGRATED TERMINAL

"" open new split panes to right and below
set splitright
set splitbelow

"" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

"" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

"" open terminal on ctrl+b
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <C-j> :call OpenTerminal()<CR>


" SWITCHING BETWEEN PANELS

"" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l<Paste>


" FILE SEARCHING

nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

"" ignore node_modules
let $FZF_DEFAULT_COMMAND = 'ag -g ""'


" NERD COMMENTER SETTINGS

filetype plugin on

"" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 0


"" ALE SETTINGS

let g:ale_list_window_size = 4
let g:ale_sign_column_always = 0
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0

"" options are in .pylintrc
highlight VertSplit ctermbg=253

let g:ale_sign_error = '‼'
let g:ale_sign_warning = '∙'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = '1'
let g:ale_lint_on_save = '1'
let g:ale_linters = {
    \    'python': ['pylint'],
    \}
let g:ale_fixers = {
    \    'python': ['autopep8'],
    \}
let g:ale_fix_on_save = '1'

" map Ctrl-E and Ctrl-e to moving between errors
nmap <silent> <leader>[ <Plug>(ale_previous_wrap)
nmap <silent> <leader>] <Plug>(ale_next_wrap)

" DEOPLETE OPTIONS

let g:deoplete#enable_at_startup = 1

" close preview window automatically
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" navigate through auto-completion list with Tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" ECHODOC SETTINGS

let g:echodoc#enable_at_startup = 1

"" use neovim's floating text feature
let g:echodoc#type = 'floating'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu


" JEDI-VIM OPTIONS

"" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 1

"" open the go-to function in split, not another buffer
"" options: top, left, right, bottom or winwidth
let g:jedi#use_tabs_not_buffers = 1

"" put call signatures in command line
let g:jedi#show_call_signatures = 0


" MISCELLANEOUS SETTINGS

"" enable hybrid line numbers
set number relativenumber
set nu rnu

"" easy new tab open
map <leader>t :tabnew 

"" toggle visibility of whitespace characters
set nolist
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¬,precedes:«,extends:»
map <leader>l :set list!<CR>

"" indentation rules
" au BufNewFile,BufRead *.py
"     \ set expandtab        " replace tabs with spaces
"     \ set autoindent       " copy indent when starting a new line
"     \ set tabstop=4
"     \ set softtabstop=4
"     \ set shiftwidth=4

"" show column guide
let &colorcolumn = join(range(80,999), ',')

"" wiping the register
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
autocmd VimEnter * WipeReg  " wipe registers when starting up (n)vim

"" prevent Python auto indent when pressing colon (:) key
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:
