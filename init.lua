vim.o.ic = true
vim.o.confirm = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.opt.scrolloff = 10
vim.opt.number = true

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
