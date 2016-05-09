" ==========================
" .vimrc - Roger Bogers 2016
" ==========================



""""""""
" Colors
""""""""
" see plugins for installed colors


" colorscheme tweaks
" ------------------
" configured for wumbly on OSX El-Capitan Terminal


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

au BufNewFile,BufRead *.vifm,*.vimp,.vimperatorrc,vifmrc set filetype=vim


" detect implicit json files
" --------------------------


au BufNewFile,BufRead .eslintrc set filetype=json


" indentation tweaks
" ------------------

au Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2
au Filetype javascript set suffixesadd+=.js


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
nno <leader>bd :bd!<CR>

" delete all buffers
nno <leader>ba :1,$bd<CR>


" file/folder keybindings
" -----------------------

" write the current file
nno <leader>w :w<CR>

" change directory to the current file's directory
nno <leader>cd :cd %:h<CR>


" register keybindings
" --------------------

" select the last pasted command
nno gp `[v`]


" plugin keybindings
" ------------------

" map Mundo to an old Gundo key combo
nno <leader>gu :MundoToggle<CR>
nno <leader>mu :MundoToggle<CR>

" open the snippets directory
nno <leader>sn :edit ~/.vim/plugged/vim-snippets/snippets<CR>

" easy align bindings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" fugitive (git) keybindings
nno <leader>gb :Gblame<CR>
nno <leader>gc :Gcommit<CR>
nno <leader>gd :Gdiff<CR>
nno <leader>ge :Gedit 
nno <leader>gf :Gfetch 
nno <leader>gg :Git 
nno <leader>gl :Glog 
nno <leader>gm :Gmerge 
nno <leader>gp :botright 10new \| e term://fish<CR>igit pu
nno <leader>gq :Gpull<CR>
nno <leader>gr :Ggrep 
nno <leader>gs :Gstatus<CR>
nno <leader>gt :Gsplit 
nno <leader>gv :Gvsplit 
nno <leader>gw :Gbrowse 

" taglist bindings
nno <leader>tl :TlistToggle<CR>

" bufexplorder bindings
nno <leader>be :BufExplorer<CR>

" neovim
" ------
" see neovim/keybindings


" register keybindings
" --------------------

" allow easy use of the clipboard and null registers
nno + "+
vno + "+
nno - "_
vno - "_


" spacing keybindings
" --------------------

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


" movement keybindings
" --------------------

" jump to the last occurance of the f/F/t/T search
nno <leader>; $;,
nno <leader>, 0,;



""""""""
" Neovim
""""""""


if has ('nvim')
    " allow double escape to exit to normal mode
    tnoremap <Esc><Esc> <C-\><C-n>

    " change shell to fish
    set shell=fish

    " plugins
    " see plugins/neovim

    " prevent terminals from throwing an exit message
    au TermClose * call feedkeys('<cr>')

    " open vifm (file manager)
    nno <leader>fm :Vifm .<CR>
    nno <leader>fd :let g:vifmLiveCwd=!g:vifmLiveCwd<CR>:let g:vifmLiveCwd<CR>

    " open terminal
    " nno <leader>sh :botright 10new \| terminal<CR>
    function! GetTerm()
        Topen
        Tclose
        Topen
        999wincmd j
        set wfw
        set nobuflisted
        set bufhidden=delete
        startinsert
    endfunction
    nno <leader>sh :call GetTerm()<CR>
endif



"""""""""
" Plugins
"""""""""

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

    " snippets (chunks of automatic code)
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

    " javascript ES6 standard plugins (to be replaced)
    Plug 'isRuslan/vim-es6'

    " alignment
    Plug 'junegunn/vim-easy-align'

    " fancy statusline/tab-bar
    Plug 'vim-airline/vim-airline'
    " enable unicode
    let g:airline_powerline_fonts = 1
    " enable tab-bar
    let g:airline#extensions#tabline#enabled = 1
    " themes
    Plug 'vim-airline/vim-airline-themes'
    " colors
    let g:airline_theme='jellybeans'

    " automatic closing pairs
    Plug 'Raimondi/delimitMate'
    " expand return into two lines
    let delimitMate_expand_cr = 1

    " javascript plugins
    " better highlighting
    Plug 'othree/yajs'

    " git integration
    Plug 'tpope/vim-fugitive'
    " prevent excessive buffers
    autocmd BufReadPost fugitive://* set bufhidden=delete
    " bitbucket support
    Plug 'tommcdo/vim-fubitive'

    " tag browser
    Plug 'vim-scripts/taglist.vim'
    " increase default width of pane
    let Tlist_WinWidth = 40

    " buffer browser
    Plug 'jlanzarotta/bufexplorer'

    " neovim plugins
    if has ('nvim')
        " use vifm instead of netrw
        Plug 'rbong/neovim-vifm'
        " allow changing the directory live with vifm
        let g:vifmLiveCwd = 1

        " autocompletion
        Plug 'Shougo/deoplete.nvim'
        let g:deoplete#enable_at_startup = 1

        " asynchronous make
        Plug 'benekastah/neomake'
        " run neomake automatically
        autocmd! BufWritePost * Neomake

        " single terminal
        Plug 'kassio/neoterm'
        let g:neoterm_size=10

        " javascript/jsx
        let g:neomake_javascript_enabled_makers = ['eslint']
    endif

    " keybindings
    " see keybindings/plugins
call plug#end()



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

set expandtab tabstop=4 shiftwidth=4


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



"""""""""
" Undoing
"""""""""


"" enable persistence
set undofile
set undodir=~/.vim/undo
