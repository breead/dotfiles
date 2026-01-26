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
