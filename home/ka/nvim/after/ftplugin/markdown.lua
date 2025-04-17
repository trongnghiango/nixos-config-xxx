-- options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.textwidth = 78
vim.opt.wrapmargin = 80
vim.opt.colorcolumn = '80'
vim.opt.spell = true

-- fix first spelling error behind/above cursor
map("n", "<leader>sp", "mm[s1z=`m")

-- move current line to the position in list (paragraph).
map("n", "<leader>m1", "kmmjdd{p`m")
map("n", "<leader>m2", "kmmjdd{jp`m")
map("n", "<leader>m3", "kmmjdd{jjp`m")
map("n", "<leader>mb", "kmmjdd}p`m")

function moveline()
	--
end

-- auto close quotes, parenthesis, and brackets
map("i", "'", "''<left>")
map("i", "\"", "\"\"<left>")
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")

-- headers
map("n", "<leader>t", "ggI# ")
map("n", "<leader>h1", "ggI# ")
map("n", "<leader>h2", "I## ")
map("n", "<leader>h3", "I### ")

-- bold, italics, bold-italics, and strike through 
map("n", "<leader>bt", "i**@**<ESC>b/@<CR>cl") 
map("n", "<leader>it", "i*@*<ESC>b/@<CR>cl") 
map("n", "<leader>bi", "i***@***<ESC>b/@<CR>cl")
map("n", "<leader>st", "i~~@~~<ESC>b/@<CR>cl")

-- bullet list
map("n", "<leader>bl", "A<CR><TAB>- @<CR>- @<ESC>3k/@<CR>cl")
map("n", "<leader>nl", "A<CR><TAB>1. @<CR>2. @<ESC>3k/@<CR>cl")

-- code block
map("n", "<leader>cb", "I```@<CR><CR>@<CR><CR>```<ESC>4k/@<CR>cl")

-- link
map("n", "<leader>ln", "i[@]:@<ESC>b/@<CR>cl")

-- table
map("n", "<leader>tbl", "I| @ | @ |<CR>|---|---|<CR>| @ | @ |<ESC>4k/@<CR>cl")


