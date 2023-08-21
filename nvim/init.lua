-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)


-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Omni complete
      'hrsh7th/cmp-omni',

      -- Buffer word complete
      'hrsh7th/cmp-buffer',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    opts = {
      triggers_nowait = { "<d-r>" }
    },
    config = function()
      local actions = require("which-key.plugins.registers").actions
      table.insert(actions, { trigger = "<d-r>", mode = "c" })
      table.insert(actions, { trigger = "<d-r>", mode = "i" })

      require("which-key").setup()
    end,
  },


  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        --vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',         opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- Example plugins that came with kickstart.nvim
  require 'kickstart.plugins.debug',

  -- Location for cuatom plugins
  -- For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'custom.plugins' },
}, {})

-- [[ Setting Options ]]
-- See `:help vim.o`

-- Show line numbers
vim.o.number = true

-- Confirm instead of error
vim.o.confirm = true

-- Disable backup and swap files
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- Open file in vsplit
vim.o.splitright = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Clipboard
vim.o.clipboard = 'unnamedplus'

-- Search
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false

-- Indentation configuration
vim.o.autoindent = true
vim.o.cindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.cino = "+=(0"
vim.o.wrap = false

-- Scroll before endof screen
vim.o.scrolloff = 8

-- Visible Spaces
vim.o.list = true
vim.o.listchars = "tab:──┤,trail:·"


-- [[ Setting Options Neovim ]]

-- Use persistent undo
vim.o.undofile = true

-- Decrease update time
vim.o.updatetime = 50
vim.o.timeoutlen = 200

-- Enable break indent
vim.o.breakindent = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- nvim-qt doesn't automatically check for changes when the window gains focus.
-- This adds a call to :checktime when the window gains focus.
-- See https://github.com/neovim/neovim/issues/1936#issuecomment-705011327
vim.api.nvim_create_autocmd("FocusGained", {
  pattern = { "*" },
  command = "checktime",
})

-- [[ Keymaps ]]
-- See `:help vim.keymap.set()`

-- Chunk Scrolling
vim.keymap.set({ 'n', 'v' }, '<C-j>', '}', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-k>', '{', { silent = true })
-- I would've liked these but they seem broken in Neovim
--vim.keymap.set({'n', 'v'}, '<space>', '}', { silent = true })
--vim.keymap.set({'n', 'v'}, '<s-space>', '{', { silent = true })

-- When line wraps up/down also navigate through same line
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Paste and keep register
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Navigate to next quick fix entry
vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>")
vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>")

-- Git merges

-- TODO: Why do I need to use a mark to avoid the cursor moving one line down
-- after the keybind is executed?
-- :extra_next_line
local function leader3()
  vim.fn.setreg("l", vim.api.nvim_replace_termcodes("mX:diffget //3<CR>'X", true, true, true))
  vim.cmd('normal @l')
end
vim.keymap.set('n', '<leader>3', leader3, { desc = 'Merge get right' })

-- :extra_next_line
local function leader2()
  vim.fn.setreg("h", vim.api.nvim_replace_termcodes("mX:diffget //2<CR>'X", true, true, true))
  vim.cmd('normal @h')
end
vim.keymap.set('n', '<leader>2', leader2, { desc = 'Merge get left' })

-- :extra_next_line
local function leader1()
  vim.fn.setreg("b", vim.api.nvim_replace_termcodes("mX:diffget //1<CR>'X", true, true, true))
  vim.cmd('normal @b')
end
vim.keymap.set('n', '<leader>1', leader1, { desc = 'Merge get base' })

vim.keymap.set('n', '<leader>mc', ':Git mergetool<CR>', { desc = '[M]erge Qui[c]k List' })
vim.keymap.set('n', '<leader>mm', '<C-w><C-o>:Gvdiffsplit!<CR>', { desc = '[M]erge Split' })
vim.keymap.set('n', '<leader>mb', ':Ghdiffsplit<CR>:resize 10<CR><C-w><C-w>', { desc = '[M]erge Split [B]ase' })

-- Populate quickfix with staged changes
vim.keymap.set('n', '<leader>dc', ':Git difftool --cached<CR><C-w><C-o>', { desc = '[D]iff Qui[c]k List' })

vim.keymap.set('n', '<leader>dd', ':Gvdiff HEAD<CR>zR<C-w>hzR<C-w>L', { desc = '[D]iff Open' })
vim.keymap.set('n', '<leader>dx', 'mX<C-w>h:q<CR>`X', { desc = '[D]iff E[x]it' })

-- Restore from diff
vim.keymap.set('n', '<leader>dg', ':diffget<CR>', { desc = '[D]iff [G]et' })

-- Diff against clipboard
local function clipboard_diff()
  local ftype = vim.api.nvim_eval("&filetype")
  vim.cmd("vsplit")
  vim.cmd([[execute "normal! \<C-w>h"]])
  vim.cmd("enew")
  vim.cmd("file [Clipboard]")
  vim.cmd("normal! P")
  vim.cmd("setlocal buftype=nofile")
  vim.cmd("setlocal bufhidden=delete")
  vim.cmd("set filetype=" .. ftype)
  vim.cmd("diffthis")
  vim.cmd([[execute "normal! \<C-w>l"]])
  vim.cmd("diffthis")
  vim.cmd("normal! zR]c")
end
vim.keymap.set('n', '<leader>dp', clipboard_diff, { desc = '[D]iff [P]aste' })


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local telescope_actions = require("telescope.actions")
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<esc>'] = telescope_actions.close,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
--vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

--vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })

