""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" independence.vim
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Authors:      Andy Dawson <andydawson76 AT gmail DOT com>
" Version:      0.1.0
" Licence:      http://www.opensource.org/licenses/mit-license.php
"               The MIT License
" URL:          http://github.com/AD7six/vim-independence
"
"-----------------------------------------------------------------------------
"
" Section: Documentation
"
" The vim independence plugin loads a .vimrc file from your git project root
" if it exists
"
" This allows you to override your vim settings on a project by project basis

" Section: Plugin header
"
" loaded_independence is set to 1 when initialization begins, and 2 when it
" completes.

if exists('g:loaded_independence')
	finish
endif
let g:loaded_independence=1

" Section: Event group setup
" Act when creating or loading a file
augroup Independence
	au BufNewFile,BufReadPre * call s:LoadConfig()
augroup END

" Section: Script variables

" Currently none

" Section: Utility functions
" These functions are not/should not be directly accessible

" Function: LoadConfig()
"
" If the file .vimrc exists in the root of a git project - load it
function s:LoadConfig()
	let l:file = fnameescape(expand("%:p"))
	if empty(l:file)
		return
	endif

	let l:root = system('cd ' . fnameescape(expand("%:h")) . "; echo -n `git rev-parse --show-toplevel`")
	let l:configFile = l:root . '/.vimrc'
	if filereadable(l:configFile)
		echom "Loading " . l:configFile
		exec ":source " . l:configFile
	endif
endfunction

" Section: Plugin completion
let g:loaded_independence=2
