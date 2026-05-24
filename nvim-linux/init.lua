vim.o.ic = true
vim.o.confirm = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.opt.scrolloff = 10
vim.opt.number = true

-- Indentation options. I want to switch some day to having actual tab
-- characters that are just displayed as spaces in my editor, as I heard that
-- causes fewer problems when collaborating on code.
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.g.have_nerd_font = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Try to get better :command completion
vim.opt.wildoptions = { "pum", "tagfile", "fuzzy" }
vim.o.wildmode = 'longest:full,full'

vim.cmd [[
  augroup TerminalSettings
    autocmd!
    " Turn off line numbers etc in terminal buffers
    autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
    " Automatically go into insert mode when opening a terminal
    "autocmd TermOpen * startinsert
  augroup END
]]

-- !!!! Linux specific options !!!!
-- Use OSC52 for all yank/copy operations
if vim.env.SSH_CONNECTION or vim.env.SSH_TTY then
	vim.g.clipboard = {
		name = 'OSC52',
	  copy = {
	    ['+'] = function(lines, _)
	      require('vim.ui.clipboard.osc52').copy('+')(lines)
	    end,
	    ['*'] = function(lines, _)
	      require('vim.ui.clipboard.osc52').copy('*')(lines)
	    end,
	  },
	  paste = {
	    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
	    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
	  },
	}
end

-- !!!!end linux specific options!!!! --

if vim.fn.has("macunix") == 1 then
  vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
  end)

  -- Fix macOS trackpad scrolling
  vim.o.mousescroll = 'ver:1,hor:6'
end


-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading plugins so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.open_float(0, { scope = 'line' })
end, { desc = 'Diagnostic open float' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- require"vim._core.ui2".enable{}
-- plugin list
-- guess-indent.nvim
-- gitsigns.nvim
-- which-key.nvim
-- telescope.nvim
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
	local kind = ev.data.kind
	local path = ev.data.path
    if path:match('telescope%-fzf%-native%.nvim$') and (kind == 'install' or kind == 'update') then
		vim.system({ 'make' }, { cwd = path }):wait()
	elseif path:match('LuaSnip$') and (kind == 'install' or kind == 'update') then
        vim.system({ 'make', 'install_jsregexp' }, { cwd = path }):wait()
	elseif path:match('blink.cmp$') and (kind == 'install' or kind == 'update') then
        vim.system({ 'cargo', 'build', '--release' }, { cwd = path }):wait()
  	end
end})

vim.pack.add({
	'https://github.com/lewis6991/gitsigns.nvim',
	'https://github.com/nvim-mini/mini.nvim',
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/nvim-treesitter/nvim-treesitter-context',
	'https://github.com/folke/which-key.nvim',
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
	'https://github.com/nvim-telescope/telescope-ui-select.nvim',
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/NMAC427/guess-indent.nvim',
	'https://github.com/L3MON4D3/LuaSnip',
	'https://github.com/saghen/blink.lib',
	'https://github.com/saghen/blink.cmp',
	'https://github.com/windwp/nvim-autopairs',
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',
	'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/folke/tokyonight.nvim',
	'https://github.com/folke/todo-comments.nvim',
	-- 'https://github.com/',
})

if vim.g.have_nerd_font then
	vim.pack.add({'https://github.com/nvim-tree/nvim-web-devicons'})
end

require('tokyonight').setup {
	styles = {
		comments = { italic = false },
	},
}
vim.cmd.colorscheme 'tokyonight-night'

require('todo-comments').setup{
	signs = false
}

require('treesitter-context').setup {}

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup { n_lines = 500 }

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

