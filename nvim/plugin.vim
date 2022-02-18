call plug#begin()

" Files explorer
Plug 'preservim/nerdtree'

" Edit helpers
" - Commenter
Plug 'preservim/nerdcommenter'
" - Snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
" > Format code
Plug 'sbdchd/neoformat'

"Themes
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" ---Plugins Config---
" ************* Nerdtree settings
" Nerdtree Toggle
map <F2> :NERDTreeToggle<CR>

" ************* Nerdcommenter settings
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 0
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" ************* Coc.nvim settings
"
" Tab for triggering snippets
inoremap <silent><expr> <TAB>
			\ pumvisible() ? coc#_select_confirm() :
			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" navigate placeholder snippet
let g:coc_snippet_next = '<c-k>'
let g:coc_snippet_prev = '<c-j>'

" Use `[[` and `]]` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [[ <Plug>(coc-diagnostic-prev)
nmap <silent> ]] <Plug>(coc-diagnostic-next)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" ************* Neoformat settings
"
" custom setting for clangformat
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 2}"']
\}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']
" *(.c and .cpp only)
" add autoformat on saving
augroup fmt
	autocmd!
	autocmd BufWritePre *.cpp,*.c undojoin | Neoformat
augroup END
" format selected lines only
autocmd Filetype c,cpp vmap <c-F> :Neoformat <Enter> 
" have Neoformat only msg when there is an error
let g:neoformat_only_msg_on_error = 1
