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

augroup MyVimEnterSettings
    " disable undercurl, causes cursor to change color on rxvt
    au VimEnter * set t_Cs=
augroup END

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

" list all leader mappings
nno <leader>? :nno <lt>leader><CR>

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
    nno c\q :Qflistsplit filename lnum col type valid text<cr>
    nno c\l :Loclistsplit filename lnum col type valid text<cr>

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

    Plug 'rbong/vim-crystalline', { 'branch': 'dev' }
    let g:statusline_settings = '%#Crystalline# %{&paste?"PASTE ":""}'
                \ . '%{&spell?"SPELL ":""}'
                \ . '%{get(b:,"ale_enabled",g:ale_enabled)?"ALE ":""}'
                \ . '%{deoplete#is_enabled()?"DEOPLETE ":""}'
    function! StatusLineFile() abort
        let l:name = pathshorten(bufname(bufnr('%')))
        return l:name ==# '' ? '[No Name]' : l:name
    endfunction
    function! StatusLine(current, width) abort
        let l:s = ''
        if a:current
            let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
        else
            let l:s .= '%#CrystallineInactive#'
        endif
        let l:s .= ' %-.40(%{StatusLineFile()}%h%w%m%r%) '
        if a:current
            let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()} '
            let l:s .= '%=' . crystalline#left_sep('', 'Fill') . g:statusline_settings . crystalline#left_mode_sep('')
        else
            let l:s .= '%='
        endif
        if a:width > 80
            let l:s .= ' %{&ft}[%{&enc}][%{&ffs}] %l/%L %3(%c%V%) %P '
        else
            let l:s .= ' '
        endif
        return l:s
    endfunction
    function! TabLine() abort
        return crystalline#bufferline(0, 0, 1)
    endfunction
    let g:crystalline_enable_sep = 1
    let g:crystalline_statusline_fn = 'StatusLine'
    let g:crystalline_tabline_fn = 'TabLine'
    let g:crystalline_theme = 'dracula'

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
    let g:ale_linters = {
                \ 'python': ['pylint', 'yapf', 'pyls'],
                \ }
    nno <leader>aa :ALEToggle<CR>
    nno <leader>aG :ALEGoToDefinition
    nno <leader>ag :ALEGoToDefinition<CR>
    nno <leader>ah :ALEHover<CR>
    nno <leader>ar :ALEFindReferences<CR>
    nno <leader>aR :ALEFindReferences -relative<CR>
    nno <leader>as :ALESymbolSearch<space>
    nno <leader>aS :ALESymbolSearch -relative<space>
    nno <leader>aT :ALEGoToTypeDefinition
    nno <leader>at :ALEGoToTypeDefinition<CR>

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
    let g:deoplete#enable_at_startup = 0
    " bindings
    nno <leader>dd :call deoplete#toggle()<CR>

    " cross-system clipboard support
    if !has('clipboard')
        Plug 'kana/vim-fakeclip'
    endif

    " dracula color scheme
    Plug 'dracula/vim', {'as':'dracula'}
    let g:dracula_colorterm=0

    " automatic tags
    Plug 'ludovicchabant/vim-gutentags'

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

" post-load plugin configuration

" dracula
silent! colorscheme dracula
