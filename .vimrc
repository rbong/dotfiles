" ==========================
" .vimrc - Roger Bogers 2017
" ==========================



""""""""
" Colors
""""""""
" see plugins for installed colors


" colorscheme tweaks
" ------------------


" highlight search/hls/search and text distinction
hi Search ctermfg=3 ctermbg=0 cterm=reverse

" Visual/selection and cursor distinction
hi MatchParen ctermbg=0 ctermfg=4
" text distinction
hi Visual ctermbg=4 ctermfg=0

" make wildmenu look like airline
hi Statusline cterm=none ctermbg=8 ctermfg=2
hi WildMenu cterm=none ctermbg=7 ctermfg=0

" make errors more distinct
hi Error ctermfg=0 ctermbg=3

" line numbers
hi LineNr ctermfg=7
hi CursorLineNr ctermfg=7
" show line numbers TODO: move this
set rnu
set nu


" vimdiff colors
" --------------

hi DiffAdd    cterm=none ctermbg=10 ctermfg=0
hi DiffChange cterm=none ctermbg=14 ctermfg=0
hi DiffDelete cterm=none ctermbg=11 ctermfg=0
hi DiffText   cterm=none ctermbg=13 ctermfg=0


" other color settings
" --------------------

" enable syntax highlighting
syntax on
" fix unknown error that makes Statement brown
hi Statement ctermfg=3
" fold color
hi Folded ctermbg=8



""""""""""
" Filetype
""""""""""


" detect vim-like files as vim
" ----------------------------

au BufNewFile,BufRead *.vifm,*.vimp,.vimperatorrc,*.penta,.pentadactylrc,vifmrc set filetype=vim


" detect implicit json files
" --------------------------


au BufNewFile,BufRead .eslintrc,.babelrc set filetype=json


" detect Opengl Shader Language files as C
" ----------------------------------------

au BufNewFile,BufRead *.glsl set filetype=c


" allow using .js extension for javascript imports
" ------------------------------------------------

au Filetype javascript set suffixesadd+=.js

" show json quotes
" ----------------

" cannot use conceallevel because of indentlines
au Filetype json syn region  jsonKeyword matchgroup=jsonQuote start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ contained
au Filetype json syn region  jsonString oneline matchgroup=jsonQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ contains=jsonEscape contained



" filetype based plugin settings
" ------------------------------
" see Plugins/various



"""""""""""""
" Keybindings
"""""""""""""


" meta keybindings
" ----------------
"  must go first

" set the leader key (key used to prefix custom commands)
let mapleader=" "


" buffer keybindings
" ------------------

" delete the current buffer
nno <leader>wd :Bd<CR>
nno <leader>bd :bd!<CR>
nno <leader>bc :Bd<CR>

" delete all buffers
nno <silent> <leader>ba :silent! bd <C-A><CR>


" file/folder keybindings
" -----------------------

" write the current file
nno <leader>w :w<CR>
nno <leader>ww :w<CR>
" write with sudo
nno <leader>ws :w !sudo tee %<CR>
nno <leader>wt :exec 'sav' tempname()<CR>
" write with git
nno <leader>wg :Gw<CR>
nno <leader>wG :Gw!<CR>

" change directory to the current file's directory
nno <leader>cd :cd %:h<CR>
" print the relative filename
nno <silent> <leader>cr :call setreg('f', system('echo -n $(python -c "import os.path; print (os.path.relpath(' . "'" . expand("%:p") . "'" . ','."'"."$(pwd)"."'".'))")'))<CR>

" register keybindings
" --------------------

" select the last pasted command
nno gp `[v`]


" plugin keybindings
" ------------------

" map Mundo to an old Gundo key combo
nno <leader>gu :MundoToggle<CR>

" open the snippets directory
nno <leader>osn :edit ~/.vim/plugged/vim-snippets/snippets<CR>

" easy align bindings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


