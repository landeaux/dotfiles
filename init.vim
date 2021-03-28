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

" Syntax highlighting
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} " Python
Plug 'pangloss/vim-javascript' " Javascript
Plug 'posva/vim-vue' " Vue.js

Plug 'stsewd/fzf-checkout.vim' " fuzzy git checkout
Plug 'neoclide/coc.nvim', {'branch': 'release'} " CoC
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'scrooloose/nerdtree' " File explorer
Plug 'scrooloose/nerdcommenter' " Easy Commenting
Plug 'Vimjas/vim-python-pep8-indent' " Indentation
Plug 'vim-airline/vim-airline' " Status bar plugin
Plug 'jiangmiao/auto-pairs' " Automatic quote and bracket completion
Plug 'tpope/vim-fugitive' " Git integration

" should always be last
Plug 'ryanoasis/vim-devicons' " Icons in file explorer

call plug#end()

let mapleader = " "

" SET PYTHON ENVIRONMENT

let g:python_host_prog = $HOME . "/.pyenv/versions/neovim-python2/bin/python"
let g:python3_host_prog = $HOME . "/.pyenv/versions/neovim-python3/bin/python"


" ENABLING THEME SUPPORT

if (has("termguicolors"))
  set termguicolors
endif


" THEME

syntax enable
"colorscheme dracula
colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard"
set background=dark
hi! link javaScript             GruvboxBlue
hi! link jsExportDefault        GruvboxBlue
hi! link jsImport               GruvboxBlue
hi! link jsFrom                 GruvboxBlue
hi! link jsObjectKey            GruvboxBlue
hi! link jsObjectProp           GruvboxBlue
hi! link jsExport               GruvboxRedBold
hi! link jsObjectFuncName       GruvboxBlueBold
hi! link jsFuncCall             GruvboxBlueBold
hi! link jsVariableDef          GruvboxFg1
hi! link jsDestructuringBlock   GruvboxFg1
hi! link jsObjectShorthandProp  GruvboxFg1
hi! link jsFuncArgs             GruvboxFg1
hi! link htmlH2                 GruvboxFg1
hi! link jsBrackets             GruvboxFg4
hi! link jsObjectBraces         GruvboxFg4
hi! link jsFuncBraces           GruvboxFg4
hi! link Normal                 GruvboxFg4
hi! link Noise                  GruvboxFg4

" COC SETTINGS

"" TextEdit might fail if hidden is not set.
set hidden

"" Some servers have issues with backup files, see https://github.com/neoclide/coc.nvim/issues/649
set nobackup
set nowritebackup

"" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

"" Always show the signcolumn, otherwise it would shift the text each time
"" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

"" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"" Make <CR> auto-select the first completion item and notify coc.nvim to
"" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"" Use `[g` and `]g` to navigate diagnostics
"" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"" Symbol renaming.
nmap <leader>n <Plug>(coc-rename)

"" Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

"" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

"" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

"" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

"" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

"" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" Show diagnostics list
nnoremap <silent><nowait> <leader>d :<C-u>CocList diagnostics<cr>

"" Manage extensions
nnoremap <silent><nowait> <leader>e :<C-u>CocList extensions<cr>

"" Show commands
nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>

"" Find symbol of current document
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>

"" Search workspace symbols
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>

"" Do default action for next item
nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>

"" Do default action for previous item
nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>

"" Resume latest coc list
nnoremap <silent><nowait> <leader>r  :<C-u>CocListResume<CR>

"" Define global extensions/language servers
let g:coc_global_extensions = [
  \ 'coc-python',
  \ 'coc-yaml',
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-vetur',
  \ ]


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

"" open terminal on ctrl+j
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


" FZF

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

"" file searching
nnoremap <C-p> :FZF<CR>

"" text search
nnoremap <leader>f :Ag<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

"" ignore node_modules
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"" order results from top to bottom
let $FZF_DEFAULT_OPTS='--reverse'


" FUGITIVE

"" easy git checkout
nnoremap <leader>gc :GCheckout<CR>

"" project file search with display window
nnoremap <leader>p :GFiles<CR>


" NERD COMMENTER SETTINGS

"" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 0


" MISCELLANEOUS SETTINGS

filetype plugin on

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

"" add custom filetype mappings
autocmd BufRead,BufNewFile .env.* set filetype=sh
autocmd BufRead,BufNewFile .gitconfig.local set filetype=gitconfig
autocmd BufRead,BufNewFile .pylintrc set filetype=conf
autocmd BufRead,BufNewFile .tmux.conf.local set filetype=tmux
autocmd BufRead,BufNewFile .zshrc.local set filetype=sh
autocmd BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
autocmd BufRead,BufNewFile gitconfig set filetype=gitconfig
autocmd BufRead,BufNewFile gitignore set filetype=conf

"" prevent Python auto indent when pressing colon (:) key
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:

"" editing and reloading this file
nmap <leader>M :e ~/.config/nvim/init.vim<CR>
nmap <leader>R :source ~/.config/nvim/init.vim<CR>

"" enable hybrid line numbers
set number relativenumber
set nu rnu

"" easy new tab open
nmap <leader>t :tabnew

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

"" toggle search highlighting
nnoremap <leader>h :set hlsearch!<CR>
