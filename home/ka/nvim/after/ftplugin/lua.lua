vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.textwidth = 0

map("i", "'", "''<left>")
map("i", "\"", "\"\"<left>")
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")

map("n", "<leader>cl", "I--<ESC>")
map("n", "<leader>uc", "0d2l")

-- function template
map("n", "<leader>fn", "Ifunction @(@)<CR>@<CR>end<ESC>2k0/@<CR>cl")