" fugitive (git) keybindings
nno <leader>ga :Gcommit --amend --no-edit
nno <leader>gA :Gcommit --amend
nno <leader>gb :Gblame<CR>
nno <leader>gc :Gcommit<CR>
nno <leader>gC :Gcommit --no-edit<CR>
nno <leader>gd :Gdiff<CR>
nno <leader>ge :Gedit 
nno <leader>gf :Gfetch 
nno <leader>ghh :Git! stash show -p stash@{
nno <leader>ghl :Git! stash list<CR>
nno <leader>gha :Git stash apply stash@{
nno <leader>ghA :Git stash pop
nno <leader>ghs :Git stash save ""<Left>
nno <leader>ghS :Git stash save -k ""<Left>
nno <leader>gg :Git! 
nno <leader>gk :Gitv<CR>
nno <leader>gK :Gitv!<CR>
nno <leader>gl :Glog 
nno <leader>gm :Gmerge 
nno <leader>go :Git checkout 
nno <leader>gO :Git checkout -b 
nno <leader>gp :Gpush<CR>
nno <leader>gP :Gpush --no-verify
nno <leader>gq :Gpull<CR>
nno <leader>gr :Ggrep 
nno <leader>gs :Gstatus<CR>
nno <leader>gt :Gsplit 
nno <leader>gv :Gvsplit 
nno <leader>gw :Gbrowse 
" make sure airline has the latest branch
au BufWinEnter * AirlineRefresh

" list keybindings
nno <leader>ll :let win = winnr()<CR>:lw<CR>:if winnr() != win \| wincmd J \| endif<CR>:execute win.'wincmd w'<CR>
nno <leader>lc :lclose<CR>
nno <leader>qq :let win = winnr()<CR>:cw<CR>:if winnr() != win \| wincmd J \| endif<CR>:execute win.'wincmd w'<CR>
nno <leader>qo :copen<CR>
nno <leader>qg :if len(getqflist()) > 0 \| copen \| wincmd J \| exec "QFGrep" \| endif<CR>
nno <leader>qv :if len(getqflist()) > 0 \| copen \| wincmd J \| exec "QFGrepV" \| endif<CR>
nno <leader>qr :copen \| wincmd J \| exec "QFRestore"<CR>
nno <leader>qc :cclose<CR>

" taglist bindings
nno <leader>tl :TlistToggle<CR>

" bufexplorder bindings
nno <leader>be :BufExplorer<CR>

" session keybindings
" nno <silent> <leader>sm :<C-U> exe "mksession! ~/session" . v:count1 . ".vim"<CR>
" nno <silent> <leader>sl :<C-U> exe "silent! bufdo bd \| source ~/session" .v:count1 . ".vim"<CR>

" neovim
" ------
" see neovim/keybindings


" register keybindings
" --------------------

" allow easy use of the clipboard and null registers
nno \ "+
vno \ "+
nno _ "_
vno _ "_


" text object bindings
" --------------------

" redefine c as curly braces
vno ic iB
vno ac aB
omap ic iB
omap ac aB


" spacing keybindings
" --------------------

" faster formatting
nno <leader>e =

" place a space after/before the current line
nno <leader>j mzo<ESC>0D`z
nno <leader>k mzO<ESC>0D`z

" toggle wrapping long lines visually
nno <leader>re :se wrap!<CR>:se wrap?<CR>

" toggle wrapping long lines physically
"
" http://vim.wikia.com/wiki/Toggle_auto-wrap
function! AutoWrapOn()
        set fo+=tc
        " colorcolumn default color
        hi ColorColumn ctermbg=15 ctermfg=0
endfunction
function! AutoWrapToggle()
    if &formatoptions =~ 't'
        set fo-=tc
        " colorcolumn off color
        hi ColorColumn ctermbg=7 ctermfg=0
    else
        call AutoWrapOn()
    endif
endfunction
autocmd BufNewFile,BufRead * call AutoWrapOn()
nno <leader>rt :call AutoWrapToggle()<CR>



" search keybindings
" ------------------

" allow escape to clear search highlighting until the next search
nno <ESC> :noh<CR><ESC>


" window navigation keybindings
" -----------------------------

" allow switching window without pressing <C-w>
nno <C-j> <C-w>j
nno <C-k> <C-w>k
nno <C-h> <C-w>h
" fix for OSX
nno <BS> <C-w>h
nno <C-l> <C-w>l
nno <C-A-\> :wincmd \|<CR>


" movement keybindings
" --------------------

" jump to the last occurance of the f/F/t/T search
nno <leader>; $;,
nno <leader>, 0,;

" put searches in the jump list
nno / m`/
nno ? m`?

" append searches
nno <leader>/ /<C-r>/\\|
nno <leader>? ?<C-r>/\\|

" shortcut for %
nno <leader>5 %
omap <leader>5 %
vno <leader>5 %

" shortcut for $
nno <leader>4 $
omap <leader>4 $
vno <leader>4 $

" insert keybindings
" ------------------

" allow for undoing after every line
" TODO: fix this with autocompletionc
" ino <CR> <C-g>u<CR>



""""""""
" Neovim
""""""""


if has ('nvim')
    " allow double escape to exit to normal mode
    tnoremap <C-\><C-\> <C-\><C-n>

    " change shell to zsh
    set shell=zsh

    " plugins
    " see plugins/neovim

    " prevent terminals from throwing an exit message
    au TermClose * call feedkeys('<cr>')

    " open vifm (file manager)
    nno <leader>fm :Vifm .<CR>
    nno <leader>fd :let g:vifmLiveCwd=!g:vifmLiveCwd<CR>:let g:vifmLiveCwd<CR>

    " open terminal
    " nno <leader>sh :botright 10new \| terminal<CR>
    function! GetTerm(prog)
        999wincmd j
        999wincmd l
        if &buftype == "terminal"
          vs
          wincmd l
          setlocal wfh
        else
          botright 20new
          999wincmd j
          999wincmd l
          setlocal wfh
          wincmd J
        endif
        exe 'e term://' . a:prog
        setlocal nobuflisted
        setlocal bufhidden=delete
        startinsert
    endfunction
    nno <leader>zh :call GetTerm('zsh')<CR>
    nno <leader>zn :call GetTerm('node')<CR>
    " nno <leader>ss :Ttoggle<CR>
    " nno <leader>sk :let g:neoterm_size+=10<CR>:Topen<CR>:Tclose<CR>:Topen<CR>
    " nno <leader>sj :let g:neoterm_size-=10<CR>:Topen<CR>:Tclose<CR>:Topen<CR>
    " nno <leader>sl :let g:neoterm_size=20<CR>:Topen<CR>:Tclose<CR>:Topen<CR>
endif



"""""""""
" Plugins
"""""""""

" access plugin private APIs
" --------------------------

" http://stackoverflow.com/questions/24027506/get-a-vim-scripts-snr
func! GetScriptNumber(script_name)
    " Return the <SNR> of a script.
    "
    " Args:
    "   script_name : (str) The name of a sourced script.
    "
    " Return:
    "   (int) The <SNR> of the script; if the script isn't found, -1.

    redir => scriptnames
    silent! scriptnames
    redir END

    for script in split(l:scriptnames, "\n")
        if l:script =~ a:script_name
            return str2nr(split(l:script, ":")[0])
        endif
    endfor

    return -1
endfunc

func! CallScriptFunc(script_name, func)
  return eval(printf("<SNR>%d_" . a:func, GetScriptNumber("gitv.vim")))
endfunc


" plugins using vim-plug
" ----------------------

call plug#begin('~/.vim/plugged')
    " visual undo trees
    Plug 'simnalamburt/vim-mundo'

    " surrounding keybindings
    Plug 'tpope/vim-surround'

    " remappings of *next and *prev commands
    Plug 'tpope/vim-unimpaired'

    " commenting toggling
    Plug 'tpope/vim-commentary'

    " adds . to tpope plugins
    Plug 'tpope/vim-repeat'

    if !exists ('rlwrap')
        " snippets (chunks of automatic code)
        Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    endif

    " alignment
    Plug 'junegunn/vim-easy-align'

    " fancy statusline/tab-bar
    Plug 'vim-airline/vim-airline'
    " enable unicode
    let g:airline_powerline_fonts = 1
    " enable tab-bar
    let g:airline#extensions#tabline#enabled = 1
    " themes
    Plug 'rbong/vim-airline-themes'
    " colors
    let g:airline_theme='wumbly'
    " symbols (fix for unicode problems, even with powerline fonts)
    augroup au_airline_symbols
        autocmd VimEnter * let g:airline_symbols.maxlinenr = 'M' |
                    \ let g:airline_symbols.notexists = 'N' |
                    \ let g:airline_symbols.crypt = 'C' |
                    \ let g:airline_symbols.whitespace = 'W'
    augroup end

    " automatic closing pairs
    " Plug 'Raimondi/delimitMate'
    " expand return into two lines
    " let delimitMate_expand_cr = 1

    " git integration
    Plug 'rbong/vim-fugitive'
    " prevent excessive buffers
    " autocmd BufReadPost fugitive://* set bufhidden=delete
    " autocmd Filetype gitcommit set bufhidden=delete
    " do not list the buffer
    " autocmd BufWinEnter fugitive://* set nobuflisted
    " autocmd BufWritePre fugitive://* set buflisted
    " fix the buffer height
    " autocmd BufWinEnter fugitive://* set wfh
    autocmd Filetype gitcommit set wfh
    " bitbucket support
    Plug 'tommcdo/vim-fubitive'

    " branch management in fugitive
    Plug 'gregsexton/gitv'
    let g:Gitv_DoNotMapCtrlKey = 1
    let g:Gitv_TruncateCommitSubjects = 1
    autocmd Filetype gitv nmap <buffer> <silent> <C-n> <Plug>(gitv-previous-commit)
    autocmd Filetype gitv nmap <buffer> <silent> <C-p> <Plug>(gitv-next-commit)

    " branch management extensions
    " Plug 'rbong/gitv-ext'

    " allow quick diff operations
    nno <leader>du :diffupdate<CR>
    nno <leader>dg :diffget<CR>
    nno <leader>dp :diffput<CR>
    " get ours
    nno <leader>d3 :diffget //3<CR>
    " get theirs
    nno <leader>d2 :diffget //2<CR>

    " tag browser
    Plug 'vim-scripts/taglist.vim'
    " increase default width of pane
    let Tlist_WinWidth = 40

    " buffer browser
    Plug 'jlanzarotta/bufexplorer'

    " jsx highlighting and indentation
    " dependency
    Plug 'pangloss/vim-javascript'
    let g:javascript_enable_domhtmlcss = 1
    " the good stuff
    Plug 'mxw/vim-jsx'
    " enable js files
    let g:jsx_ext_required = 0
    autocmd BufRead *.es6 set filetype=javascript

    " GraphQL support
    Plug 'jparise/vim-graphql'

    " grow/shrink selection
    " Plug 'terryma/vim-expand-region'

    " lines indicating indent
    Plug 'Yggdroot/indentLine'
    nno <leader>it :IndentLinesToggle<CR>
    nno <leader>ir :IndentLinesReset<CR>

    " text objects
    " columns
    Plug 'coderifous/textobj-word-column.vim'
    " framework
    Plug 'kana/vim-textobj-user'
    " functions
    Plug 'kana/vim-textobj-function'
    Plug 'michaeljsmith/vim-indent-object'
    " Plug 'bkad/CamelCaseMotion'
    " omap <silent> iw <Plug>CamelCaseMotion_iw
    " xmap <silent> iw <Plug>CamelCaseMotion_iw

    Plug 'rbong/neovim-vifm'
    Plug 'rbong/vim-vertical'

    " Plug 'rbong/vim-kite'

    nno <silent> - :Vertical b<CR>
    nno <silent> + :Vertical f<CR>
    vno <silent> - mz:<C-U>call Vertical('v', 'b', 1)<CR>
    vno <silent> + mz:<C-U>call Vertical('v', 'f', 1)<CR>
    vno <silent> 2- mz:<C-U>call Vertical('v', 'b', 2)<CR>
    vno <silent> 2+ mz:<C-U>call Vertical('v', 'f', 2)<CR>
    vno <silent> 3- mz:<C-U>call Vertical('v', 'b', 3)<CR>
    vno <silent> 3+ mz:<C-U>call Vertical('v', 'f', 3)<CR>
    vno <silent> 4- mz:<C-U>call Vertical('v', 'b', 4)<CR>
    vno <silent> 4+ mz:<C-U>call Vertical('v', 'f', 4)<CR>
    vno <silent> 5- mz:<C-U>call Vertical('v', 'b', 5)<CR>
    vno <silent> 5+ mz:<C-U>call Vertical('v', 'f', 5)<CR>

    " " slack integration
    " Plug 'mattn/webapi-vim'
    " Plug 'heavenshell/vim-slack'

    " fuzzy file matching
    Plug 'ctrlpvim/ctrlp.vim'
    se wig+=*/node_modules/*,*/coverage/*,*/esdoc/*,*/apidoc/*,*/doc/*
    let g:ctrlp_custom_ignore = '\.git$'
    let g:ctrlp_switch_buffer = 'et'
    let g:ctrp_show_hidden = 1
    nno <C-b> :CtrlPBuffer<CR>
    nno <C-f> :CtrlPMRUFiles<CR>

    " Additional text objects
    Plug 'wellle/targets.vim'

    " Filter quickfix list
    Plug 'sk1418/QFGrep'

    " Close buffer, not window
    Plug 'moll/vim-bbye'

    " Testing Plugins
    " Plug 'junegunn/vader.vim'

    " neovim plugins
    if has ('nvim')
        Plug 'rbong/galvanize.vim'

        " use vifm instead of netrw
        Plug 'rbong/neovim-vifm'
        " allow changing the directory live with vifm
        let g:vifmLiveCwd = 1
        let g:vifmSplitWidth = 50

        if !exists('rlwrap')
            " autocompletion
            Plug 'Shougo/deoplete.nvim'
            let g:deoplete#enable_at_startup = 1
        endif

        " asynchronous make
        Plug 'benekastah/neomake'
        " run neomake automatically
        autocmd! BufWritePost * Neomake
        let g:neomake_error_sign = { 'text': 'x' }

        " javascript/jsx
        let g:neomake_javascript_enabled_makers = ['eslint']
    endif

    " keybindings
    " see keybindings/plugins
call plug#end()
" call expand_region#custom_text_objects({'it':1, 'ip':1, 'at':2, 'ap':2})
" vmap K <Plug>(expand_region_expand)
" vmap J <Plug>(expand_region_shrink)



""""""""""""
" Scratchpad
""""""""""""


nno <leader>ss :Vifm ~/scratch<CR>

augroup Scratchpad
  autocmd BufWrite,VimLeave /home/dork/scratch/* mkview
  autocmd BufRead           /home/dork/scratch/* loadview
augroup END



"""""""""""
" Searching
"""""""""""


" ignore uppercase letters except explicitly
" ------------------------------------------

set ignorecase smartcase



"""""""""
" Spacing
"""""""""


" turn one tab into multiple spaces
" ---------------------------------

set expandtab tabstop=2 shiftwidth=2


" limit the document width
" ------------------------

" the document width
set tw=79

" enable wrapping
" see Keybindings/spacing/enable wrapping

" show a line at the colorcolumn
set colorcolumn=80


" indentation based on filetype
" -----------------------------
" cindent/smartindent cannot be set at the same time as filetype indent

set nocindent
set nosmartindent
set autoindent
filetype plugin indent on

" cursor spacing
" --------------

set scrolloff=5



"""""""""
" Undoing
"""""""""


"" enable persistence
set undofile
set undodir=~/.vim/undo

