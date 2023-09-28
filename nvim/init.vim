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

" No swap files pls, use git
set noswapfile
set nobackup

" Load the colorscheme
" colorscheme tokyonight-night

" Load light colorscheme
" colorscheme solarized

" Treat this extensions as html
autocmd BufNewFile,BufRead *.liquid set filetype=html
autocmd BufNewFile,BufRead *.njk set filetype=html

" Enables cursor line position tracking:
set cursorline
" Removes the underline causes by enabling cursorline:
highlight clear CursorLine
" Sets the line numbering to red background:
highlight CursorLineNR ctermbg=green

" Ident with two spaces
set shiftwidth=2
set softtabstop=2

" .njk files as html
au BufReadPost *.njk set syntax=html

" No ident for svelte files
let g:svelte_indent_script = 0
let g:svelte_indent_style = 0

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"---------------------------
" Keybindings
"----------------------------

let mapleader = ","

" Snippet for console.log
nmap <leader><leader>c oconsole.log();<Esc>==0f(a

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

set hidden

" Move up/down in wrapped lines by display lines
noremap <silent> <Up> gk
noremap <silent> <Down> gj

noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

onoremap <silent> j gj
onoremap <silent> k gk

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

" Tree file explorer on the side
nmap <Leader>nt :NvimTreeToggle<cr>
map <Leader>nf :NvimTreeFindFile<CR>

" Move halfpages instead of one page
nnoremap <C-f> <C-d> zz
nnoremap <C-b> <C-u> zz

" Telescope
" nmap <C-P> :Telescope git_files hidden=true <CR>
" nmap <Leader>pf :Telescope find_files hidden=true <CR>
" nmap <C-T> :Telescope live_grep <CR>
" nmap <C-Y> :Telescope coc document_symbols <CR>
" nmap <C-U> :Telescope buffers <CR>

" Relative numbering is pretty useful for motions (3g, 5k...). However I'd
" prefer to have a way for switching relative numbers with a single map.
nmap <F5> :set invrelativenumber<CR>
imap <F5> <ESC>:set invrelativenumber<CR>a


" FZF
let g:fzf_layout = { 'down':  '40%'}

" Fzf to search files mapped into Control + P and ignore .gitignore files
nmap <C-P> :GFiles --cached --others --exclude-standard<CR>
nmap <C-U> :Buffers<CR>

" Search text inside project files using Control + T
nmap <C-T> :Rg<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


" nvim-coc config
"
let g:coc_global_extensions = ['coc-json', 'coc-html', 'coc-tsserver', 'coc-css', 'coc-emmet']

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Coc rename
nmap <leader>rn <Plug>(coc-rename)

" Coc GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Detele trailing spaces on save
augroup CODING_POTIONS
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

