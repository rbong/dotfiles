------------------------------
------ General Settings ------
------------------------------

-- persistence
vim.o.undofile = true
vim.o.undodir = vim.fn.fnamemodify("~/.local/share/nvim/undo", ":p")

-- store swapfiles somewhere else
vim.o.directory = vim.fn.fnamemodify("~/.local/share/nvim/swap", ":p")

-- indentation behaviour (see :help)
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.cindent = false
vim.o.smartindent = false
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.cmd([[ filetype plugin indent on ]])

-- ignore search case unless uppercase included
vim.o.ignorecase = true
vim.o.smartcase = true

-- show relative line numbers
vim.o.relativenumber = true
-- show the actual number for the current line
vim.o.number = true

-- always show the tabline
vim.o.showtabline = 2

-- highlight searches
vim.o.hlsearch = true

-- ignore version control dirs
vim.opt.wildignore:append({ "*/.git/*", "*/.hg/*", "*/.svn/*" })

-- use real colors
vim.o.termguicolors = true

-- Windows fixes
vim.o.background = "dark"
vim.o.t_u7 = ""
vim.o.t_ut = ""

-- vim enter settings
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("MyVimEnterSettings", {}),
  callback = function(event)
    -- disable undercurl, causes problems in some termials
    vim.o.t_Cs = ""
    -- turn off conceal level, misleading
    vim.o.conceallevel = 0
  end,
})

-------------------------------
------ Filetype Settings ------
-------------------------------

-- helpers
local file_settings_group = vim.api.nvim_create_augroup("MyFileSettings", {})
local function file_settings(pattern, callback)
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = file_settings_group,
    pattern = pattern,
    callback = callback,
  })
end

-- asm settings
file_settings({ "*.asm", "*.inc" }, function()
  -- set syntax to ASM
  vim.o.filetype = "asm"
end)

-- pass file settings
file_settings({ "*/pass.*/*" }, function()
  -- do not persist
  vim.opt_local.swapfile = false
  vim.opt_local.undofile = false
end)

-- ROS launch file settings
file_settings({ "*.launch" }, function()
  -- set syntax to XML
  vim.o.filetype = "xml"
end)

-- semantic UI settings
file_settings({ "*/semantic-ui/theme.config", "*/semantic-ui/*.variables", "*/semantic-ui/*.overrides" }, function()
  -- set syntax to Less
  vim.o.filetype = "less"
end)

-- vifm settings
file_settings({ "vifmrc", "*.vifm" }, function()
  -- set syntax to vim
  vim.o.filetype = "vim"
end)

-- xresources settings
file_settings({ "*.Xresources*" }, function()
  -- set syntax to xdefaults
  vim.o.filetype = "xdefaults"
end)

----------------------
------ Mappings ------
----------------------

-- set leader key to space
vim.g.mapleader = " "

-- list all leader mappings
vim.keymap.set("n", "<leader>?", ":nno <lt>leader><CR>", { noremap = true })

-- cd to file parent
vim.keymap.set("n", "<leader>cd", ":<C-U>cd %:h<CR>", { noremap = true })
-- copy filename
vim.keymap.set("n", "<leader>cf", ":<C-U>let @\" = expand('%:p')<CR>", { noremap = true })
-- go to parent dir
vim.keymap.set("n", "<leader>cc", ":<C-U>cd ..<CR>", { noremap = true })

-- select the last pasted command
vim.keymap.set("n", "gp", "`[v`]", { noremap = true })

-- easy clipboard access
vim.keymap.set({ "n", "v", "o" }, '""', '"+')
vim.keymap.set({ "n", "v", "o" }, "\"'", '"_')

-- quick <C-W> mappings
vim.keymap.set("n", "<C-H>", "<C-W>h", { noremap = true })
vim.keymap.set("n", "<C-J>", "<C-W>j", { noremap = true })
vim.keymap.set("n", "<C-K>", "<C-W>k", { noremap = true })
vim.keymap.set("n", "<C-L>", "<C-W>l", { noremap = true })

