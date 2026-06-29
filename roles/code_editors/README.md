# Code Editors

## Neovim

This role installs and configures Neovim with a modern, plugin-based setup using
[Lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

### Features

- **Plugin Management**: Uses Lazy.nvim for efficient, lazy-loaded plugins
- **Theme**: Tokyo Night theme with Lualine statusline integration
- **File Navigation**: Telescope integration for finding files, live grep,
  buffers, and help tags
- **Language Server Protocol (LSP)**: Extensive LSP support with Mason for
  managing language servers
- **Syntax Highlighting**: Treesitter integration with support for Python, Bash,
  and YAML

### Key Mappings

#### General
- `<leader>` is mapped to space (" ")

#### Telescope (File Navigation)
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - List buffers
- `<leader>fh` - Help tags

#### LSP (Code Intelligence)
- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Show references
- `gi` - Go to implementation
- `K` - Show hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `<leader>e` - Show diagnostic in float

### Supported Languages

The role configures LSP support for multiple languages (some may require
additional setup):
- C/C++ (clangd)
- Clojure (clojure_lsp)
- Dart (dartls)
- Elixir (elixirls)
- Java (jdtls)
- Julia (julials)
- Kotlin (kotlin_language_server)
- Lua (lua_ls)
- Pascal (pasls)
- PHP (phpactor)
- Python (pyright)
- Rust (rust_analyzer)
- Scala (metals)
- SQL (sqlls)
- TypeScript/JavaScript (ts_ls)

## Visual Studio Code

Configuration for Visual Studio Code is currently under development.
