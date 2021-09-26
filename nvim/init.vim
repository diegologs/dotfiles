lua require('plugins')

"------------------------
" General options
"----------------------------

set lazyredraw
set ttyfast

set number relativenumber   " Relative numbers for jumping
set nu rnu                  " Hybrid numbers, you have relative numbers and the current line number

set autoindent              " autoindent always ON.
set expandtab               " expand tabs
set shiftwidth=4            " spaces for autoindenting
set softtabstop=4           " remove a full pseudo-TAB when i press <BS>

set scrolloff=8             " Keep at least 8 lines below cursor
set foldmethod=manual       " To avoid performance issues, I never fold anything so...
set noshowmode              " We don't need to know the insert/normal mode casue we have lualine

set ignorecase
set nohlsearch              " Clear search highlights

set splitbelow splitright   " Set the splits to open at the right side and below

" Load the colorscheme
colorscheme tokyonight

" Enables cursor line position tracking:
set cursorline
" Removes the underline causes by enabling cursorline:
highlight clear CursorLine
" Sets the line numbering to red background:
highlight CursorLineNR ctermbg=green

" Some programming languages work better when only 2 spaces padding is used.
autocmd BufRead,BufNewFile *.html,*.css,*.sass,*.scss,*.js,*.ts,*.vue,*.jsx,*.svelte setlocal shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.json setlocal shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.yaml,*.yml setlocal shiftwidth=2 softtabstop=2

"---------------------------
" Keybindings
"----------------------------

let mapleader = ","

" Snippet for console.log
nmap <leader><leader>c oconsole.log({});<Esc>==f{a

" To avoid undo points when using arrow keys
inoremap <Left> <c-g>U<Left>
inoremap <Right> <c-g>U<Right>

" Whit leader p you can delete things without saving to register so you can
" paste what you have before
vnoremap <leader>p "_d

" Make window navigation less painful.
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Working with buffers is cool.
set hidden
map <C-d>  :bnext<CR>
map <C-a>  :bprev<CR>
imap <C-D> <Esc>:bnext<CR>a
imap <C-A> <Esc>:bprev<CR>a

" To resize window height
nnoremap <silent> <Leader>h+ :exe "resize " . (winheight(0) * 5/4)<CR>
nnoremap <silent> <Leader>h- :exe "resize " . (winheight(0) * 4/5)<CR>

" To resize window width
nnoremap <silent> <Leader>w+ :exe "vertical resize " . (winwidth(0) * 5/4)<CR>
nnoremap <silent> <Leader>w- :exe "vertical resize " . (winwidth(0) * 4/5)<CR>

" Capital Y to copy to the end of the line like C or D
nnoremap Y y$

" To move in the search list but keeping the cursor in the middle of screen
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv

" To close buffer without closing splits
nnoremap <silent> <C-q> :lclose<bar>b#<bar>bd #<CR>

" To comment lines
nmap <Leader>t :CommentToggle<cr>
vmap <Leader>t :CommentToggle<cr>

" NERDTree: map ,nt for toggling NERDTree. Faster than the old :NT command
" since I don't have to hold Shift whenever I want to display NERDTree.
nmap <Leader>nt :NERDTreeToggle<cr>
map <Leader>nf :NERDTreeFind<CR>

" Telescope
nmap <C-P> :Telescope git_files hidden=true <CR>
nmap <C-T> :Telescope live_grep <CR>

" Relative numbering is pretty useful for motions (3g, 5k...). However I'd
" prefer to have a way for switching relative numbers with a single map.
nmap <F5> :set invrelativenumber<CR>
imap <F5> <ESC>:set invrelativenumber<CR>a

" Vim coc
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

" Vim sneak
let g:sneak#label = 1

" Detele trailing spaces on save
augroup CODING_POTIONS
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END
