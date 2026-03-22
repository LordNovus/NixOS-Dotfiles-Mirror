-- KEYBINDS
vim.g.mapleader = " " -- Set leader variable

-- Escape insert with Ctrl+C
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Move visual lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Center screen when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste and don't replace clipboard over deleted text
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- yank into clipboard even if on ssh
vim.keymap.set('n', '<leader>y', '<Plug>OSCYankOperator')
vim.keymap.set('v', '<leader>y', '<Plug>OSCYankVisual')

-- QUICKFIX
-- Cycle fixes
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")

-- Quickfix controls
vim.keymap.set("n", "<leader>cl", ":cclose<CR>", { silent = true })
vim.keymap.set("n", "<leader>co", ":copen<CR>", { silent = true })
vim.keymap.set("n", "<leader>cn", ":cnext<CR>zz")
vim.keymap.set("n", "<leader>cp", ":cprev<CR>zz")
vim.keymap.set("n", "<leader>li", ":checkhealth vim.lsp<CR>", { desc = "LSP Info" })

-- SOURCING FILES
-- reload without exiting vim
vim.keymap.set("n", "<leader>rl", "<cmd>source ~/.config/nvim/init.lua<cr>")
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- source file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- NEOTREE
vim.keymap.set("n", "<leader>cd", ":Neotree<CR>")
vim.keymap.set("n", "<leader>cg", ":Neotree float git_status<CR>")

-- BARBAR
-- Moving around
vim.keymap.set("n", "<leader>h", ":BufferPrevious<CR>")
vim.keymap.set("n", "<leader>l", ":BufferNext<CR>")
vim.keymap.set("n", "<leader>H", ":BufferMovePrevious<CR>")
vim.keymap.set("n", "<leader>L", ":BufferMoveNext<CR>")

-- Goto buffer in position...
vim.keymap.set("n", "<leader>1", ":BufferGoto 1<CR>")
vim.keymap.set("n", "<leader>2", ":BufferGoto 2<CR>")
vim.keymap.set("n", "<leader>3", ":BufferGoto 3<CR>")
vim.keymap.set("n", "<leader>4", ":BufferGoto 4<CR>")
vim.keymap.set("n", "<leader>5", ":BufferGoto 5<CR>")
vim.keymap.set("n", "<leader>6", ":BufferGoto 6<CR>")
vim.keymap.set("n", "<leader>7", ":BufferGoto 7<CR>")
vim.keymap.set("n", "<leader>8", ":BufferGoto 8<CR>")
vim.keymap.set("n", "<leader>9", ":BufferGoto 9<CR>")
vim.keymap.set("n", "<leader>0", ":BufferLast<CR>")

-- Close buffer
vim.keymap.set("n", "<leader>q", ":BufferClose<CR>")
