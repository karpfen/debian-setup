" ~./.vimrc
"
runtime! debian.vim 

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'jalvesaq/Nvim-R'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'jimhester/lintr'
call vundle#end()
filetype plugin indent on

"execute pathogen#infect()

" configure vim-airline
let g:airline_theme='term'
" show all open buffers on top
let g:airline#extensions#tabline#enabled = 1
" nice looking things
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''

" https://github.com/sickill/vim-monokai
" needs to be put in .config/nvim/colors/
colorscheme monokai

if has("syntax")
    syntax enable
endif

if has("autocmd")
    " Jump to the last position when reopening a file
    "au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " Load indentation rules and plugins according to the detected filetype.
    " Note these are essential for r-plugin!
    filetype plugin on
    " filetype indent on " set above for vundle
endif

set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

" Extra config lines 
set modelines=0
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set ruler
set relativenumber
set nu "line numbering
set wrap
set textwidth=80
set colorcolumn=81
set undofile
"global searches, so :%s/foo/bar/g automatically becomes :%s/foo/bar
set gdefault 
"automatically highlight searching
set hlsearch 
" Height of the command bar
set cmdheight=2
set backspace=indent,eol,start


"------------------------------------
" Behavior
"------------------------------------
let maplocalleader = ","
let mapleader = ";"
"let g:mapleader = ","
"set foldenable


"------------------------------------
" Remaps
"------------------------------------
nnoremap <C-L> :nohls<cr>
noremap <C-m> :!make<cr>
nmap <leader>w :w!<cr>
nmap <C-x> :qa<cr>
" syntastic
nmap [l :lprev<cr> 
nmap ]l :lnext<cr> 

" openbrowser maps:
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
nmap gw <Plug>(openbrowser-open)
vmap gw <Plug>(openbrowser-open)

" Next 2 lines make tab match brackets instead of %
nnoremap <tab> %
vnoremap <tab> %

"------------------------------------
" Showmarks
"------------------------------------
let Tlist_Ctags_Cmd = '/usr/bin/ctags-exuberant'
let marksCloseWhenSelected = 0
let showmarks_include="abcdefghijklmnopqrstuvwxyz"

"------------------------------------
" ExploreMode (instead of NERDTree) mapped to F2
" Note that help doesn't work, but just search "vim netrw" or see here:
" https://medium.com/@mozhuuuuu/vimmers-you-dont-need-nerdtree-18f627b561c3
"------------------------------------
function MyExplore()
    tabnew
    Explore
    nmap <buffer> <leader>q :q<cr>
endfunction

nmap <F2> :call MyExplore()<cr>


"----------------------------------------
"-------------   Nvim-R   ---------------
"----------------------------------------

" https://github.com/jcfaria/Vim-R-plugin/issues/204
let g:ScreenImpl = 'Tmux'
let g:ScreenShellInitialFocus = 'shell' 
" send selection to R with space bar
vmap <Space> <Plug>RDSendSelection 
" send line to R with space bar
nmap <Space> <Plug>RDSendLine

" stop the plugin remapping underscore to '->':
let R_assign = 0

let g:R_in_buffer = 0
let g:R_tmux_split = 1
"let g:R_rconsole_width = winwidth("%") / 2
let g:R_rconsole_width = 120
let g:R_nvimpager = "horizontal"
let R_args = ['--no-save', '--quiet']
let R_tmux_title = 'R'
let g:R_notmuxconf = 1 "use my .tmux.conf, not the Nvim-r one

let r_syntax_folding = 1

"-------------------------------------------
"-----------   YouCompleteMe   -------------
"-------------------------------------------

" define global YCM config
" https://jonasdevlieghere.com/a-better-youcompleteme-config/
let g:ycm_global_ycm_extra_conf = '~/.nvim/.ycm_extra_conf.py'

