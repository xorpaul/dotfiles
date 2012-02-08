" detect puppet filetype
"au BufRead,BufNewFile *access.log*              set filetype=apachelogs
au BufRead,BufNewFile *access.log* set filetype=httplog 
au BufRead,BufNewFile *error.log* set filetype=httplog 