require('gitsigns').setup {
	signs = {
		add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
		topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
}


require('which-key').setup {
	-- delay between pressing a key and opening which-key (milliseconds)
  	-- this setting is independent of vim.o.timeoutlen
	delay = 0,
  	icons = {
	-- set icon mappings to true if you have a Nerd Font
	mappings = vim.g.have_nerd_font,
	-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
	-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
	keys = vim.g.have_nerd_font and {} or {
		Up = '<Up> ',
		Down = '<Down> ',
		Left = '<Left> ',
		Right = '<Right> ',
		C = '<C-…> ',
		M = '<M-…> ',
		D = '<D-…> ',
		S = '<S-…> ',
		CR = '<CR> ',
		Esc = '<Esc> ',
		ScrollWheelDown = '<ScrollWheelDown> ',
		ScrollWheelUp = '<ScrollWheelUp> ',
		NL = '<NL> ',
		BS = '<BS> ',
		Space = '<Space> ',
		Tab = '<Tab> ',
		F1 = '<F1>',
		F2 = '<F2>',
		F3 = '<F3>',
		F4 = '<F4>',
		F5 = '<F5>',
		F6 = '<F6>',
		F7 = '<F7>',
		F8 = '<F8>',
		F9 = '<F9>',
		F10 = '<F10>',
		F11 = '<F11>',
		F12 = '<F12>',
	},
      },

	-- Document existing key chains
	spec = {
		{ '<leader>s', group = '[S]earch' },
		{ '<leader>t', group = '[T]oggle' },
		{ '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
	},

}

require('telescope').setup {
  -- You can put your default mappings / updates / etc. in here
  --  All the info you're looking for is in `:help telescope.setup()`
  --
  -- defaults = {
  --   mappings = {
  --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
  --   },
  -- },
  -- pickers = {}
  extensions = {
	['ui-select'] = {
	  require('telescope.themes').get_dropdown(),
	},
  },
}

-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set("n", "<leader>sa", function()
				  builtin.find_files({ no_ignore = true, hidden = true })
		  end, { desc = "[S]earch [A]ll files (including hidden)" })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
	winblend = 10,
	previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
	grep_open_files = true,
	prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- end of telescope --

require('guess-indent').setup {}
require("mason").setup()
require('mason-lspconfig').setup()

require('nvim-autopairs').setup {}
require('luasnip.loaders.from_snipmate').lazy_load {
  paths = { vim.fn.stdpath 'config' .. '/snippets' },
}

<<<<<<< HEAD
local cmp = require('blink.cmp')
cmp.build():wait(60000)
cmp.setup()

require('blink.cmp').setup {
      completion = {
=======
require('blink.cmp').setup {      completion = {
>>>>>>> 1fa5de7 (Add treesitter context and fix something)
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {},
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
}

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('minimal-lsp-attach', { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or 'n'
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
		end

		map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
		map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
		map('grr', builtin.lsp_references, '[G]oto [R]eferences')
		map('gri', builtin.lsp_implementations, '[G]oto [I]mplementation')
		map('grd', builtin.lsp_definitions, '[G]oto [D]efinition')
		map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
		map('grt', builtin.lsp_type_definitions, '[G]oto [T]ype Definition')
		map('K', vim.lsp.buf.hover, 'Hover Documentation')
		map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help', 'i')

	end,
})

vim.diagnostic.config {
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = vim.diagnostic.severity.ERROR },
	virtual_text = {
		source = 'if_many',
		spacing = 2,
	},
}

local capabilities = require('blink.cmp').get_lsp_capabilities()

local servers = {
	clangd = {},
	basedpyright = {
		settings = {
			basedpyright = {
				analysis = {
					typeCheckingMode = 'basic',
					diagnosticSeverityOverrides = {
						reportPrivateImportUsage = 'none',
					},
				},
			},
			-- python = {
			-- 	pythonPath = vim.fn.getcwd() .. "/.venv/bin/python"
			-- },
		},
	},
	-- lua_ls = {},
	-- zuban = {},
}

require('mason-tool-installer').setup {
	ensure_installed = vim.tbl_keys(servers),
}

for server_name, server in pairs(servers) do
	server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
	vim.lsp.config(server_name, server)
	vim.lsp.enable(server_name)
end
