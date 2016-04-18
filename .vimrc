" .vimrc Andreas Paul@pp
execute pathogen#infect()

syntax on
" Python ***********************************
"set autoindent
"set tags+=$HOME/.vim/tags/python.ctags
set tabstop=2
set softtabstop=2
set smarttab
set expandtab
set smartindent
set shiftwidth=2
set showmatch  " Show matching brackets.
set gtl=%t gtt=%F
" 256 colors *******************************

" Sessions *********************************
" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
" Afterwards, add the main function that restores the cursor position and its autocmd so that it gets triggered 
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Python stuff ******************************
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=2
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.c,*.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix
autocmd FileType python set omnifunc=pythoncomplete#Complete
highlight BadWhitespace ctermbg=red guibg=red

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
nnoremap <silent> <F1> :GoBuild<CR>:GoRun<CR>
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
iabbrev xxsig <Esc>:r ![ -n "ANDPAUL" ] && echo "Andreas (ANDPAUL) Paul `date '+\%Y-\%m-\%d \%H:\%M'`" \|\| echo "Andreas (ANDPAUL) Paul `date '+\%Y-\%m-\%d \%H:\%M'`"<CR>I<BS><Esc>A
iabbrev xxhead <Esc>:r ![ -n "ANDPAUL" ] && echo -e "\# -----------------------\n\# Author: Andreas Paul (ANDPAUL) <andreas.paul@1und1.de>\n\# Date: `date '+\%Y-\%m-\%d \%H:\%M'`\n\# Version: 0.1\n\# -----------------------\n" \|\| echo "ANDPAUL `date '+\%Y-\%m-\%d \%H:\%M'`"<CR>I<BS><Esc>A
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

" snipmate settings
let g:snips_author = 'Andreas Paul'
let g:snips_email = 'andreas.paul@1und1.de'

if has('gui_running')
  " Auto-open NERDTree in EVERY tab
  autocmd VimEnter * NERDTree
  autocmd BufWinEnter * NERDTreeMirror
  "python from powerline.vim import setup as powerline_setup
  "python powerline_setup()
  "python del powerline_setup
endif

" http://stackoverflow.com/questions/953398/how-to-execute-file-im-editing-in-vim
function! Setup_ExecNDisplay()
  execute "w"
  execute "silent !chmod +x %:p"
  let n=expand('%:t')
  execute "silent !%:p 2>&1 | tee ~/.vim/output_".n
  " I prefer vsplit
  "execute "split ~/.vim/output_".n
  execute "vsplit ~/.vim/output_".n
  execute "redraw!"
  set autoread
endfunction

function! ExecNDisplay()
  execute "w"
  let n=expand('%:t')
  "execute "silent !echo 'executed file'".@%." at: !date"
  execute "silent !date | tee ~/.vim/output_".n
  execute "silent !%:p 2>&1 | tee -a ~/.vim/output_".n
  " I use set autoread
  "execute "1 . 'wincmd e'"
endfunction

function! ExecGoNDisplay()
  execute "w"
  let f=expand('%')
  let n=expand('%:t')
  let td=expand('%:h')
  let $GOPATH='/home/andpaul/dev/go'
  execute "silent !echo 'executed file'".@%." at: !date | tee ~/.vim/output_".n
  execute "silent !date | tee ~/.vim/output_".n
  execute "silent !cd ".td." && time /usr/bin/go build %:p 2>&1 | tee -a ~/.vim/output_".n." && cd - && %:r 2>&1 | tee -a ~/.vim/output_".n
  "execute "silent !time /usr/bin/go run % 2>&1 | tee -a ~/.vim/output_".n
  "execute "silent !%:r 2>&1 | tee -a ~/.vim/output_".n
  " I use set autoread
  "execute "1 . 'wincmd e'"
endfunction

function! ExecGitPuppet4Sync()
  execute "w"
  execute "!git add -A ; git ci -am 'add stuff' ;git push ; echo onlyeu update itodsi_cmdbuild_qa | nc puppet-hosting-sync.server.lan 18140"
endfunction

:nmap <F9> :call Setup_ExecNDisplay()<CR>
:nmap <F2> :call ExecNDisplay()<CR>
:nmap <F3> :call ExecGoNDisplay()<CR>
:nmap <F4> :call ExecGitPuppet4Sync()<CR>

" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif
set runtimepath+=/usr/local/go/misc/vim
filetype plugin indent on
syntax on
