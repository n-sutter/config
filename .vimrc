""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add pathogen plugin manager
execute pathogen#infect()

" Turn on syntax highlighting, or really color coding.
" This really helps you spot broken syntax as you type.
syntax on

" Allow backspace in insert mode
set backspace=indent,eol,start

set history=100	

" Turn off multi-level undo.  Now pressing 'u' will toggle
" the last change off and on, as opposed to rolling back
" undoing all previous changes in reverse order.
" Multi-level undo is NOT helpful for most people!
set undolevels=0

" Maintain existing indentation. 
set autoindent

" Show matches for () [] {} 
set showmatch

" Default tab spacing = 8 columns
set ts=4

" Default backspace like normal
set bs=2

" Set thesaurus path
set+=~/.vim/thesaurus.txt

" Some option activate by default (remove the no to allow these).
set nobackup
set hlsearch
set incsearch
set nocompatible

set wrap						" Turn on word wrapping
set linebreak					" Only wrap at sensible places
set nolist	

" Some environments set textwidth to force linewrap.  Disable this. 
set textwidth=0
set wrapmargin=0
set formatoptions-=t			" Don't change wrapping on existing lines
set formatoptions+=l	

" Display a status-bar.
set laststatus=2

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Here begins my automated wordcount addition.
" This combines several ideas from:
" http://stackoverflow.com/questions/114431/fast-word-count-function-in-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:word_count="<unknown>"
function WordCount()
	return g:word_count
endfunction
function UpdateWordCount()
	let lnum = 1
	let n = 0
	while lnum <= line('$')
		let n = n + len(split(getline(lnum)))
		let lnum = lnum + 1
	endwhile
	let g:word_count = n
endfunction
" Update the count when cursor is idle in command or insert mode.
" Update when idle for 1000 msec (default is 4000 msec).
set updatetime=1000
augroup WordCounter
	au! CursorHold,CursorHoldI * call UpdateWordCount()
augroup END
" Set statusline, shown here a piece at a time
highlight User1 ctermbg=green guibg=green ctermfg=black guifg=black
set statusline=%1*			" Switch to User1 color highlight
set statusline+=%<%F			" file name, cut if needed at start
set statusline+=%M			" modified flag
set statusline+=%y			" file type
set statusline+=%=			" separator from left to right justified
set statusline+=\ %{WordCount()}\ words,
set statusline+=\ %l/%L\ lines,\ %P	" percentage through the file

