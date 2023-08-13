""" Settings


" syntax highlighting
syntax on

" persistence
set undofile
set undodir=~/.local/share/nvim/undo

" store swapfiles somewhere else
set directory=~/.local/share/nvim/swap

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

" use real colors
set termguicolors

" Windows fixes
set background=dark
set t_u7=
set t_ut=

augroup MyVimEnterSettings
    " disable undercurl, causes cursor to change color on rxvt
    " turn off conceal level
    au VimEnter * set t_Cs= conceallevel=0
augroup END

augroup MyFileSettings
    " asm highlighting, broken for unknown reason
    au BufNewFile,BufRead *.asm set filetype=asm

    " vim syntax highlighting for vifm
    au BufNewFile,BufRead vifmrc,*.vifm set filetype=vim

    " assembly files
    au BufNewFile,BufRead *.asm,*.inc set filetype=asm

    " xml syntax highlighting for ROS
    au BufNewFile,BufRead *.launch set filetype=xml

    " less syntax highlighting for semantic ui
    au BufNewFile,BufRead */semantic-ui/theme.config,*/semantic-ui/*.variables,*/semantic-ui/*.overrides set filetype=less

    " do not persist password files
    au BufNewFile,BufRead */pass.*/* setlocal noswapfile noundofile

    " Xresources syntax highlighting
    au BufNewFile,BufRead *.Xresources* set filetype=xdefaults
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
nno <leader>cf :let @" = expand('%:p')<cr>
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
nno <esc><esc> :silent! nohlsearch<cr>

if has('terminal')
    " paste
    tmap <c-w>p <c-w>""
    " use <c-r>
    tmap <c-w><c-r> <c-w>"
endif
if has('nvim')
    " paste
    tmap <c-w>p <c-\><c-n>p
    " use <c-r>
    tmap <c-w><c-r> <c-\><c-n><c-r>
endif


""" Plugins


