" filetype detection
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  autocmd! BufNewFile,BufRead */.bash*         setfiletype sh
  autocmd! BufNewFile,BufRead */.bash/*        setfiletype sh
  autocmd! BufNewFile,BufRead */.zsh/*         setfiletype zsh
  autocmd! BufNewFile,BufRead */etc/apache2/*  setfiletype apache
  autocmd! BufNewFile,BufRead */etc/nginx*.conf  setfiletype nginx
  autocmd! BufNewFile,BufRead *.inf,*.fdf,*.dec,*.dsc setfiletype config
  autocmd! BufNewFile,BufRead *.asi,*.asl      setfiletype asl
augroup END
