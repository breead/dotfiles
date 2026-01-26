-- ~/.config/nvim/ftplugin/text.lua

-- Soft-wrap long lines nicely
vim.opt_local.wrap = true
vim.opt_local.linebreak = true     -- wrap at word boundaries
vim.opt_local.breakindent = true   -- keep indent on wrapped lines
vim.opt_local.showbreak = "↳ "     -- prefix for wrapped screen lines (optional)

-- Make j/k move by *screen* lines when wrapped
vim.keymap.set("n", "j", "gj", { buffer = true, silent = true })
vim.keymap.set("n", "k", "gk", { buffer = true, silent = true })

-- Optional: better horizontal nav on wrapped lines
vim.keymap.set({ "n", "x", "o" }, "0", "g0", { buffer = true })
vim.keymap.set({ "n", "x", "o" }, "$", "g$", { buffer = true })
