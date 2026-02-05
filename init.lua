vim.o.ic = true
vim.o.confirm = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.opt.scrolloff = 10
vim.opt.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.g.have_nerd_font = false
vim.cmd [[
  augroup TerminalSettings
    autocmd!
    " Turn off line numbers etc in terminal buffers
    autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
    " Automatically go into insert mode when opening a terminal
    "autocmd TermOpen * startinsert
  augroup END
]]

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

-- Lazy
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
			config = function()
				require('luasnip.loaders.from_snipmate').lazy_load {}
			end,
		},
		{
		'saghen/blink.cmp',
		dependencies = {{'L3MON4D3/LuaSnip', version = '2.*'}},

		-- use a release tag to download pre-built binaries
		version = '1.*',
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
		  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		  -- 'super-tab' for mappings similar to vscode (tab to accept)
		  -- 'enter' for enter to accept
		  -- 'none' for no mappings
		  --
		  -- All presets have the following mappings:
		  -- C-space: Open menu or open docs if already open
		  -- C-n/C-p or Up/Down: Select next/previous item
		  -- C-e: Hide menu
		  -- C-k: Toggle signature help (if signature.enabled = true)
		  --
		  -- See :h blink-cmp-config-keymap for defining your own keymap
		  keymap = { preset = 'default' },

		  completion = {
		    trigger = {show_on_keyword = true},
		  },

		  appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'none',
			kind_icons = {
				Text = 'T',
				Snippet = 'S',
				File = 'F',
			},

		  },

		  -- (Default) Only show the documentation popup when manually triggered
		  completion = { documentation = { auto_show = false } },

		  -- Snippets
		  snippets = { preset = 'luasnip' },

		  -- Default list of enabled providers defined so that you can extend it
		  -- elsewhere in your config, without redefining it, due to `opts_extend`
		  sources = {
			default = { 'path', 'snippets' },
		  },

		  -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		  -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		  -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		  --
		  -- See the fuzzy documentation for more information
		  fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" }
	  }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = {},
  -- automatically check for plugin updates
  checker = { enabled = true },
})
