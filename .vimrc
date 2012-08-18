" .vimrc Andreas Paul@pp
syntax on
" Python ***********************************
"set autoindent
"set tags+=$HOME/.vim/tags/python.ctags
set smarttab
set expandtab
set smartindent
set shiftwidth=2
set showmatch  " Show matching brackets.
"set gtl=%t gtt=%F
" 256 colors *******************************

" Sessions *********************************
" Sets what is saved when you save a session

"au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4
"au BufRead,BufNewFile *.py,*.pyw set expandtab
"au BufRead,BufNewFile *.c,*.h set noexpandtab
"au BufRead,BufNewFile Makefile* set noexpandtab
"au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79
"au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"highlight BadWhitespace ctermbg=red guibg=red

" Auto Folding for python *******************
"au BufRead,BufNewFile *.py,*.pyw let b:folded = 0

" Taglist ***********************************
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_Use_SingleClick = 1

" NERDTree **********************************
let NERDTreeMouseMode=1 " Single click for everything

" gVIM ***************************************
set guioptions-=T  " remove toolbar

" Searching **********************************
set hlsearch " highlight search
set incsearch " incremental search, search as you type
set ignorecase " Ignore case when searching
set smartcase " Ignore case when searching lowercase
"set backup " xemacs like file backup

" Key mappings *********************************
filetype plugin on
color paul
"colorscheme solarized
"chdir ~
set background=dark
set gdefault "always use global in search and replace vim syntax s///g
set pastetoggle=<F6> "toggle :paste and :nopaste
set noerrorbells visualbell t_vb= "disable bell
set modeline "read modeline if available
set modelines=5
"set nu
" Firefox style
map <C-T> :tabnew<CR>
nnoremap <A-x> <Esc>:tabnext<CR>
nnoremap <A-z> <Esc>:tabprev<CR>
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <A-0> 10g
map <silent><A-Right> :tabnext<CR>
map <silent><A-Left> :tabprevious<CR> 
nnoremap <silent> <S-F> :call ToggleFold()<CR>
nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F9> :NERDTreeToggle<CR>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" It clears the search buffer when you press ,/
nmap <silent> ,/ :nohlsearch<CR>

nnoremap ; : " use ; instead of :
" disable cursor keys ***********************
"noremap  <Up> ""
"noremap! <Up> <Esc>
"noremap  <Down> ""
"noremap! <Down> <Esc>
"noremap  <Left> ""
"noremap! <Left> <Esc>
"noremap  <Right> ""
"noremap! <Right> <Esc>
"make it possible to pipe a file to sudo so it can be save
cmap w!! %!sudo tee > /dev/null % 

" Functions ************************************
iabbrev xxsig <Esc>:r ![ -n "PAULA" ] && echo "PAULA `date '+\%Y-\%m-\%d \%H:\%M'`" \|\| echo "PAULA `date '+\%Y-\%m-\%d \%H:\%M'`"<CR>I<BS><Esc>A
"
" --- Folding Options

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" automatically fold code depending on indent
"set foldmethod=indent
" the methods of classes are folded, but internal statements aren't. 
set foldnestmax=2
set fillchars=vert:\|,fold:\ ,diff:-
set laststatus=2
set statusline=%<%f\ %h%w%m%r%y%=L:%l/%L\ (%p%%)\ C:%c%V

" open/close folds with tab
map <TAB> za
