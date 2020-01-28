" filetype detection
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufNewFile,BufRead */.bash*         setfiletype sh
  au! BufNewFile,BufRead */.bash/*        setfiletype sh
  au! BufNewFile,BufRead */.zsh/*         setfiletype zsh
  au! BufNewFile,BufRead */etc/apache2/*  setfiletype apache
  au! BufNewFile,BufRead */etc/nginx*.conf  setfiletype nginx
augroup END
