" General Vim config
set shiftwidth=2
set softtabstop=2
set number
set nobackup
set nowritebackup
set noswapfile
set ruler
set showcmd
set incsearch
set autowrite

let mapleader = ","

" Split edit your vimrc. Type space, v, r in sequence to trigger
nmap <leader>vr :vsp $MYVIMRC<cr>
" Source (reload) your vimrc. Type space, s, o in sequence to trigger
nmap <leader>so :source $MYVIMRC<cr>

" Move to start of first non-whitespace character
nmap <leader>0 ^

" Copy entire buffer into system clipboard
nmap <leader>co ggVG*y

" Move up and down by visible lines if current line is wrapped
nmap j gj
nmap k gk

" Quick exit from insert mode
imap jk <esc>
imap kj <esc>

" Command aliases for typoed commands (accidentally holding shift too long)
command! Q q " Bind :Q to :q
command! Qall qall
command! QA qall
command! E e

" Bind `q` to close the buffer for help files
autocmd Filetype help nnoremap <buffer> q :q<CR>

syntax on
colorscheme cosme

" VimTest remappings
nmap <leader>tt :TestFile<cr>
nmap <leader>ty :TestSuite<cr>

" Ctrl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = 'ag %s -l --hidden --ignore-dir .git --nocolor -g ""'
let g:ctrlp_use_caching = 0

" Ctrl-SF
nmap <c-f> <Plug>CtrlSFPrompt

" Ale config
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'typescript': ['prettier']}
let g:ale_fix_on_save = 1

" Airline
let g:airline_theme = 'dracula'
let g:airline_section_y = ''
let g:airline_section_x = ''
let g:airline_section_warning = ''
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#branch#enabled = 1
set laststatus=2 " for airline


" Check if vim-plug is installed and if not, install it!
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Check if the_silver_searcher is installed and if not, install it!
if empty(glob('/usr/local/Cellar/the_silver_searcher'))
  silent !brew install the_silver_searcher
endif

function! BuildVimProc(info)
if a:info.status == 'installed' || a:info.force
    make
  endif
endfunction

" vim-plug settings
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'janko-m/vim-test'
Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'raimondi/delimitmate'
Plug 'dyng/ctrlsf.vim'
Plug 'quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'Shougo/vimproc.vim', { 'do': function('BuildVimProc')}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


" coc config


" coc-vim config

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Coc Configuration
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-git',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-lists',
  \ 'coc-tsserver',
  \ 'coc-yaml'
\ ]