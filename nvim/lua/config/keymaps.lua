-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save (Cmd+S → Ctrl+S in terminal)
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- Undo / Redo
map("n", "<C-z>", "u", { desc = "Undo" })
map("n", "<C-y>", "<C-r>", { desc = "Redo" }) -- VSCode uses Cmd+Shift+Z = Ctrl+Y

-- Select All
map("n", "<C-a>", "ggVG", { desc = "Select All" })

-- Double-click to select word (like VSCode)
map("n", "<2-LeftMouse>", "viw", { desc = "Select word" })

-- Duplicate line / selection (Ctrl+Shift+Down/Up)
map("n", "<C-S-Down>", "yyp", { desc = "Duplicate line down" })
map("n", "<C-S-Up>", "yyP", { desc = "Duplicate line up" })
map("v", "<C-S-Down>", "y'>p", { desc = "Duplicate selection down" })
map("v", "<C-S-Up>", "y'<P", { desc = "Duplicate selection up" })

-- Comment line / block (requires LazyVim comment plugin)
map("n", "<C-_>", "gcc", { desc = "Toggle line comment" })
map("v", "<C-_>", "gc", { desc = "Toggle selection comment" })

-- File Explorer (VSCode Ctrl+B)
map("n", "<C-b>", "<cmd>Neotree toggle<cr>", { desc = "Toggle File Explorer" })

-- Find file (VSCode Ctrl+P) — smart picker: buffers + recent + files with frecency
map("n", "<C-p>", function() Snacks.picker.smart() end, { desc = "Find files (smart)" })

-- Switch buffer (Tab in normal mode) — sorted by last used
map("n", "<Tab>", function() Snacks.picker.buffers() end, { desc = "Switch buffer" })

-- Grep across all files (VSCode Ctrl+Shift+F → Ctrl+G)
map("n", "<C-g>", function() Snacks.picker.grep() end, { desc = "Grep (Root Dir)" })

-- In-file search (Cmd+F → Ctrl+F) — uses Snacks picker
map("n", "<C-f>", function() Snacks.picker.lines() end, { desc = "Search in current file" })

-- Close current buffer (VSCode Ctrl+W)
map("n", "<C-w>", function() Snacks.bufdelete() end, { desc = "Close current buffer" })

-- Split navigation (like VSCode Ctrl+\)
map("n", "<C-\\>", "<C-w>v", { desc = "Vertical split" })
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })

-- Terminal toggle (like VSCode Ctrl+`)
map("n", "<C-`>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
