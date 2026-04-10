-- C++ specific settings
vim.cmd('compiler gcc')
vim.opt_local.makeprg = 'g++ -std=c++17 % -Wall -Wextra -o %<'
