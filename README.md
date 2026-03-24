# nvim-vscode-setup-jt

Neovim + LazyVim configuration with VSCode-style keybindings, a custom dark theme ("JARVIS"), and a one-command installer for macOS.

If you're coming from VSCode and want a fast, keyboard-driven editor with familiar shortcuts — this is it.

---

## Quick Install (One-Liner)

```bash
curl -fsSL https://raw.githubusercontent.com/jtvargas/nvim-vscode-setup-jt/main/install.sh | bash
```

That's it. The script handles everything: Homebrew, Neovim, dependencies, fonts, and config files.

> **Already have a Neovim config?** The script backs it up automatically to `~/.config/nvim.bak.<timestamp>` before installing. Nothing is deleted.

---

## What Gets Installed

The install script will install the following (skipping anything already present):

| Tool | Purpose | Install method |
|------|---------|----------------|
| [Homebrew](https://brew.sh) | macOS package manager | Official installer |
| [Neovim](https://neovim.io) | The editor | `brew install neovim` |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Fast text search (used by grep picker) | `brew install ripgrep` |
| [fd](https://github.com/sharkdp/fd) | Fast file finder (used by file picker) | `brew install fd` |
| [lazygit](https://github.com/jesseduffield/lazygit) | Terminal Git UI (Space+gg) | `brew install lazygit` |
| [JetBrains Mono Nerd Font](https://www.nerdfonts.com) | Font with icons for the UI | `brew install --cask font-jetbrains-mono-nerd-font` |

---

## Manual Install

If you prefer not to pipe to bash:

```bash
# 1. Install dependencies
brew install neovim ripgrep fd lazygit
brew install --cask font-jetbrains-mono-nerd-font

# 2. Back up existing config (if any)
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak

# 3. Clean Lazy.nvim cache
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# 4. Clone and copy config
git clone https://github.com/jtvargas/nvim-vscode-setup-jt.git /tmp/nvim-setup
cp -r /tmp/nvim-setup/nvim ~/.config/nvim
rm -rf /tmp/nvim-setup

# 5. Set your terminal font to "JetBrains Mono Nerd Font"

# 6. Launch Neovim — plugins install automatically on first run
nvim
```

---

## After Installation

1. **Set your terminal font** to `JetBrains Mono Nerd Font` (required for icons)
   - **iTerm2:** Preferences > Profiles > Text > Font
   - **Terminal.app:** Preferences > Profiles > Font > Change
   - **Kitty/WezTerm/Alacritty:** Update your config file

2. **Launch Neovim** with `nvim` — Lazy.nvim will auto-install all plugins on first launch

3. **Wait** for the install to finish, then **restart Neovim**

4. Press **Space** to see the which-key menu with all available shortcuts

---

## Uninstall

To completely remove this setup and start fresh:

```bash
# Remove config
rm -rf ~/.config/nvim

# Remove plugin data and cache
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# Restore your previous config (if backed up)
# mv ~/.config/nvim.bak ~/.config/nvim
```

---

# Configuration Reference

> **Config root:** `~/.config/nvim/`
> **Distribution:** [LazyVim](https://www.lazyvim.org/) (v8) with no extras enabled
> **Colorscheme:** VSCode theme with custom "JARVIS" dark palette
> **Philosophy:** VSCode-familiar keybindings (Ctrl instead of Cmd), minimal customization on top of LazyVim defaults

---

## Directory Structure

```
~/.config/nvim/
├── init.lua                        # Entry point — bootstraps config/
├── lazyvim.json                    # LazyVim extras (currently none)
├── stylua.toml                     # StyLua formatter settings
├── .neoconf.json                   # Neoconf (Lua LS + neodev)
└── lua/
    ├── config/
    │   ├── init.lua                # Loads keymaps module
    │   ├── lazy.lua                # Lazy.nvim plugin manager setup
    │   ├── keymaps.lua             # ★ Custom keybindings (VSCode-style)
    │   ├── options.lua             # ★ Vim options overrides
    │   └── autocmds.lua            # Autocommands (empty — ready to use)
    └── plugins/
        ├── colorscheme.lua         # ★ JARVIS dark theme (vscode.nvim)
        ├── neo-tree.lua            # ★ File explorer customization
        └── vim-visual-multi.lua    # ★ Multi-cursor (VSCode Ctrl+D)
```

Files marked with ★ contain custom configurations.

---

## Quick Reference: What to Edit

| I want to...                        | Edit this file                              |
|-------------------------------------|---------------------------------------------|
| Add/change a keyboard shortcut      | `lua/config/keymaps.lua`                    |
| Change a Vim option (tabs, wrap...) | `lua/config/options.lua`                    |
| Add an autocommand                  | `lua/config/autocmds.lua`                   |
| Add a new plugin                    | Create a new file in `lua/plugins/`         |
| Change the colorscheme/theme        | `lua/plugins/colorscheme.lua`               |
| Configure the file explorer         | `lua/plugins/neo-tree.lua`                  |
| Enable a LazyVim extra              | `:LazyExtras` in Neovim, or edit `lazyvim.json` |
| Change Lazy.nvim manager settings   | `lua/config/lazy.lua`                       |
| Configure Lua formatter (StyLua)    | `stylua.toml`                               |
| Configure LSP settings              | `.neoconf.json` or add to `lua/plugins/`    |

---

## Custom Keymaps (VSCode-Style)

All defined in `lua/config/keymaps.lua`. Uses **Ctrl** in place of macOS **Cmd** for terminal compatibility.

### General

| Shortcut            | Mode     | Action                | Notes                      |
|---------------------|----------|-----------------------|----------------------------|
| `Ctrl+S`            | n, i, v  | Save file             | `:w`                       |
| `Ctrl+Z`            | n        | Undo                  | Maps to `u`                |
| `Ctrl+Y`            | n        | Redo                  | Maps to `Ctrl+R`           |
| `Ctrl+A`            | n        | Select all            | `ggVG`                     |

### Code Navigation & Multi-Select

| Shortcut            | Mode     | Action                          | Notes                              |
|---------------------|----------|---------------------------------|------------------------------------|
| `Double-click`      | n        | Select word under cursor        | Maps to `viw`                      |
| `Ctrl+D`            | n, v     | Multi-select next occurrence    | vim-visual-multi (VSCode Cmd+D)    |

### Editing

| Shortcut            | Mode     | Action                     | Notes                   |
|---------------------|----------|----------------------------|-------------------------|
| `Ctrl+Shift+Down`   | n        | Duplicate line down         | `yyp`                  |
| `Ctrl+Shift+Up`     | n        | Duplicate line up           | `yyP`                  |
| `Ctrl+Shift+Down`   | v        | Duplicate selection down    | `y'>p`                 |
| `Ctrl+Shift+Up`     | v        | Duplicate selection up      | `y'<P`                 |
| `Ctrl+/`            | n        | Toggle line comment         | Requires comment plugin |
| `Ctrl+/`            | v        | Toggle selection comment    | Requires comment plugin |

### UI & Navigation

| Shortcut            | Mode     | Action                     | Notes                      |
|---------------------|----------|----------------------------|----------------------------|
| `Ctrl+B`            | n        | Toggle file explorer        | Neo-tree toggle           |
| `Ctrl+P`            | n        | Find files (frecency sort)  | Snacks.picker.smart()     |
| `Tab`               | n        | Switch buffer               | Snacks.picker.buffers()   |
| `Ctrl+G`            | n        | Grep across all files       | Snacks.picker.grep()      |
| `Ctrl+F`            | n        | Search in current file      | Snacks.picker.lines()     |
| `Ctrl+W`            | n        | Close current buffer        | Snacks.bufdelete()        |
| `Ctrl+\`            | n        | Vertical split              | `Ctrl+W v`                |
| `Ctrl+H`            | n        | Move to left split          |                            |
| `Ctrl+L`            | n        | Move to right split         |                            |
| `Ctrl+J`            | n        | Move to split below         |                            |
| `Ctrl+K`            | n        | Move to split above         |                            |
| `` Ctrl+` ``        | n        | Toggle terminal             | ToggleTerm                |

---

## LazyVim Default Keymaps (Built-in)

These come from LazyVim and are available without any configuration.
Full list: https://www.lazyvim.org/keymaps

### Leader Key = `Space`

| Shortcut            | Action                          |
|---------------------|---------------------------------|
| `Space`             | Show which-key menu             |
| `Space f f`         | Find files (Snacks picker)      |
| `Space f g`         | Live grep (Snacks picker)       |
| `Space f r`         | Recent files                    |
| `Space b b`         | Switch buffer                   |
| `Space b d`         | Delete buffer                   |
| `Space e`           | File explorer (Neo-tree)        |
| `Space l`           | Lazy plugin manager             |
| `Space c a`         | Code action (LSP)               |
| `Space c r`         | Rename symbol (LSP)             |
| `Space c f`         | Format document                 |
| `Space x x`         | Trouble diagnostics             |
| `Space g g`         | Lazygit                         |
| `Space g s`         | Git status                      |
| `Space s s`         | Search in buffer                |
| `Space s g`         | Grep in project                 |
| `Space q q`         | Quit all                        |
| `Space q s`         | Restore session                 |
| `Space u c`         | Toggle colorscheme picker       |
| `Space u n`         | Toggle line numbers             |
| `Space u w`         | Toggle word wrap                |

### Navigation (No Leader)

| Shortcut            | Action                          |
|---------------------|---------------------------------|
| `s`                 | Flash jump (search + jump)      |
| `S`                 | Flash treesitter select         |
| `H` / `L`          | Previous / Next buffer          |
| `]d` / `[d`        | Next / Previous diagnostic      |
| `]t` / `[t`        | Next / Previous TODO comment    |
| `gd`                | Go to definition                |
| `gr`                | Go to references                |
| `K`                 | Hover documentation             |
| `gcc`               | Toggle line comment             |
| `gc` (visual)       | Toggle selection comment        |

---

## Installed Plugins (36)

### Core (LazyVim)

| Plugin                          | Purpose                              |
|---------------------------------|--------------------------------------|
| `LazyVim`                       | Configuration framework              |
| `lazy.nvim`                     | Plugin manager                       |
| `plenary.nvim`                  | Lua utility library                  |
| `nui.nvim`                      | UI component library                 |
| `snacks.nvim`                   | Utility collection (pickers, etc.)   |

### Editor

| Plugin                          | Purpose                              |
|---------------------------------|--------------------------------------|
| `neo-tree.nvim` **[custom]**    | File explorer (shows hidden files)   |
| `vim-visual-multi` **[custom]** | Multi-cursor editing (VSCode Ctrl+D) |
| `flash.nvim`                    | Enhanced search / jump navigation    |
| `grug-far.nvim`                 | Find and replace across files        |
| `mini.ai`                       | Extended text objects                |
| `mini.pairs`                    | Auto-close brackets/quotes           |
| `todo-comments.nvim`            | Highlight TODO/FIX/NOTE comments     |
| `trouble.nvim`                  | Diagnostics & quickfix viewer        |
| `which-key.nvim`                | Keybinding cheatsheet popup          |
| `persistence.nvim`              | Auto-save and restore sessions       |

### UI

| Plugin                          | Purpose                              |
|---------------------------------|--------------------------------------|
| `vscode.nvim` **[custom]**      | VSCode colorscheme (JARVIS palette)  |
| `tokyonight.nvim`               | Tokyo Night colorscheme (inactive)   |
| `catppuccin`                    | Catppuccin colorscheme (inactive)    |
| `bufferline.nvim`               | Buffer tab bar                       |
| `lualine.nvim`                  | Status line                          |
| `noice.nvim`                    | Enhanced messages, cmdline, popups   |
| `nvim-web-devicons`             | File type icons                      |
| `mini.icons`                    | Icon set                             |

### Code Intelligence

| Plugin                          | Purpose                              |
|---------------------------------|--------------------------------------|
| `nvim-lspconfig`                | LSP server configurations            |
| `mason.nvim`                    | LSP/tool installer                   |
| `mason-lspconfig.nvim`          | Mason + lspconfig integration        |
| `lazydev.nvim`                  | Lua/Neovim API dev tools             |
| `nvim-treesitter`               | Syntax parsing & highlighting        |
| `nvim-treesitter-textobjects`   | Treesitter-based text objects        |
| `nvim-ts-autotag`               | Auto-close/rename HTML/JSX tags      |
| `ts-comments.nvim`              | Treesitter-aware comment strings     |

### Code Quality

| Plugin                          | Purpose                              |
|---------------------------------|--------------------------------------|
| `conform.nvim`                  | Code formatter                       |
| `nvim-lint`                     | Linter integration                   |

### Completion

| Plugin                          | Purpose                              |
|---------------------------------|--------------------------------------|
| `blink.cmp`                     | Completion engine                    |
| `friendly-snippets`             | Snippet collection                   |

### Git

| Plugin                          | Purpose                              |
|---------------------------------|--------------------------------------|
| `gitsigns.nvim`                 | Git change indicators in gutter      |

---

## Custom Options

Defined in `lua/config/options.lua`. Everything else uses LazyVim defaults.

| Option                 | Value            | Effect                                      |
|------------------------|------------------|----------------------------------------------|
| `vim.opt.mouse`        | `"a"`            | Mouse enabled in all modes                   |
| `vim.opt.clipboard`    | `"unnamedplus"`  | Yank/paste uses system clipboard             |

### Notable LazyVim Defaults (inherited)

| Option           | Default Value | Effect                          |
|------------------|---------------|---------------------------------|
| `number`         | `true`        | Line numbers                    |
| `relativenumber` | `true`        | Relative line numbers           |
| `expandtab`      | `true`        | Spaces instead of tabs          |
| `tabstop`        | `2`           | Tab = 2 spaces                  |
| `shiftwidth`     | `2`           | Indent = 2 spaces               |
| `smartindent`    | `true`        | Auto-indent new lines           |
| `wrap`           | `false`       | No line wrapping                |
| `ignorecase`     | `true`        | Case-insensitive search         |
| `smartcase`      | `true`        | ...unless uppercase is used     |
| `termguicolors`  | `true`        | True color support              |
| `signcolumn`     | `"yes"`       | Always show sign column         |
| `cursorline`     | `true`        | Highlight current line          |

Full defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

---

## Colorscheme: JARVIS Palette

Defined in `lua/plugins/colorscheme.lua`. Based on `Mofiqul/vscode.nvim` with a custom dark blue/cyan palette.

### Settings

- Transparent background
- Italic comments
- Underlined links
- No nvim-tree background

### Color Palette

| Token                   | Hex         | Usage                          |
|-------------------------|-------------|--------------------------------|
| `vscBack`               | `#0A0E14`   | Main background                |
| `vscFront`              | `#B0C4DE`   | Default text (light steel blue)|
| `vscBlue`               | `#00D9FF`   | Primary accent (cyan)          |
| `vscAccentBlue`         | `#00BFFF`   | Secondary accent               |
| `vscLightBlue`          | `#7FDBFF`   | Light highlights               |
| `vscBlueGreen`          | `#00E5CC`   | Blue-green accent              |
| `vscGreen`              | `#3D9970`   | Strings, success               |
| `vscYellow`             | `#FFD700`   | Warnings, constants            |
| `vscYellowOrange`       | `#F5A623`   | Parameters                     |
| `vscOrange`             | `#FF8C42`   | Types                          |
| `vscPink`               | `#C792EA`   | Keywords (purple)              |
| `vscRed`                | `#FF5555`   | Errors, deletions              |
| `vscLineNumber`         | `#2A4A5A`   | Line number color              |
| `vscSelection`          | `#0D3A58`   | Selection highlight            |
| `vscCursorDarkDark`     | `#0D1117`   | Cursor line background         |
| `vscSearch`             | `#1A4A3A`   | Search match background        |
| `vscSearchCurrent`      | `#0D5A4A`   | Current search match           |
| `vscPopupBack`          | `#0D1117`   | Popup/menu background          |
| `vscPopupFront`         | `#B0C4DE`   | Popup/menu text                |
| `vscSplitDark`          | `#1A3A4A`   | Window split divider           |

### Group Overrides

| Highlight Group  | Setting                  |
|------------------|--------------------------|
| `CursorLine`     | bg = `#0D1117`           |
| `CursorLineNr`   | fg = `#00D9FF`, **bold** |

---

## Neo-tree Configuration

Defined in `lua/plugins/neo-tree.lua`.

| Setting               | Value   | Effect                               |
|-----------------------|---------|--------------------------------------|
| `follow_current_file` | `true`  | Tree follows the file you're editing |
| `hide_dotfiles`       | `false` | Shows `.env`, `.git`, etc.           |
| `hide_gitignored`     | `false` | Shows gitignored files               |

---

## LSP / Formatters / Linters

Currently using **LazyVim defaults only** — no custom server or tool configurations.

### What's Available Out of the Box

- **LSP:** Managed via `mason.nvim` — install servers with `:Mason`
- **Formatting:** `conform.nvim` — configure per-filetype formatters
- **Linting:** `nvim-lint` — configure per-filetype linters
- **Lua formatting:** StyLua configured in `stylua.toml`:
  - Indent: 2 spaces
  - Column width: 120

### Installing an LSP Server

1. Open Neovim and run `:Mason`
2. Search for the server (e.g., `typescript-language-server`, `pyright`)
3. Press `i` to install

Or add it programmatically in a plugin file:

```lua
-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        tsserver = {},
      },
    },
  },
}
```

---

## How to Extend

### Add a New Plugin

Create a new `.lua` file in `lua/plugins/`:

```lua
-- lua/plugins/my-plugin.lua
return {
  {
    "author/plugin-name",
    opts = {
      -- plugin options here
    },
  },
}
```

### Add a Keymap

Add to `lua/config/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>xx", "<cmd>SomeCommand<cr>", { desc = "Description" })
```

### Add an Autocommand

Add to `lua/config/autocmds.lua`:

```lua
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.lua",
  callback = function()
    -- runs before saving .lua files
  end,
})
```

### Enable a LazyVim Extra

Run `:LazyExtras` in Neovim, browse available extras, and press `x` to enable/disable.

Popular extras:
- `lang.typescript` — TypeScript/JavaScript support
- `lang.python` — Python support
- `lang.rust` — Rust support
- `lang.go` — Go support
- `lang.json` — JSON schemas
- `lang.docker` — Dockerfile support
- `editor.mini-files` — Alternative file explorer
- `ui.mini-animate` — Smooth animations

### Override a LazyVim Default Plugin

Create a file in `lua/plugins/` that returns a spec with the same plugin name:

```lua
-- lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua", "typescript", "python", "go", "rust",
      },
    },
  },
}
```

---

## Useful Commands

| Command           | What it does                        |
|-------------------|-------------------------------------|
| `:Lazy`           | Open Lazy plugin manager            |
| `:LazyExtras`     | Browse/enable LazyVim extras        |
| `:Mason`          | Open Mason (LSP/tool installer)     |
| `:Neotree`        | Open file explorer                  |
| `:checkhealth`    | Diagnose Neovim health              |
| `:LspInfo`        | Show active LSP servers             |
| `:ConformInfo`    | Show active formatters              |