-- swap ' and `
vim.keymap.set({ "n", "v", "o" }, "'", "`", { noremap = true })
vim.keymap.set({ "n", "v", "o" }, "`", "'", { noremap = true })

-- put searches in the jumplist
vim.keymap.set("n", "/", "m`/", { noremap = true })
vim.keymap.set("n", "?", "m`?", { noremap = true })

-- escape clears search
vim.keymap.set("n", "<ESC><ESC>", ":<C-U>nohlsearch<CR>", { silent = true, noremap = true })

-- paste in terminal with <C-W>p
vim.keymap.set("t", "<C-W>p", "<C-\\><C-N>pa", { noremap = true })
-- use register in terminal with <C-W><C-R>
vim.keymap.set("t", "<C-W><C-R>", "<C-\\><C-N><C-R>", { noremap = true })

---------------------
------ Plugins ------
---------------------

require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  ---
  --- Git Plugins
  ---

  -- git
  use("tpope/vim-fugitive")
  -- github support
  use("tpope/vim-rhubarb")
  -- branch viewer
  use("rbong/vim-flog")

  -- flog settings
  vim.g.flog_default_opts = {
    max_count = 2000,
  }
  vim.g.flog_permanent_default_opts = {
    date = "format:%Y-%m-%d %H:%m",
  }
  vim.g.flog_use_internal_lua = 1

  -- flog settings
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("MyFlogSettings", {}),
    pattern = "floggraph",
    callback = function()
      -- flog general settings
      vim.opt_local.shellslash = true
      -- flog highlight groups
      vim.cmd([[ hi link flogRef Include ]])
      -- flog mappings
      vim.keymap.set("n", "g<CR>", "<Plug>(FlogVSplitCommitPathsRight)", { buffer = true })
    end,
  })

  -- git mappings
  vim.keymap.set("n", "<leader>gk", ":<C-U>Flog", { noremap = true })
  vim.keymap.set("n", "<leader>go", ":<C-U>Floggit checkout<Space>", { noremap = true })
  vim.keymap.set("n", "<leader>goo", ":<C-U>Floggit checkout<Space>", { noremap = true })
  vim.keymap.set("n", "<leader>gob", ":<C-U>Floggit checkout -b<Space>", { noremap = true })
  vim.keymap.set("n", "<leader>got", ":<C-U>Floggit checkout -t origin/", { noremap = true })
  vim.keymap.set("n", "<leader>gr", ':<C-U>Ggrep ""<left>', { noremap = true })
  vim.keymap.set("n", "<leader>g/", ':<C-U>Ggrep "<c-r>/"<CR>', { noremap = true })
  vim.keymap.set("n", "<leader>gs", ":<C-U>Floggit -f -s<CR>", { noremap = true })
  vim.keymap.set("n", "<leader>gu", ":<C-U>Floggit push -u origin<Space>", { noremap = true })
  vim.keymap.set("n", "<leader>gzh", ":<C-U>Floggit -s -p stash show -p stash", { noremap = true })
  vim.keymap.set("n", "<leader>gzl", ":<C-U>Floggit -s -p stash list<CR>", { noremap = true })
  vim.keymap.set("n", "<leader>gza", ":<C-U>Floggit -s stash apply<Space>", { noremap = true })
  vim.keymap.set("n", "<leader>gzp", ":<C-U>Floggit -s stash pop", { noremap = true })
  vim.keymap.set("n", "<leader>gzz", ":<C-U>Floggit -s stash push<Space>", { noremap = true })

  ---
  --- LSP/Lint Plugins
  ---

  -- linting/formatting
  use("w0rp/ale")

  -- general ALE settings
  vim.g.ale_disable_lsp = 1
  vim.g.ale_use_neovim_diagnostics_api = 1

  -- autopep8 settings
  vim.g.ale_python_autopep8_executable = vim.fn.trim(vim.fn.system("which autopep8 || true"))
  vim.g.ale_python_autopep8_use_global = 1

  -- ALE linter setup
  vim.g.ale_linters = {
    asm = {},
    css = { "stylelint" },
    javascript = { "eslint" },
    javascriptreact = { "eslint" },
    go = { "gofmt" },
    less = { "stylelint" },
    lua = {},
    python = { "flake8", "pyls" },
    scss = { "stylelint" },
    terraform = { "terraform" },
    typescript = { "eslint" },
  }

  -- ALE fixer setup
  vim.g.ale_fixers = {
    asm = {},
    css = { "stylelint", "prettier" },
    javascript = { "eslint", "prettier" },
    javascriptreact = { "eslint", "prettier" },
    go = { "gofmt" },
    graphql = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    less = { "stylelint", "prettier" },
    lua = { "stylua" },
    markdown = { "prettier" },
    openapi = { "prettier" },
    python = { "autopep8" },
    scss = { "stylelint", "prettier" },
    svelte = { "prettier" },
    terraform = { "terraform" },
    typescript = { "eslint", "prettier" },
    yaml = { "prettier" },
  }

  -- ALE mappings
  vim.keymap.set("n", "<leader>ll", ":<C-U>ALEToggle<CR>", { noremap = true })
  vim.keymap.set("n", "<leader>lf", ":<C-U>ALEFix<CR>", { noremap = true })

  -- LSP helpers
  use({
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- configure typescript-language-server
      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })

      -- configure lua-language-server
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_init = function(client)
          client.config.settings = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            -- use the luajit runtime
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              -- make the server aware of Neovim runtime files
              -- TODO: broken
              library = { vim.env.VIMRUNTIME },
            },
          })
          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          return true
        end,
      })

      -- diagnostic settings
      vim.diagnostic.config({ virtual_text = false })

      -- diagnostic mappings
      vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

      -- LSP mappings
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("MyLspMappings", {}),
        callback = function(event)
          local opts = { buffer = event.buf }
          -- enable omnifunc completion
          vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
          -- list all references for keyword
          vim.keymap.set("n", "<space>l/", vim.lsp.buf.references, opts)
          -- list code actions
          vim.keymap.set({ "n", "v" }, "<space>la", vim.lsp.buf.code_action, opts)
          -- go to definition
          vim.keymap.set("n", "<space>lg", vim.lsp.buf.definition, opts)
          -- go to declaration
          vim.keymap.set("n", "<space>lG", vim.lsp.buf.declaration, opts)
          -- display keyword hovering info
          vim.keymap.set("n", "<space>lh", vim.lsp.buf.hover, opts)
          -- rename keyword
          vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, opts)
          -- go to type definition
          vim.keymap.set("n", "<space>lt", vim.lsp.buf.type_definition, opts)
        end,
      })
    end,
  })

  ---
  --- Statusline
  ---

  use("rbong/vim-crystalline")

  vim.cmd([[
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
  ]])

  ---
  -- Wiki
  ---

  -- personal wiki
  use("vimwiki/vimwiki")

  -- vimwiki settings
  vim.g.vimwiki_global_ext = 0
  vim.g.vimwiki_list = {
    {
      auto_diary_index = 1,
      auto_generate_links = 1,
      auto_generate_tags = 1,
      auto_tags = 1,
      auto_toc = 1,
      exclude_files = { ".git/**/*" },
      ext = ".wiki",
      name = "My Wiki",
      path = "~/vimwiki/",
      syntax = "markdown",
    },
  }
  vim.g.vimwiki_toc_header = "TOC"

  -- vimwiki mappings
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("MyVimwikiMappings", {}),
    pattern = "vimwiki",
    callback = function()
      -- change map from '=' since that results in a delay
      vim.keymap.set("n", "+", "<Plug>VimwikiAddHeaderLevel", { buffer = true })
      -- change map from '+' since it is now used for header level
      vim.keymap.set("n", "<leader>w<CR>", "<Plug>VimwikiNormalizeLink", { buffer = true })
      vim.keymap.set("v", "<leader>w<CR>", "<Plug>VimwikiNormalizeLinkVisual", { buffer = true })
    end,
  })

  ---
  --- My Other Plugins
  ---

  --- edit registers/lists as buffers
  use("rbong/vim-buffest")

  -- list mappings
  vim.keymap.set("n", "cq", ":<C-U>Qflistsplit filename lnum col type valid text<CR>", { noremap = true })
  vim.keymap.set("n", "cl", ":<C-U>Loclistsplit filename lnum col type valid text<CR>", { noremap = true })

  --- better terminal
  use("rbong/vim-butter")
  --- terminal height
  vim.g.butter_popup_height = 15
  --- command
  vim.g.butter_popup_cmd = "zsh"
  --- disable color fixes, overwrites 'term'
  vim.g.butter_fixes_color = 0
  --- don't redraw on term open
  vim.g.butter_fixes_redraw = false
  --- butter mappings
  vim.keymap.set("n", "<leader>zz", ":<C-U>ButterPopup<cr>", { noremap = true })
  vim.keymap.set("n", "<leader>zv", ":<C-U>ButterSplit<cr>", { noremap = true })

  -- gameboy filetypes
  use("rbong/vim-gb")

  ---
  --- Other TPope Plugins
  ---

  -- better replacement
  use("tpope/vim-abolish")

  -- comment toggling
  use("tpope/vim-commentary")

  -- more repeating motions for tpope plugins
  use("tpope/vim-repeat")

  -- sensible default settings
  use("tpope/vim-sensible")

  -- automatic indent detection
  use("tpope/vim-sleuth")

  -- surrounding keybindings
  use("tpope/vim-surround")
  -- SR surrounds in regex group
  vim.g.surround_82 = "\\(\r\\)"

  -- more vim-like mappings
  use("tpope/vim-unimpaired")

  ---
  --- Other Plugins
  ---

  -- cross-system clipboard support
  if not vim.fn.has("clipboard") then
    use("kana/vim-fakeclip")
  end

  -- fuzzy finder
  use("junegunn/fzf")
  use("junegunn/fzf.vim")
  -- set history size
  vim.env.FZF_DEFAULT_OPTS = "--history-size=10000"
  -- fzf mappings
  vim.keymap.set("n", "<C-P>", ":<C-U>FZF<CR>", { noremap = true })
  vim.keymap.set("n", "<C-F>", ":<C-U>History<CR>", { noremap = true })
  vim.keymap.set("n", "<C-B>", ":<C-U>Buffers<CR>", { noremap = true })

  -- gruvbox color scheme
  use({
    "gruvbox-community/gruvbox",
    config = function()
      vim.cmd([[ colorscheme gruvbox ]])
    end,
  })
  -- customize theme
  vim.g.gruvbox_guisp_fallback = "bg"
  vim.cmd([[ hi! link DiagnosticError GruvboxRedUnderline ]])
  vim.cmd([[ hi! link DiagnosticWarn GruvboxYellowUnderline ]])

  -- undo tree
  use("simnalamburt/vim-mundo")
  -- prefer Python 3
  vim.g.mundo_prefer_python3 = true
  -- mundo mappings
  vim.keymap.set("n", "<leader>mm", ":<C-U>MundoToggle<CR>", { noremap = true })

  -- treesitter helper
  use({
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  })

  -- snippet capabilities
  use("SirVer/ultisnips")
  -- extra snippets
  use("honza/vim-snippets")
  -- ultisnips settings
  vim.g.UltiSnipsSnippetDirectories = { "~/.local/share/UltiSnips", "UltiSnips" }
  vim.g.UltiSnipsExpandTrigger = "<C-E>"
  vim.g.UltiSnipsListSnippets = "<S-Tab>"
  -- ultisnips mappings
  vim.keymap.set("n", "<leader>uu", ":<C-U>UltiSnipsEdit<Space>", { noremap = true })

  -- file manager
  use("vifm/vifm.vim")
  -- vifm settings
  vim.g.vifm_embed_term = 1
  vim.g.vifm_embed_split = 1
  vim.g.vifm_embed_cwd = 1
  vim.g.vifm_replace_netrw = 1
  vim.g.loaded_netrw = 0
  vim.g.loaded_netrwPlugin = 0
  -- vifm mappings
  vim.keymap.set("n", "<leader>fm", ":<C-U>vertical 40Vifm .<CR>", { noremap = true })
end)
