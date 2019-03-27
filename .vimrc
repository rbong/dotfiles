""" Settings


" syntax highlighting
syntax on

" persistence
set undofile
set undodir=~/.vim/undo

" store swapfiles somewhere else
set directory=~/.vim/swap

" allow project-specific .vimrc files
set exrc

" indentation behaviour (see :help)
set shiftwidth=2 tabstop=2 expandtab nocindent nosmartindent autoindent
filetype plugin indent on

" ignore search case in search unless if uppercase letters are included
set ignorecase smartcase

" show relative line numbers
set relativenumber
" show the actual number for the current line
set number

" highlight searches
set hlsearch

" ignore version control directories
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

augroup MyFileSettings
    " vim syntax highlighting for vifm
    au BufNewFile,BufRead vifmrc,*.vifm set filetype=vim

    " do not persist password files
    au BufNewFile,BufRead */pass.*/* setlocal noswapfile noundofile
augroup END


""" Commands


" sorry nothing


""" Keys


let g:mapleader = ' '

" cd to the current file directory
nno <leader>cd :cd %:h<cr>
" copy the path of the current file
nno <leader>cf :let @" = expand('%:h')<cr>
" go up in the directory structure
nno <leader>cc :cd ..<cr>

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

" escape clears search
nno <esc><esc> :nohlsearch<cr>

if has('terminal')
    " quick pasting of the main register in the terminal
    tmap <c-w>p <c-w>""
    " use <c-r> like in insert mode in the terminal
    tmap <c-w><c-r> <c-w>"
endif


""" Plugins


call plug#begin('~/.vim/plugged')
    " visual undo trees
    Plug 'simnalamburt/vim-mundo'
    nno <leader>mm :MundoToggle<CR>

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

    " better replacement
    Plug 'tpope/vim-abolish'

    " more repeating motions for tpope plugins
    Plug 'tpope/vim-repeat'

    " automatic indent detection
    Plug 'tpope/vim-sleuth'

    " git integration
    Plug 'tpope/vim-fugitive'
    " fugitive bindings
    nno <leader>ghh :Git! stash show -p stash@{
    nno <leader>ghl :Git! stash list<cr>
    nno <leader>gha :Git stash apply stash@{
    nno <leader>ghp :Git stash pop
    nno <leader>ghs :Git stash push<space>
    nno <leader>go :Git checkout<space>
    nno <leader>goo :Git checkout<space>
    nno <leader>gob :Git checkout -b<space>
    nno <leader>got :Git checkout -t origin/
    nno <leader>gr :Ggrep ""<left>
    nno <leader>g/ :Ggrep "<c-r>/"<cr>
    nno <leader>gs :Gstatus<cr>
    nno <leader>gu :Gpush -u origin<space>
    " fugitive github support
    Plug 'tpope/vim-rhubarb'

    " fugitive-based branch viewer
    Plug 'rbong/vim-flog'
    let g:flog_default_date_format = 'short'

    " align text
    Plug 'godlygeek/tabular'
    nno ga :Tabular /

    " light status line
    Plug 'vim-airline/vim-airline'
    " enable special fonts
    let g:airline_powerline_fonts = 1
    " enable tabline
    let g:airline#extensions#tabline#enabled = 1
    " airline colors
    Plug 'vim-airline/vim-airline-themes'

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

    " async linting
    Plug 'w0rp/ale'

    " personal wiki
    Plug 'vimwiki/vimwiki'

    " snippet capabilities
    Plug 'SirVer/ultisnips'
    " extra snippets
    Plug 'honza/vim-snippets'
    let g:UltiSnipsSnippetDirectories=['~/.vim/UltiSnips', 'UltiSnips']
    let g:UltiSnipsExpandTrigger = '<c-e>'
    let g:UltiSnipsListSnippets = '<s-tab>'

    " automatic tags
    Plug 'ludovicchabant/vim-gutentags'

    " edit registers as buffers
    Plug 'rbong/vim-buffest'
    nno c,q :Qflistsplit filename lnum col type valid text<cr>
    nno c,l :Loclistsplit filename lnum col type valid text<cr>

    " vi file manager inside vim
    Plug 'rbong/neovim-vifm'
    " live directory switching
    let g:vifmLiveCwd=1
    " width
    let g:vifmSplitWidth=40
    " shortcuts
    nno <leader>fm :Vifm .<CR>

    if has('terminal')
        " smooth terminal
        Plug 'rbong/vim-butter'
        " fix ALE/'term' bug where the cursor changes color
        let g:butter_fixes_color_ale=1
        " terminal height
        let g:butter_popup_options='++rows=15'
        " butter keybindings
        nno <leader>zz :ButterPopup<cr>
        nno <leader>zv :ButterSplit<cr>
    endif

    " dracula color scheme
    Plug 'dracula/vim', {'as':'dracula'}
    let g:dracula_colorterm=0

    " automatically handle language plugins
    Plug 'sheerun/vim-polyglot'

    " lots of new text objects for vim
    Plug 'wellle/targets.vim'
call plug#end()


""" Bugfixes


augroup MyBugFixes
    " on startup setting the scheme causes errors so do it in a hook instead
    " no way to check if we can actually do this, so silence errors
    autocmd VimEnter * silent! colorscheme dracula
    " this also seems to fail if done outside of VimEnter
    autocmd VimEnter * silent! AirlineTheme dracula
augroup END


""" Security

" prevent strange .vimrc files from running unsafe commands
" must be placed at the end of this file
set secure
