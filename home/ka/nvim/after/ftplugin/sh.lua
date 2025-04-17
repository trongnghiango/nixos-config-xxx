vim.opt.wrap = false
vim.opt.textwidth = 0
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

map("i", "'", "''<left>")
map("i", "\"", "\"\"<left>")
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")

-- Automatically create if, case, for-loop, and function templates
map("n", "<leader>i", "Iif [ @ ]; then <CR>@<CR>else<CR>@<CR>fi<ESC>5k0/@<CR>cl")
map("n", "<leader>ca", "Icase \"$@\" in<CR><CR>@)<CR>@<CR>;;<CR><CR>esac<ESC>6k0/@<CR>cl")
map("n", "<leader>fn", "I@() {<CR>    @<CR>}<ESC>4k0/@<CR>cl")
map("n", "<leader>fl", "Ifor i in @<CR>do<CR>@<CR>done<ESC>3k0/@<CR>cl")
map("n", "<leader>wl", "Iwhile [ @ ]<CR>do<CR>@<CR>done<ESC>3k0/@<CR>cl")

-- comment/uncomment current line
map("n", "<leader>cl", "I#<ESC>" )
map("n", "<leader>uc", "I<ESC>x" )

-- color error message
map("n", "<leader>eo", "Iprintf \"%b@errormessage%b\\n\" \"$red\" \"$nc\"  && exit @ <ESC>0/@<CR>ct%" )
-- color warning message
map("n", "<leader>wo", "Iprintf \"%b@statusmessage%b\\n\" \"$yellow\" \"$nc\"<ESC>0/@<CR>ct%" )
-- color status message
map("n", "<leader>so", "Iprintf \"%b@statusmessage%b\\n\" \"$green\" \"$nc\"<ESC>0/@<CR>ct%" )

-- Automatically create if, case, and function templates in insert mode
map("i", ",i", "if [ @ ]; then<CR>@<CR><ESC>Ielse<CR>@<CR>fi<ESC>5k0/@<CR>cl")
map("i", ",ca", "case \"$@\" in <CR><CR> @)<CR>@<CR>;;<CR><CR>esac<ESC>6k0/@<CR>cl")
map("i", ",fn", "@() {<CR>    @<CR>}<ESC>3k0/@<CR>cl")
map("i", ",fl", "for i in @<CR>do<CR>@<CR>done<ESC>3k0/@<CR>cl")
map("i", ",wl", "while [ @ ]<CR>do<CR>@<CR>done<ESC>3k0/@<CR>cl")


