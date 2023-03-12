
nnoremap <leader>p :w<enter>:!g++ % -o nvim-cpp && ./nvim-cpp<enter>

" syntax {{{
inoremap ;# #include #<enter><++><Esc>k0f#s
inoremap ;n int (<++>){<Enter><++><Enter>return <++>;<Enter>}<Enter><++><Esc>4k0t(a
inoremap ;i if (){<Enter><++><Enter>}<Enter><++><Esc>3k0t)a
inoremap ;f for (int i = 0; i < #; ++i){<Enter><++><Enter>}<Enter><++><Esc>3k0f#s
" }}}

