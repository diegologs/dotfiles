" FROSTQ VIM SETTINGS
" 
" TABLE OF CONTENTS:
" 1. Generic settings
" 2. Vim-Plug plugins
" 3. File settings
" e. Specific filetype settings
" 5. Colors and UI
" 6. Maps and functions

"-----------------------------------------
" 1. GENERIC SETTINGS
"-----------------------------------------
"
source $VIMRUNTIME/mswin.vim " enable default windows settings like Ctrl - C and Ctrl - V

set nocompatible " disable vi compatibility mode
set history=1000 " increase history size

"-----------------------------------------
" 2. VIM-PLUG PLUGINS
"-----------------------------------------

" Init vim-plug
if has("win32") || has("win64")
    call plug#begin('$USERPROFILE/vimfiles/plugged/')
else
    call plug#begin('~/.vim/plugged/')
end

" Plug-ins
Plug 'scrooloose/nerdtree'          " Sidebar to display project structure
Plug 'ctrlpvim/ctrlp.vim'           " To search files with name, default shorcut: Ctrl + P, changed to Ctrl + T
Plug 'ap/vim-buftabline'            " Displays bar with open files  
Plug 'mattn/emmet-vim'              " Emmet to code html
Plug 'easymotion/vim-easymotion'    " Command to move in the lines, it displays letters to move faster. Default shortcut: ,,w
Plug 'qpkorr/vim-bufkill'           " To close files without closing splitted windows
Plug 'valloric/MatchTagAlways'      " To highlight html close tag
Plug 'vim-airline/vim-airline'      " Fancy bar
Plug 'mileszs/ack.vim'              " To make global searchs. Use command :Ack and install ack in the system
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion, check coc extensions to install

Plug 'gruvbox-community/gruvbox'    " Color scheme

" Language support
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-endwise'
Plug 'sheerun/vim-polyglot'

call plug#end()

colorscheme gruvbox

"-----------------------------------------
" 3. FILE SETTINGS
"-----------------------------------------

" Stop creating backup files, please use Git for backups

set nobackup       
set nowritebackup   
set noswapfile     

set backspace=indent,eol,start 

" Modify indenting settings
"
set autoindent              " autoindent always ON.
set expandtab               " expand tabs
set shiftwidth=4            " spaces for autoindenting
set softtabstop=4           " remove a full pseudo-TAB when i press <BS>

" Modify some other settings about files
set encoding=utf-8          " always use unicode 
set hidden

set ignorecase

"-----------------------------------------
" 4. SPECIFIC FILETYPE SETTINGS
"-----------------------------------------

" Some programming languages work better when only 2 spaces padding is used.
autocmd BufRead,BufNewFile *.html,*.css,*.sass,*.scss,*.js,*.ts,*.vue,*.jsx,*.svelte setlocal shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.json setlocal shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.yaml setlocal shiftwidth=2 softtabstop=2


"-----------------------------------------
" 5. COLORS AND UI
"-----------------------------------------

set fillchars+=vert:\   " Remove unpleasant pipes from vertical splits
                        " Sauce on this: http://stackoverflow.com/a/9001540

set showmode            " always show which more are we in
set laststatus=2        " always show statusbar
set wildmenu            " enable visual wildmenu

set nowrap              " don't wrap long lines
set number              " show line numbers
set relativenumber      " show numbers as relative by default
set showmatch           " higlight matching parentheses and brackets


"-----------------------------------------
" 6. MAPS AND FUNCTIONS
"-----------------------------------------

let mapleader=","

" Make window navigation less painful.
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

" Working with buffers is cool.
set hidden
map <C-d>  :bnext<CR>
map <C-a>  :bprev<CR>
imap <C-D> <Esc>:bnext<CR>a
imap <C-A> <Esc>:bprev<CR>a

" NERDTree: map ,nt for toggling NERDTree. Faster than the old :NT command
" since I don't have to hold Shift whenever I want to display NERDTree.
nmap <Leader>nt :NERDTreeToggle<cr>
:let g:NERDTreeWinSize=40

" Relative numbering is pretty useful for motions (3g, 5k...). However I'd
" prefer to have a way for switching relative numbers with a single map.
nmap <F5> :set invrelativenumber<CR>
imap <F5> <ESC>:set invrelativenumber<CR>a

" Vim easy-motion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1 " 1 will match 1 and !
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'

" Vim Coc autocompletion with tab like vscode

" Press ,gd to go to definition
nmap <leader>gd <Plug>(coc-definition) 
" Press ,gr to find references of a variable
nmap <leader>gr <Plug>(coc-references)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ?
      \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_snippet_next = '<tab>'

behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
