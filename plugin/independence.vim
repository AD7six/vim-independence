""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" independence.vim
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Authors:      Andy Dawson <andydawson76 AT gmail DOT com>
" Version:      0.2.0
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
	au BufNewFile,BufRead * call s:LoadConfig()
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

	let l:root   = system('cd ' . fnameescape(expand("%:h")) . "; echo -n `git rev-parse --show-toplevel`")
	let l:query  = '%:p:h'
	let l:maybe  = ''
	let l:toload = []

	" Make sure that we're *IN* a Git project
	if ! isdirectory(l:root)
		return
	endif

	" Find all of the .vimrc files from bottom-up
	while l:maybe != l:root
		let l:maybe = fnameescape(expand(l:query))
		let l:query = l:query . ':h'

		let l:vimrc = l:maybe . '/.vimrc'
		if filereadable(l:vimrc)
			call add(l:toload, l:vimrc)
		endif
	endwhile

	" Load all the .vimrc files from top-down
	for l:vimrc in reverse(l:toload)
		exec ":source " . l:vimrc
	endfor
endfunction

" Section: Plugin completion
let g:loaded_independence=2