"-------------------------------------------
"-------------   syntastic   ---------------
"-------------------------------------------

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_w = 0
let g:syntastic_check_on_wq = 0
let b:syntastic_mode = 0 " disable
" http://stackoverflow.com/questions/20030603/vim-syntastic-how-to-disable-the-checker
let g:syntastic_mode_map = { 
    \ 'mode': 'passive', 
    \ 'active_filetypes': [],
    \ 'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>
let g:syntastic_debug = 0
" - open .cpp and :mes, :SyntasticInfo to get debug info
" see https://github.com/vim-syntastic/syntastic/issues/1246 and
" https://github.com/Valloric/YouCompleteMe#user-content-the-gycm_show_diagnostics_ui-option
let g:ycm_show_diagnostics_ui = 0
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++14 -std=libc++'
let g:syntastic_enable_cpp_check_header = 1
let g:syntastic_enable_cpp_lint_checker = 1
let g:syntastic_enable_cpp_clang_check = 1
let g:syntastic_enable_cpp_clang_tidy = 1
let g:syntastic_cpp_checkers = ['gcc', 'clang_check', 'clang_tidy', 'cpp_lint']

let g:syntastic_cpp_clang_check_quiet_messages = {"regex":
    \ ['file not found']}

" jimhester/lintr:
let g:syntastic_enable_r_lintr_checker = 1
let g:syntastic_r_checkers = ['lintr']
let g:syntastic_enable_rmd_lintr_checker = 1
let g:syntastic_rmd_checkers = ['lintr']
function! SyntasticCheckHook(errors)
    if !empty(a:errors)
        let g:syntastic_loc_list_height = min([len(a:errors), 10])
    endif
endfunction

let g:syntastic_r_lintr_quiet_messages = {"regex": 
    \ ['Only use double-quotes.', 'Opening curly braces should never',
    \ 'No visible global function definition', 'Commented code should be removed']}
let g:syntastic_rmd_lintr_quiet_messages = {"regex": 
    \ ['Only use double-quotes.', 'Opening curly braces should never',
    \ 'No visible global function definition', 'Commented code should be removed']}
" syntastic has :Error, so this is required for :E to work again
" (https://github.com/vim-syntastic/syntastic/issues/164)
command E Ex

"-------------------------------------------
"-------------   vim-latex   ---------------
"-------------------------------------------

" Set grep program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

autocmd BufRead,BufNewFile *.tex call CheckFileType()
function! CheckFileType()
    set textwidth=144
    set colorcolumn=150
endfunction

" set same widths for text files too
autocmd BufNewFile,BufRead *.txt set textwidth=144 | set colorcolumn=150
autocmd BufNewFile,BufRead *.md set textwidth=144 | set colorcolumn=150
autocmd BufNewFile,BufRead *.Rmd set textwidth=144 | set colorcolumn=150
autocmd BufNewFile,BufRead ~/R/osmprob/* set textwidth=80 | set colorcolumn=81

" =============== WORD COUNT FUNCTION =============
" From http://stackoverflow.com/questions/2974954/correct-word-count-of-a-latex-document
" with modifications from:
" http://tex.stackexchange.com/questions/534/is-there-any-way-to-do-a-correct-word-count-of-a-latex-document
" NOTE that this is globally defined for ALL filetypes, and may muck up other <F3> mappings!
:map <F3> :call WC()<CR>
function! WC()
    let filename = expand("%")
    "let cmd = "detex " . filename . " | wc -w | perl -pe 'chomp; s/ +//;'"
    let cmd = "detex " . filename . " | wc -w | tr -d [:space:]"
    let result = system(cmd)
    echo result . " words"
endfunction
" g<C-g> just counts words of a selection, but does not detex.

" NOTE that the above WC() function seems to give really rubbish estimates.
" A superior alternative is texcount, gives far more detail, for which see
" http://app.uio.no/ifi/texcount/howto.html
" To run it, just type :!texcount %<CR>
" It takes a while, but is far more accurate. It is nevertheless not really
" accurate, because it still counted far more words that those remaining when all
" major environments were excised. This is nevertheless possibly just because of
" \itemize, lists, and so on, so it seems to be the best way for the moment.


" =============== SPELL CHECKING =============
" NOTE that spell stopped working with .tex at some stage, and can be fixed by
" entering :syn spell toplevel.  To avoid having to manually enter this every
" time, follow the instructions in ":h mysyntaxfile-add": 
" Make a new directory in /.vim/after/sytax, with "tex.vim" holding this syn
" command. 
" The mysyntaxfile-add instructions also have lots of details about custom
" colour highlight schemes and the likes.

filetype plugin on
set omnifunc=syntaxcomplete#Complete

set path+=**
set wildmenu
set wildmode=list:full

" Spell checking
autocmd FileType latex,tex,md,markdown,Rmd set spell
set complete +=k

" Make dir for undo files
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

" Configuration for https://github.com/airblade/vim-gitgutter
set updatetime=30

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" open each buffer in its own tabpage
":au BufAdd,BufNewFile * nested tab sball
