" VIM Setup {{{

" Count lines of code {{{

function! LinesOfCode()
    echo system('cloc --quiet '.bufname("%"))
endfunction

"}}}

" FILETYPES  {{{ ==============================================================

" DJANGO HTML (Templates) {{{

au BufRead,BufNewFile */templates/*.html setlocal filetype=htmldjango.html

" }}}

" JSON {{{ -------------------------------------------------------------------

" autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.json set ft=json

augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END

" }}}

" LUA {{{

au BufRead,BufNewFile rc.lua setlocal foldmethod=marker

" }}}

" MARKDOWN {{{

" markdown filetype file
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
autocmd FileType markdown NeoBundleSource vim-markdown
autocmd FileType markdown NeoBundleSource vim-markdown-extra-preview

" }}}

" END FILETYPES }}}

" END VIM SETUP }}}

" Plugins {{{
call neobundle#append()

" Autocompletion
NeoBundle 'Valloric/YouCompleteMe'
" Powerful and advanced Snippets tool
NeoBundle 'SirVer/ultisnips'
" Snippets for Ultisnips
NeoBundle 'honza/vim-snippets'

" Syntax {{{

NeoBundleLazy 'vim-scripts/JSON.vim', {'autoload': {'filetypes': ['json']}}
NeoBundleLazy 'vim-scripts/po.vim--gray', {'autoload': {'filetypes': ['po']}}
NeoBundleLazy 'joedicastro/vim-pentadactyl', {
            \ 'autoload': {'filetypes': ['pentadactyl']}}
NeoBundle 'scrooloose/syntastic'

" }}}

call neobundle#end()
" END Plugins }}}

" Plugin Setup {{{

" Syntastic {{{

nmap <silent><Leader>N :SyntasticCheck<CR>:Errors<CR>

let g:syntastic_python_pylint_exe = "pylint2"
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['python'] }

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol  = '⚡'
let g:syntastic_style_warning_symbol  = '⚡'

" }}}

" Commentary {{{ -------------------------------------------------------------

nmap <Leader>c <Plug>CommentaryLine
xmap <Leader>c <Plug>Commentary

augroup plugin_commentary
    au!
    au FileType python setlocal commentstring=#%s
    au FileType htmldjango setlocal commentstring={#\ %s\ #}
    au FileType puppet setlocal commentstring=#\ %s
augroup END

" }}}

" Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" }}}

" END Plugin Setup }}}

" Unite Menu {{{

let g:unite_source_menu_menus.code = {
    \ 'description' : '           coding
        \                                                ⌘ [space]c',
    \}
let g:unite_source_menu_menus.code.command_candidates = [
    \['▷ syntastic toggle                           (syntastic)',
        \'SyntasticToggleMode'],
    \['▷ syntastic check & errors                   (syntastic)   ⌘ <Leader>N',
        \'normal <Leader>N'],
    \['▷ count lines of code',
        \'Unite -default-action= output:call\\ LinesOfCode()'],
    \['▷ toggle indent lines                                      ⌘ <Leader>L',
        \'IndentLinesToggle'],
    \]

let g:unite_source_menu_menus.code.command_candidates = helperfuncs#unite_menu_gen(g:unite_source_menu_menus.code.command_candidates, [])

nnoremap <silent>[menu]c :Unite -silent menu:code<CR>

" END Unite Menu }}}

