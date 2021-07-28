" FROSTQ VIM SETTINGS
"
" TABLE OF CONTENTS:
" 1. Generic settings
" 2. Vim-Plug plugins
" 3. File settings
" e. Specific filetype settings
" 5. UI
" 6. Maps and functions

"-----------------------------------------
" 1. GENERIC SETTINGS
"-----------------------------------------
"

set nocompatible " disable vi compatibility mode
set history=1000 " increase history size

set encoding=utf-8          " always use unicode
set hidden
set foldmethod=manual       " To avoid performance issues, I never fold anything so...
set lazyredraw              " Buffer the draw of the screen to have better performance
set ttyfast                 " Set the max amount of characters to send to the terminal. Better performance

set scrolloff=8                 " Keep at least 8 lines below cursor

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

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'             " To search files like Control + P. Install ripgrep to search in files (Control + T)

Plug 'ap/vim-buftabline'            " Displays bar with open files
Plug 'mattn/emmet-vim'              " Emmet to code html
Plug 'easymotion/vim-easymotion'    " Command to move in the lines, it displays letters to move faster. Default shortcut: ,,w
Plug 'qpkorr/vim-bufkill'           " To close files without closing splitted windows. Use command :BD instead of :bd or mapping (Control + Q)
Plug 'valloric/MatchTagAlways'      " To highlight html close tag
Plug 'itchyny/lightline.vim'        " Fancy bar
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion, check coc extensions to install
Plug 'preservim/nerdcommenter'      " To comment / uncomment things. Default shortcut ,cn to comment and ,cu to uncomment

" Themes
Plug 'gruvbox-community/gruvbox'    " Color scheme
" Plug 'morhetz/gruvbox'            " Gruvbox alternative
Plug 'lifepillar/vim-solarized8'    " Solarized for light theme
" Plug 'NLKNguyen/papercolor-theme' " Another good light theme

" Language support
Plug 'sheerun/vim-polyglot'

call plug#end()

let &t_ut='' "Certain terminals change the vim color for the bg
set background=light

autocmd vimenter * ++nested colorscheme solarized8_flat

let g:lightline = { 'colorscheme': 'solarized' }

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

set ignorecase

" Display trailing whitespaces
" highlight SpecialKey ctermfg=DarkGray
" set listchars=tab:>-,trail:~
" set list
"-----------------------------------------
" 4. SPECIFIC FILETYPE SETTINGS
"-----------------------------------------

" Some programming languages work better when only 2 spaces padding is used.
autocmd BufRead,BufNewFile *.html,*.css,*.sass,*.scss,*.liquid,*.js,*.ts,*.vue,*.jsx,*.svelte setlocal shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.json setlocal shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.yaml setlocal shiftwidth=2 softtabstop=2


"-----------------------------------------
" 5. UI
"-----------------------------------------

set fillchars+=vert:\   " Remove unpleasant pipes from vertical splits
                        " Sauce on this: http://stackoverflow.com/a/9001540
set noshowmode          " We don't need to know the insert/normal mode casue we have lightline
set laststatus=2        " always show statusbar
set wildmenu            " enable visual wildmenu

set nowrap              " don't wrap long lines
set number              " show line numbers
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

" Working with buffers is cool.
map <C-d>  :bnext<CR>
map <C-a>  :bprev<CR>
imap <C-D> <Esc>:bnext<CR>a
imap <C-A> <Esc>:bprev<CR>a

" NERDTree: map ,nt for toggling NERDTree. Faster than the old :NT command
" since I don't have to hold Shift whenever I want to display NERDTree.
nmap <Leader>nt :NERDTreeToggle<cr>
map <Leader>nf :NERDTreeFind<CR>

:let g:NERDTreeWinSize=40

" Relative numbering is pretty useful for motions (3g, 5k...). However I'd
" prefer to have a way for switching relative numbers with a single map.
nmap <F5> :set invrelativenumber<CR>
imap <F5> <ESC>:set invrelativenumber<CR>a

" Fzf to search files mapped into Control + P and ignore .gitignore files
nmap <C-P> :GFiles --cached --others --exclude-standard<CR>

" Search text inside project files using Control + T
nmap <C-T> :Rg<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number -F --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--exact --delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

" Vim nerd commenter
" Add spaces after comment delimiters by default
:let g:NERDSpaceDelims=1
nmap <leader>ct <Plug>NERDCommenterToggle

" Vim easy-motion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1 " 1 will match 1 and !
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'

" Vim Coc autocompletion with tab like vscode
set updatetime=100 "Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays
" set shortmess+=c   " Don't pass messages to ins-completion-menu

" Press ,gd to go to definition
nmap <leader>gd <Plug>(coc-definition)
" Press ,gr to find references of a variable
nmap <leader>gr <Plug>(coc-references)

" Press Control + q to close file without afecting splits
nmap <C-q> :BD<cr>

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

