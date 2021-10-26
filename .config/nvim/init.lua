
----------------------------------------
-- Plugins
----------------------------------------
require('packer').startup(function()
  -- Packer
  use {
    'wbthomason/packer.nvim'
  }
  
  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- barbar
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  -- doom-one
  use {
    'NTBBloodbath/doom-one.nvim'
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig'
  }

  -- Black
  use {
    'psf/black',
    tag = '19.10b0' -- Too old black version on ubuntu 20.04
    -- branch = 'stable'
  }

  -- File browser
  use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function() require'nvim-tree'.setup {} end
  }
end)

----------------------------------------
-- Settings
----------------------------------------

vim.cmd 'colorscheme doom-one'                             -- Put your favorite colorscheme here
vim.g.mapleader = " "                                      -- Use space as mapleader
vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options
vim.opt.expandtab = true                                   -- Use spaces instead of tabs
vim.opt.hidden = true                                      -- Enable background buffers
vim.opt.ignorecase = true                                  -- Ignore case
vim.opt.joinspaces = false                                 -- No double spaces with join
vim.opt.list = true                                        -- Show some invisible characters
vim.opt.number = true                                      -- Show line numbers
vim.opt.relativenumber = true                              -- Relative line numbers
vim.opt.scrolloff = 4                                      -- Lines of context
vim.opt.shiftround = true                                  -- Round indent
vim.opt.shiftwidth = 2                                     -- Size of an indent
vim.opt.sidescrolloff = 8                                  -- Columns of context
vim.opt.signcolumn = 'yes'                                 -- Always show signcolumn
vim.opt.smartcase = true                                   -- Do not ignore case with capitals
vim.opt.smartindent = true                                 -- Insert indents automatically
vim.opt.splitbelow = true                                  -- Put new windows below current
vim.opt.splitright = true                                  -- Put new windows right of current
vim.opt.tabstop = 2                                        -- Number of spaces tabs count for
vim.opt.termguicolors = true                               -- True color support
vim.opt.wildmode = {'list', 'longest'}                     -- Command-line completion mode
vim.opt.wrap = false                                       -- Disable line wrap


----------------------------------------
-- treesitter
----------------------------------------
require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained", 
  -- List of parsers to ignore installing
  ignore_install = {}, 
  highlight = {
    -- false will disable the whole extension
    enable = true,
    -- list of language that will be disabled
    disable = {},  
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

----------------------------------------
-- barbar
----------------------------------------
-- Set barbar's options
vim.g.bufferline = {
  -- Enable/disable animations
  animation = true,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,


  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  icons = true,

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons on the bufferline.
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',

  -- If true, new buffers will be inserted at the end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', ':BufferPrevious<CR>', opts)
map('n', '<A-.>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
map('n', '<A->>', ' :BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
map('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
map('n', '<A-c>', ':BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
-- Magic buffer-picking mode
map('n', '<C-p>', ':BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

----------------------------------------
-- Telescope
----------------------------------------
require('telescope').setup{
}

vim.api.nvim_set_keymap('n', '<Leader>fb',  [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ff',  [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fgf',  [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fh',  [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fs',  [[<Cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ft',  [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>fs',  [[<Cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fm',  [[<Cmd>lua require('telescope.builtin').man_pages()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fq',  [[<Cmd>lua require('telescope.builtin').quickfix()<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>fgb',  [[<Cmd>lua require('telescope.builtin').git_branches()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fgc',  [[<Cmd>lua require('telescope.builtin').git_commits()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fgm',  [[<Cmd>lua require('telescope.builtin').git_bcommits()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fgs',  [[<Cmd>lua require('telescope.builtin').git_status()<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>fcr',  [[<Cmd>lua require('telescope.builtin').reloader()<CR>]], { noremap = true, silent = true })

----------------------------------------
-- lsp
----------------------------------------
-- TODO: Implement attach func
-- require'lspconfig'.pyright.setup{}
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'pyright'
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

----------------------------------------
-- Black
----------------------------------------
-- TODO: Should only be done for python
vim.api.nvim_set_keymap('n', '<Leader>cf',  [[<Cmd>Black<CR>]], { noremap = true, silent = true })


----------------------------------------
-- File browser
----------------------------------------
require'nvim-tree'.setup{}

vim.api.nvim_set_keymap('n', '<Leader>tb',  [[<Cmd>NvimTreeToggle<CR>]], { noremap = true, silent = true })