local search_files = function()
  require('telescope.builtin').find_files {
    path_display = { "truncate" }
  }
end
vim.keymap.set('n', '<leader><space>', search_files)
vim.keymap.set('n', '<leader>sf', search_files, { desc = '[S]earch [F]iles' })

vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'java' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- TODO: Disabled because it conflicts with current chunked navigation, what is this useful for?.
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {}, -- Doesn't support unity builds (see https://github.com/clangd/clangd/issues/45)
  -- gopls = {},
  pyright = {},
  -- rust_analyzer = {},
  tsserver = {},
  jdtls = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Resolves a string into a sequence of keycodes that can be passed to
-- nvim_feedkeys()
local function rslv(str)
  return vim.api.nvim_replace_termcodes(str, true, false, true)
end

-- [[ Snippets ]]
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

-- TODO(sleon): Add my C prf -> printf("<++>", <++>) snippet

-- TODO(sleon): This doesn't handle the case where the cursor in insert mode is
-- already at the start of a placeholder. It will skip that first placeholder.
local function jump_placeholder_is(direction)
  if luasnip.locally_jumpable(direction) then
    luasnip.jump(direction)
  else
    local search_reg = vim.fn.getreginfo('/')
    local ph_start = '<+'
    local ph_end = '+>'

    local mvmt = ''
    if vim.fn.mode() ~= 's' then
      mvmt = 'l'
    end

    local search_flags = "";
    if direction == -1 then
      search_flags = "b"
    end
    if vim.fn.search('\\V' .. ph_start .. '\\_.\\{-}' .. ph_end, search_flags) == 0 then
      -- TODO(sleon): Would be nicer to show an error message in the status bar here.
      return -1
    end

    vim.api.nvim_feedkeys(rslv("<esc>" .. mvmt .. "v/") .. ph_end .. rslv("/e<CR>o<C-g><C-r>_"), 'm', true)

    -- TODO(sleon): For some reason this doesn't work, we always loose the last
    -- search pattern... it becomes ph_end
    vim.fn.histdel("search", -1)
    vim.fn.setreg('/', search_reg)
  end
end

local function jump_next_placeholder_is()
  jump_placeholder_is(1)
end
vim.keymap.set({'i', 's'}, '<C-t>', jump_next_placeholder_is)

local function jump_prev_placeholder_is()
  jump_placeholder_is(-1)
end
vim.keymap.set({'i', 's'}, '<C-h>', jump_prev_placeholder_is)

local function jump_placeholder_n(direction)
  vim.cmd('startinsert')
  if jump_placeholder_is(direction) == -1 then
    vim.api.nvim_feedkeys(rslv("<esc>"), 't', true)
  end
end

local function jump_next_placeholder_n()
  jump_placeholder_n(1)
end
vim.keymap.set('n', '<C-t>', jump_next_placeholder_n)

local function jump_prev_placeholder_n()
  jump_placeholder_n(-1)
end
vim.keymap.set('n', '<C-h>', jump_prev_placeholder_n)


-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    {
      name = 'omni',
      option = {
        disable_omnifuncs = { 'v:lua.vim.lsp.omnifunc' }
      }
    },
    { name = 'buffer' }
  },
}

pcall(require, 'psplx')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
