filetype plugin on

if &cp | set npcp | endif

set viminfo='20,\"50

set history=100

set ruler

set backspace=indent,eol,start

set autoindent
set smartindent

set noexpandtab
set shiftwidth=2
set tabstop=2

map <F2> 0811Bhs<cr><esc>

map <F3> :e # <cr>

set autowrite

set background=dark

let java_allow_cpp_keywords = 1

highlight WhiteSpaceEOL ctermbg=lightgreen
match WhiteSpaceEOL /\s\+$/

syntax on
set nu

""" INTERFILE NAVIGATION

" Use gf to jump to source file for class name under the cursor
" Use gc to jump to source file for variable under the cursor's class
" Then use :e#<cr> to jump back to the original source file if desired
" Also try :find MyClass<cr> to jump to the specified class's source file
" (from http://everything101.sourceforge.net/docs/papers/java_and_vim.html)
set path+=.
set path+=~/svn/java/**
set path+=~/cvs/OME-JAVA/src/**
autocmd BufRead *.java set include=^#\s*import
autocmd BufRead *.java set includeexpr=substitute(v:fname,'\\.','/','g')
autocmd BufRead *.java set suffixesadd=.java
map gc gdbgf
" Uncomment the following to use a split window instead of dropping the buffer
" Also try :sfind MyClass<cr> to open the specified class in a split window
map gf <C-w>f
map gc gdb<C-w>f


""" TAB COMPLETION

" Ignore these suffixes when tab-completing with (e.g.) :e
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.class

" Let tab be used for keyword completion in insert mode (normally ^N and ^P)
" (from http://www.vim.org/tips/tip.php?tip_id=102)
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>

" Add standard Java syntax file to the dictionary for keyword completion
" (from http://vim.sourceforge.net/tips/tip.php?tip_id=385)
autocmd BufReadPost *.java exe "set dict+=".escape($VIMRUNTIME.'\syntax' .&filetype.'.vim',' \$,')

" Press F2 to wrap a long line under the cursor at 80 chars
" Also try selecting with V followed by gq to format text blocks to 80 chars
map <F2> 081lBhs<cr><esc>

" Simple code folding -- use zo to open, zc to close, F3 to globally toggle
" (from http://vim.sourceforge.net/tips/tip.php?tip_id=385)
map <F3> :let &fen=!&fen<cr>
set fillchars=stl:_,stlnc:-,vert:\|,fold:\ ,diff:-
set foldlevel=1
set foldmethod=indent
"set foldnestmax=2
let &fen=!&fen
