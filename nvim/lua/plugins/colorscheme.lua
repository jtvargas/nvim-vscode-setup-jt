return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      italic_comments = true,
      underline_links = true,
      disable_nvimtree_bg = true,

      color_overrides = {
        -- JARVIS palette
        vscBack = "#0A0E14",
        vscFront = "#B0C4DE",
        vscBlue = "#00D9FF",
        vscAccentBlue = "#00BFFF",
        vscLightBlue = "#7FDBFF",
        vscBlueGreen = "#00E5CC",
        vscGreen = "#3D9970",
        vscYellow = "#FFD700",
        vscYellowOrange = "#F5A623",
        vscOrange = "#FF8C42",
        vscPink = "#C792EA",
        vscRed = "#FF5555",
        vscLineNumber = "#2A4A5A",
        vscSelection = "#0D3A58",
        vscCursorDarkDark = "#0D1117",
        vscSearch = "#1A4A3A",
        vscSearchCurrent = "#0D5A4A",
        vscPopupBack = "#0D1117",
        vscPopupFront = "#B0C4DE",
        vscPopupHighlightBlue = "#0D3A58",
        vscLeftDark = "#0A0E14",
        vscTabCurrent = "#0A0E14",
        vscTabOther = "#0D1117",
        vscTabOutside = "#0A0E14",
        vscContext = "#1A2A3A",
        vscSplitDark = "#1A3A4A",
      },

      group_overrides = {
        CursorLine = { bg = "#0D1117" },
        CursorLineNr = { fg = "#00D9FF", bold = true },
      },
    },
  },

  { "LazyVim/LazyVim", opts = { colorscheme = "vscode" } },
}
