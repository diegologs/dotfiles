" FROSTQ VIM SETTINGS
" 
" TABLE OF CONTENTS:
" 1. Generic settings
" 2. Vim-Plug plugins
" 3. File settings
" 4. Specific filetype settings
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
    
" Language support
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-endwise'
Plug 'sheerun/vim-polyglot'

call plug#end()

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

"-----------------------------------------
" 4. SPECIFIC FILETYPE SETTINGS
"-----------------------------------------

" Some programming languages work better when only 2 spaces padding is used.
autocmd FileType html,css,sass,scss,javascript setlocal sw=2 sts=2
autocmd FileType json setlocal sw=2 sts=2
autocmd FileType ruby,eruby setlocal sw=2 sts=2
autocmd FileType yaml setlocal sw=2 sts=2


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

" Move CtrlP to CtrlT (CtrlP is for buffers)
let g:ctrlp_map = '<C-t>'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

" Working with buffers is cool.
set hidden
map <C-N>  :bnext<CR>
map <C-P>  :bprev<CR>
imap <C-N> <Esc>:bnext<CR>a
imap <C-P> <Esc>:bprev<CR>a

" NERDTree: map ,nt for toggling NERDTree. Faster than the old :NT command
" since I don't have to hold Shift whenever I want to display NERDTree.
nmap <Leader>nt :NERDTreeToggle<cr>
:let g:NERDTreeWinSize=40

" Relative numbering is pretty useful for motions (3g, 5k...). However I'd
" prefer to have a way for switching relative numbers with a single map.
nmap <F5> :set invrelativenumber<CR>
imap <F5> <ESC>:set invrelativenumber<CR>a

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
