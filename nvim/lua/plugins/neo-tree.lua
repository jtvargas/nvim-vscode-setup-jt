return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local cc = require("neo-tree.sources.filesystem.commands")

      require("neo-tree").setup({
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
        window = {
          mappings = {
            ["<RightMouse>"] = function(state)
              local node = state.tree:get_node()
              if not node then
                return
              end

              -- Move cursor to clicked node first
              vim.cmd("normal! \\<LeftMouse>")

              local actions = {
                "New file/dir",
                "Rename",
                "Copy to clipboard",
                "Cut to clipboard",
                "Paste from clipboard",
                "Delete",
              }

              vim.ui.select(actions, { prompt = "Action: " .. node.name }, function(choice)
                if not choice then
                  return
                end
                if choice == "Delete" then
                  cc.delete(state)
                elseif choice == "Rename" then
                  cc.rename(state)
                elseif choice == "Copy to clipboard" then
                  cc.copy_to_clipboard(state)
                elseif choice == "Cut to clipboard" then
                  cc.cut_to_clipboard(state)
                elseif choice == "Paste from clipboard" then
                  cc.paste_from_clipboard(state)
                elseif choice == "New file/dir" then
                  cc.add(state)
                end
              end)
            end,
          },
        },
      })
    end,
  },
}
