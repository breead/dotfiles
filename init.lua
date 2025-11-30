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

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

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

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
vim.o.tabstop = 4

vim.o.shiftwidth = 4

vim.o.expandtab = true

vim.o.relativenumber = true

vim.filetype.add({
  extension = {
    h = "c", -- Treat .h files as C
  },
})