call plug#begin('~/.local/share/nvim/site/plugged')
    " tpope plugins

    " better replacement
    Plug 'tpope/vim-abolish'

    " commenting toggling
    Plug 'tpope/vim-commentary'

    " git integration
    Plug 'tpope/vim-fugitive'
    " fugitive bindings
    nno <leader>gzh :Floggit -s -p stash show -p stash
    nno <leader>gzl :Floggit -s -p stash list<cr>
    nno <leader>gza :Floggit -s stash apply<space>
    nno <leader>gzp :Floggit -s stash pop
    nno <leader>gzz :Floggit -s stash push<space>
    nno <leader>go :Floggit checkout<space>
    nno <leader>goo :Floggit checkout<space>
    nno <leader>gob :Floggit checkout -b<space>
    nno <leader>got :Floggit checkout -t origin/
    nno <leader>gr :Ggrep ""<left>
    nno <leader>g/ :Ggrep "<c-r>/"<cr>
    nno <leader>gs :Floggit -f -s<cr>
    nno <leader>gu :Floggit push -u origin<space>
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

    if has('terminal') || has('nvim')
        " smooth terminal
        Plug 'rbong/vim-butter'
        " terminal height
        let g:butter_popup_height = 15
        " command
        let g:butter_popup_cmd = 'zsh'
        " disable color fixes, overwrites 'term'
        let g:butter_fixes_color = 0
        " don't redraw on term open
        let g:butter_fixes_redraw = !exists('nvim')
        " butter keybindings
        nno <leader>zz :ButterPopup<cr>
        nno <leader>zv :ButterSplit<cr>
    endif

    " fugitive-based branch viewer
    Plug 'rbong/vim-flog'
    let g:flog_default_opts = {
                \ 'max_count': 2000,
                \ }
    let g:flog_permanent_default_opts = {
                \ 'date': 'format:%Y-%m-%d %H:%m',
                \ }
    let g:flog_use_internal_lua = 1
    augroup MyFlogSettings
        au FileType floggraph setlocal shellslash
        au FileType floggraph hi link flogRef Include
        au FileType floggraph nno <buffer> cuo :<C-U>exec flog#Format("Floggit branch --set-upstream-to origin %l")<CR>
        au FileType floggraph nno <buffer> cu<Space> :<C-U>Floggit branch --set-upstream-to<Space>
        au filetype floggraph nmap <buffer> g<CR> <Plug>(FlogVSplitCommitPathsRight)
    augroup END
    nno <leader>gk :Flog

    Plug 'rbong/vim-gb'

    Plug 'rbong/vim-crystalline'

    let g:statusline_settings = ' %{&paste?"PASTE ":""}'
                \ . '%{&spell?"SPELL ":""}'
                \ . '%{get(b:,"ale_enabled",get(g:, "ale_enabled", 0))?"ALE ":""}'

    function! StatusLineFile() abort
        let l:name = pathshorten(bufname(bufnr('%')))
        return l:name ==# '' ? '[No Name]' : l:name
    endfunction

    function! StatusLine(current, width)
        let l:s = ''

        if a:current
            let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
        else
            let l:s .= '%#CrystallineInactive#'
        endif
        let l:s .= ' %-.40(%{StatusLineFile()}%h%w%m%r%) '
        if a:current
            let l:s .= crystalline#right_sep('', 'Fill')
            let l:s .= '%{crystalline#left_pad(fugitive#Head())}'
            let l:s .= '%{crystalline#left_pad(buffest#get_reg_type_label(expand("%:p")))}'
        endif

        let l:s .= '%='
        if a:current
            let l:s .= crystalline#left_sep('', 'Fill') . g:statusline_settings
            let l:s .= crystalline#left_mode_sep('')
        endif
        if a:width > 80
            let l:s .= ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
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
    let g:crystalline_theme = 'gruvbox'
    let g:crystalline_separators = ["\uE0B8", "\uE0BA"]
    let g:crystalline_tab_separator = "\uE0B9"

    " misc. plugins

    " async linting
    Plug 'w0rp/ale'
    let g:ale_linters = {
                \ 'asm': [],
                \ 'css': ['stylelint'],
                \ 'javascript': ['eslint'],
                \ 'javascriptreact': ['eslint'],
                \ 'go': ['gofmt'],
                \ 'less': ['stylelint'],
                \ 'lua': ['luacheck'],
                \ 'python': ['flake8', 'pyls'],
                \ 'scss': ['stylelint'],
                \ 'terraform': ['terraform'],
                \ 'typescript': ['eslint'],
                \ }
    let g:ale_fixers = {
                \ 'asm': [],
                \ 'css': ['stylelint', 'prettier'],
                \ 'javascript': ['eslint', 'prettier'],
                \ 'javascriptreact': ['eslint', 'prettier'],
                \ 'go': ['gofmt'],
                \ 'graphql': ['prettier'],
                \ 'html': ['prettier'],
                \ 'json': ['prettier'],
                \ 'less': ['stylelint', 'prettier'],
                \ 'lua': ['stylua'],
                \ 'markdown': ['prettier'],
                \ 'openapi': ['prettier'],
                \ 'python': ['autopep8'],
                \ 'scss': ['stylelint', 'prettier'],
                \ 'svelte': ['prettier'],
                \ 'terraform': ['terraform'],
                \ 'typescript': ['eslint', 'prettier'],
                \ 'yaml': ['prettier'],
                \ }

    let g:ale_disable_lsp = 1
    let g:ale_use_neovim_diagnostics_api = 1

    let g:ale_python_autopep8_executable = trim(system('which autopep8 || true'))
    let g:ale_python_autopep8_use_global = 1

    nno <leader>ll :ALEToggle<CR>
    nno <leader>lf :ALEFix<CR>

    " completion
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-path'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'

    " cross-system clipboard support
    if !has('clipboard')
        Plug 'kana/vim-fakeclip'
    endif

    " fuzzy finder
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    nno <c-p> :FZF<CR>
    nno <c-f> :History<CR>
    nno <c-b> :Buffers<CR>
    let $FZF_DEFAULT_OPTS = '--history-size=10000'

    " gruvbox color scheme
    Plug 'gruvbox-community/gruvbox'
    let g:gruvbox_guisp_fallback = 'bg'
    " Windows fix
    " autocmd ColorScheme * hi Normal ctermbg=NONE guibg=NONE
    hi! link DiagnosticError GruvboxRedUnderline
    hi! link DiagnosticWarn GruvboxYellowUnderline

    " visual undo trees
    " Commit is a workaround for https://github.com/simnalamburt/vim-mundo/issues/123
    Plug 'simnalamburt/vim-mundo', { 'commit': '4cc954f' }
    nno <leader>mm :MundoToggle<CR>
    let g:mundo_prefer_python3 = v:true

    " LSP
    Plug 'neovim/nvim-lspconfig'

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
    let g:UltiSnipsSnippetDirectories=['~/.local/share/UltiSnips', 'UltiSnips']
    let g:UltiSnipsExpandTrigger = '<c-e>'
    let g:UltiSnipsListSnippets = '<s-tab>'
    nno <leader>uu :UltiSnipsEdit<space>

    " treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " file manager
    Plug 'vifm/vifm.vim'
    let g:vifm_embed_term = 1
    let g:vifm_embed_split = 1
    let g:vifm_embed_cwd = 1
    let g:vifm_replace_netrw = 1
    let g:loaded_netrw = 0
    let g:loaded_netrwPlugin = 0
    nno <leader>fm :vertical 40Vifm .<CR>

    " personal wiki
    Plug 'vimwiki/vimwiki'
    let g:vimwiki_global_ext = 0
    let g:vimwiki_list = [{
                \ 'auto_diary_index': 1,
                \ 'auto_generate_links': 1,
                \ 'auto_generate_tags': 1,
                \ 'auto_tags': 1,
                \ 'auto_toc': 1,
                \ 'exclude_files': ['.git/**/*'],
                \ 'ext': '.wiki',
                \ 'name': 'My Wiki',
                \ 'path': '~/vimwiki/',
                \ 'syntax': 'markdown',
                \ }]
    let g:vimwiki_toc_header = 'TOC'
    augroup MyVimwikiSettings
        " Change map from '=' since that results in a delay
        au FileType vimwiki nmap <buffer> + <Plug>VimwikiAddHeaderLevel
        " Change map from '+' since it is now used for header level
        au FileType vimwiki nmap <buffer> <leader>w<CR> <Plug>VimwikiNormalizeLink
        au FileType vimwiki vmap <buffer> <leader>w<CR> <Plug>VimwikiNormalizeLinkVisual
    augroup END
call plug#end()

" post-load plugin configuration

colorscheme gruvbox

nmap <leader>s :call SynStack()<CR>
function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" lua plugin configuration

lua <<EOF

-- configure nvim-cmp

local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    window = {},
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-q>'] = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- configure nvim-lspconfig

local lspconfig = require('lspconfig')
lspconfig.tsserver.setup {
    capabilities = capabilities,
}

-- add diagnostic mappings
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('MyLspSettings', {}),
    callback = function(args)
        -- LSP buffer mappings
        local opts = { buffer = args.buf }
        vim.keymap.set('n', '<space>l/', vim.lsp.buf.references, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>la', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<space>lg', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<space>lG', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', '<space>lh', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ls', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>lt', vim.lsp.buf.type_definition, opts)
    end,
})

-- configure nvim-treesitter

require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

EOF
