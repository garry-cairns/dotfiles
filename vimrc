:imap fd <Esc>

" Set a sane font
set gfn="Ubuntu Monospace"

" Filetype specific settings
" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on

  " Soft breaks for text files
  autocmd FileType md setlocal wrap linebreak nolist spell
  autocmd FileType tex setlocal wrap linebreak nolist spell
  autocmd FileType text setlocal wrap linebreak nolist spell

endif

" Set list for programming files and show invisibles
set list
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
"Invisible character colors 
highlight NonText guifg=#598059
highlight SpecialKey guifg=#598059
" tabs and tabstops
set ts=4 sts=4 sw=4 expandtab
