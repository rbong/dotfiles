""" Settings


" syntax highlighting
syntax on

" persistence
set undofile
set undodir=~/.vim/undo

" indentation behaviour (see :help)
set nocindent nosmartindent autoindent
filetype plugin indent on

" default indentation of four spaces
set expandtab tabstop=4 shiftwidth=4

" ignore search case in search unless if uppercase letters are included
set ignorecase smartcase

" show relative line numbers
set relativenumber
" show the actual number for the current line
set number

" highlight searches
set hlsearch

augroup myfilesettings
    if has('terminal')
        " no numbers in the terminal
        " do not list the terminal buffer
        au TerminalOpen * setlocal nornu nonu nobuflisted
    endif
    " vim syntax highlighting for vifm
    au BufNewFile,BufRead *.vifmrc set filetype=vim
augroup END


""" Commands


function! DelAllBufs()
    silent! bd <c-a><cr>
endfunction
command! -nargs=0 DelAllBufs :call DelAllBufs()<cr>

" start or attach to a terminal on the bottom right
function! PopupTerm()
    999 wincmd j
    if &buftype ==? 'terminal'
        normal! a
    else
        bot term ++rows=20
        setlocal winfixheight
    endif
endfunction
" split or start a terminal on the bottom right
function! PopupSplitTerm()
    999 wincmd j
    if &buftype ==? 'terminal'
        vs
        wincmd l
        term ++curwin
        setlocal winfixheight
    else
        call PopupTerm()
    endif
endfunction


""" Keys


let g:mapleader = ' '

" open a terminal on the bottom right
nno <leader>zz :call PopupTerm()<cr>
nno <leader>zv :call PopupSplitTerm()<cr>

" cd to the current file directory
nno <leader>cd :cd %:h<cr>
" copy the path of the current directory
nno <leader>cr ;let @+ = expand('%;h:p')<cr>

" select the last pasted command
nno gp `[v`]

" allow switching window without pressing <c-w>
nno <c-j> <c-w>j
nno <c-k> <c-w>k
nno <c-h> <c-w>h
nno <c-l> <c-w>l

" put searches in the jump list
nno / m`/
nno ? m`?

" allow quick diff operations
nno <leader>du :diffupdate<cr>
nno <leader>dg :diffget<cr>
nno <leader>dp :diffput<cr>
" get ours
nno <leader>d3 :diffget //3<cr>
" get theirs
nno <leader>d2 :diffget //2<cr>

" escape clears search
nno <esc><esc> :nohlsearch<cr>

" quick pasting of the main register in the terminal
tmap <c-w>p <c-w>""
" use <c-r> like in insert mode in the terminal
tmap <c-w><c-r> <c-w>"


""" Plugins


call plug#begin('~/.vim/plugged')

    " visual undo trees
    Plug 'simnalamburt/vim-mundo'

    " sensible default settings
    Plug 'tpope/vim-sensible'

    " surrounding keybindings
    Plug 'tpope/vim-surround'
    " SR surrounds in regex group
    let g:surround_82 = "\\(\r\\)"

    " commenting toggling
    Plug 'tpope/vim-commentary'

    " more next and previous commands
    Plug 'tpope/vim-unimpaired'

    " git integration
    Plug 'tpope/vim-fugitive'
    " fugitive bindings
    nno <leader>ga :Gcommit --amend --no-edit
    nno <leader>gA :Gcommit --amend
    nno <leader>gb :Gblame<cr>
    nno <leader>gc :Gcommit<cr>
    nno <leader>gC :Gcommit --no-edit<cr>
    nno <leader>gd :Gdiff<cr>
    nno <leader>ge :Gedit 
    nno <leader>gf :Gfetch 
    nno <leader>gg :Git! 
    nno <leader>ghh :Git! stash show -p stash@{
    nno <leader>ghl :Git! stash list<cr>
    nno <leader>gha :Git stash apply stash@{
    nno <leader>ghp :Git stash pop
    nno <leader>ghs :Git stash save ""<left>
    nno <leader>ghk :Git stash save -k ""<left>
    nno <leader>gl :Glog 
    nno <leader>gm :Gmerge 
    nno <leader>go :Git checkout 
    nno <leader>goo :Git checkout 
    nno <leader>gob :Git checkout -b 
    nno <leader>got :Git checkout -t origin/
    nno <leader>gp :Gpush<cr>
    nno <leader>gq :Gpull<cr>
    nno <leader>gr :Ggrep 
    nno <leader>g/ :Ggrep "<c-r>/"<cr>
    nno <leader>gs :Gstatus<cr>
    nno <leader>gu :Gpush -u origin<space>
    nno <leader>gw :Gbrowse 
    nno <leader>gz :Gcd 

    " align text
    Plug 'junegunn/vim-easy-align'
    " easy align bindings
    xmap ga <plug>(EasyAlign)
    nmap ga <plug>(EasyAlign)
    xmap gA <plug>(LiveEasyAlign)
    nmap gA <plug>(LiveEasyAlign)

    " light status line
    Plug 'vim-airline/vim-airline'
    " enable special fonts
    let g:airline_powerline_fonts = 1
    " enable tabline
    let g:airline#extensions#tabline#enabled = 1
    " airline colors
    Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme='base16'

    " fuzzy finding
    Plug 'ctrlpvim/ctrlp.vim'
    " ignore git
    let g:ctrlp_custom_ignore = '\.git$'
    " jump to buffers in the current window or tab
    let g:ctrlp_switch_buffer = 'et'
    " open buffer view quicker
    nno <c-b> :CtrlPBuffer<cr>
    " open file view quicker
    nno <c-f> :CtrlPMRUFiles<cr>

    " filter quickfix list
    Plug 'sk1418/QFGrep'

    " async linting
    Plug 'w0rp/ale'

    " personal wiki
    Plug 'vimwiki/vimwiki'

    " snippet capabilities
    Plug 'SirVer/ultisnips'
    " extra snippets
    Plug 'honza/vim-snippets'
    let g:UltiSnipsSnippetDirectories=['/home/dork/UltiSnips', 'UltiSnips']
    let g:UltiSnipsExpandTrigger =  '<c-e>'

    " edit registers as buffers
    Plug 'rbong/vim-regbuf'

    " vi file manager inside vim
    Plug 'rbong/neovim-vifm'
    " live directory switching
    let g:vifmLiveCwd=1
    " shortcuts
    nno <leader>fm :Vifm .<CR>

    " base16 colors
    Plug 'chriskempson/base16-vim'

    " better javascript compatibility
    Plug 'pangloss/vim-javascript', {'for':'javascript'}

call plug#end()


""" Bugfixes


if has('terminal')
    " default shell in case system defaults aren't picked up
    set shell=zsh

    " ensure terminals are colored correctly
    " unfortunately makes the color turn pink when ALE sets highlights
    set term=xterm-256color
    " prevent the cursor from turning pink
    let g:ale_set_highlights=0
endif

augroup mybugfixes
    if has('terminal')
        " fix terminal drawing errors
        au Terminalopen * redraw!
    endif
    if has('terminal')
        " make sure airline is up to date
        " must be silent or having a terminal open sometimes causes errors
        au BufWinEnter * silent! AirlineRefresh
    endif
    
    " on startup setting the scheme causes errors so do it in a hook instead
    " no way to check if we can actually do this, so silence errors
    autocmd VimEnter * silent! colorscheme base16-default-dark
augroup END
