if exists("did_load_filetypes")
" von http://snaike.blogspot.com/2007/04/test.html
finish
endif

augroup filetypedetect
" log files such as catalina.out or log4j files.
au! BufRead,BufNewFile catalina.out,*.out,*.out.*,*.log,*.log.* setf log4j
augroup END
