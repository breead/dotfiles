vim.opt.clipboard = "unnamedplus"
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
