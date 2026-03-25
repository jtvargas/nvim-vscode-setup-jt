-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Enable file path resolution for JS/TS imports (used by gf and Ctrl+Click)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    vim.opt_local.suffixesadd:prepend(".js")
    vim.opt_local.suffixesadd:prepend(".ts")
    vim.opt_local.suffixesadd:prepend(".jsx")
    vim.opt_local.suffixesadd:prepend(".tsx")
    vim.opt_local.suffixesadd:prepend("/index.js")
    vim.opt_local.suffixesadd:prepend("/index.ts")
    vim.opt_local.suffixesadd:prepend("/index.jsx")
    vim.opt_local.suffixesadd:prepend("/index.tsx")
  end,
})
