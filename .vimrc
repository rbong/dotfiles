""" Settings


" syntax highlighting
syntax on

" persistence
set undofile
set undodir=~/.vim/undo

" store swapfiles somewhere else
set directory=~/.vim/swap

" indentation behaviour (see :help)
set shiftwidth=2 tabstop=2 expandtab nocindent nosmartindent autoindent
filetype plugin indent on

" ignore search case in search unless if uppercase letters are included
set ignorecase smartcase

" show relative line numbers
set relativenumber
" show the actual number for the current line
set number

" always show the tabline
set showtabline=2

" highlight searches
set hlsearch

" ignore version control directories
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

augroup MyFileSettings
    " vim syntax highlighting for vifm
    au BufNewFile,BufRead vifmrc,*.vifm set filetype=vim

    " xml syntax highlighting for ROS
    au BufNewFile,BufRead *.launch set filetype=xml

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

" easy clipboard access
map "" "+
map "' "_

" allow switching window without pressing <c-w>
nno <c-j> <c-w>j
nno <c-k> <c-w>k
nno <c-h> <c-w>h
nno <c-l> <c-w>l

" swap ' and `
no ' `
no ` '

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
    " tpope plugins

    " better replacement
    Plug 'tpope/vim-abolish'

    " commenting toggling
    Plug 'tpope/vim-commentary'

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

    " more repeating motions for tpope plugins
    Plug 'tpope/vim-repeat'

    " sensible default settings
    Plug 'tpope/vim-sensible'

    " automatic indent detection
    Plug 'tpope/vim-sleuth'

    " surrounding keybindings
    Plug 'tpope/vim-surround'
    " SR surrounds in regex group
    let g:surround_82 = "\\(\r\\)"

    " more next and previous commands
    Plug 'tpope/vim-unimpaired'

    " my plugins

    " edit registers as buffers
    Plug 'rbong/vim-buffest'
    nno c,q :Qflistsplit filename lnum col type valid text<cr>
    nno c,l :Loclistsplit filename lnum col type valid text<cr>

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

    " fugitive-based branch viewer
    Plug 'rbong/vim-flog'
    let g:flog_default_arguments = {
                \ 'date': 'short',
                \ }

    " vi file manager inside vim
    Plug 'rbong/neovim-vifm'
    " live directory switching
    let g:vifmLiveCwd=1
    " width
    let g:vifmSplitWidth=40
    " shortcuts
    nno <leader>fm :Vifm .<CR>

    " misc. plugins

    " async linting
    Plug 'w0rp/ale'
    let g:ale_completion_enabled = 1

    " fuzzy finding
    Plug 'ctrlpvim/ctrlp.vim'
    " ignore git
    let g:ctrlp_custom_ignore = '\.git$\|^cvim-'
    " jump to buffers in the current window or tab
    let g:ctrlp_switch_buffer = 'et'
    " open buffer view quicker
    nno <c-b> :CtrlPBuffer<cr>
    " open file view quicker
    nno <c-f> :CtrlPMRUFiles<cr>

    " completion
    Plug 'Shougo/deoplete.nvim'
    " dependencies
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    " config
    let g:deoplete#enable_at_startup = 1

    " cross-system clipboard support
    if !has('clipboard')
        Plug 'kana/vim-fakeclip'
    endif

    " dracula color scheme
    Plug 'dracula/vim', {'as':'dracula'}
    let g:dracula_colorterm=0

    " automatic tags
    Plug 'ludovicchabant/vim-gutentags'

    " lighter status line
    Plug 'itchyny/lightline.vim'
    " bufferline for lightline
    Plug 'mengelbrecht/lightline-bufferline'
    "" config
    let g:lightline = { 'colorscheme': 'darcula' }
    " bufferline settings
    let g:lightline#bufferline#show_number = 1
    let g:lightline#bufferline#shorten_path = 1
    let g:lightline#bufferline#unnamed = '[No Name]'
    " functions
    let g:LightlineBufftabs = { -> tabpagenr('$') == 1 ? lightline#bufferline#buffers() : lightline#tabs() }
    " components
    let g:lightline.component = { 'tabmode': '%{tabpagenr("$") == 1 ? "BUFFERS" : "TABS"}' }
    let g:lightline.component_function = { 'gitbranch': 'fugitive#head' }
    let g:lightline.component_expand = { 'bufftabs': 'g:LightlineBufftabs' }
    let g:lightline.component_type = { 'bufftabs': 'tabsel' }
    " statusline / tabline
    let g:lightline.active = { 'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']] }
    let g:lightline.tabline = { 'left': [['bufftabs']], 'right': [['tabmode']] }


    " visual undo trees
    Plug 'simnalamburt/vim-mundo'
    nno <leader>mm :MundoToggle<CR>

    " language plugins
    Plug 'sheerun/vim-polyglot'

    " align text
    Plug 'godlygeek/tabular'
    nno ga :Tabular /
    vno ga :Tabular /

    " lots of new text objects for vim
    Plug 'wellle/targets.vim'

    " snippet capabilities
    Plug 'SirVer/ultisnips'
    " extra snippets
    Plug 'honza/vim-snippets'
    let g:UltiSnipsSnippetDirectories=['~/.vim/UltiSnips', 'UltiSnips']
    let g:UltiSnipsExpandTrigger = '<c-e>'
    let g:UltiSnipsListSnippets = '<s-tab>'

    " personal wiki
    Plug 'vimwiki/vimwiki'
call plug#end()

" Post-load plugin configuration

" dracula
colorscheme dracula
