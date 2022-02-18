" ---Personal Config---
" Show current position of cursor easily
set cursorline
set cursorcolumn

" Show current line number
set nu rnu

" Highlight search result
set hls

" Set how many spaces 'tab' does
set tabstop=2
" Set how many space '>>' does
set shiftwidth=2

" Autoindent
set autoindent

" Set no swap file (highly recommend to run with autosave configuration)
set noswapfile

" Autosave is enabled by default
" Below shortcut combine keys help disbaling
function! ToggleAutoSave()
	if !exists('#Autosave#TextChanged') 
		augroup Autosave
			autocmd!
			" " Autosave when text changed
			autocmd TextChanged,TextChangedI <buffer> silent write
			" " Autosave when exiting insert mode and move to other panes
			au InsertLeave,BufLeave * silent! wall
		augroup END
		echo "autosave ON"
	else
		augroup Autosave
			autocmd!
		augroup END
		echo "autosave OFF"
	endif
endfunc
" <S-F3> == <F15>
noremap <F15> :call ToggleAutoSave() <CR>

" Remember folding (means return to last position you quit)
augroup remember_folds
	autocmd!
	autocmd BufWinLeave * mkview
	autocmd BufWinEnter * silent! loadview
augroup END

" Toggle PasteMode : <S-F2> == <F14>
set pastetoggle=<F14>

" Mouse in vim
function! ToggleMouse()
	" check if mouse is enabled
	if &mouse == 'a'
		" disable mouse
		set mouse=
		echom "mouse OFF" 
	else
		" enable mouse everywhere
		set mouse=a
		echom "mouse ON"
	endif
endfunc
" <C-F2> == <F26>
noremap <F26> :call ToggleMouse() <CR>

" Save manually
noremap <F3> :w <Enter>
" Save all
noremap <F3><F3> :wall <Enter>
" Save and quit
noremap <F3><F4> :wq <Enter>
" Quit without saving
noremap <F4><F4> :q! <Enter>
" Quit and also delete buffer : <C-F4> == <F28>
noremap <F28><F28> :bdelete <Enter>

" Save all openings and quit
noremap <F4><F3> :wqall! <Enter>

" Clear the highlight search : <C-F5> == <F29>
noremap <F29> :let @/ = "" <Enter>
" Get latest change manually
noremap <F5> :checktime <Enter>

" Get latest change automatically
" Editing file will be sync from any source but it takes maybe 2-3 seconds to take effect so dont worry
set autoread
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
			\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
			\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Open nvim config files : <S-F1> == <F13>
noremap <F13> :vs /home/$USER/.config/nvim <Enter>
" Apply changes : <C-F1> == <F25>
noremap <F25> :source /home/$USER/.config/nvim/init.vim <Enter>

" Buffers aka Tabs
" " Simply switch buffers
" noremap <F6> :bprevious <Enter>
" noremap <F7> :bnext <Enter>
" Switch and also show list of buffers (previous is "#" and now is "%a")
noremap <F7> :bnext<CR>:redraw<CR>:ls<CR>
noremap <F6> :bprevious<CR>:redraw<CR>:ls<CR>
" Show listed-only buffers and allow to choose one by entering number then press <Enter>
noremap <F30> :buffers<CR>:buffer<Space>
" Show all buffers and allow to choose one by entering number then press <Enter>
noremap <F31> :buffers!<CR>:buffer<Space>

" new the right of the current buffer
set splitright
" new buffer below the current buffer
set splitbelow
