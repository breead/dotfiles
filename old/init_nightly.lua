vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.g.mapleader = " "
vim.o.clipboard = 'unnamedplus'

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')

vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/neovim/nvim-lspconfig" }
})

vim.cmd("colorscheme tokyonight")
vim.lsp.enable({ "lua_ls" })

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
