return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "pyright",
        "ts_ls",
      },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local servers = {
        -- Commented LSPs are not working properly.
        -- I'm going to investigate how to use LSP
        -- running in containers
        clangd = { "c", "cpp" },
        clojure_lsp = { "clojure" },
        -- csharp_ls = { "cs" },
        dartls = { "dart" },
        elixirls = { "elixir" },
        -- gopls = { "go" },
        -- hls = { "haskell" },
        jdtls = { "java" },
        julials = { "julia" },
        kotlin_language_server = { "kotlin" },
        lua_ls = { "lua" },
        metals = { "scala" },
        -- ocamllsp = { "ocaml" },
        pasls = { "pascal" },
        phpactor = { "php" },
        pyright = { "python" },
        -- r_language_server = { "r" },
        -- ruby_lsp = { "ruby" },
        rust_analyzer = { "rust" },
        sqlls = { "sql" },
        ts_ls = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
      }

      -- ============================================
      -- Define .git as root_dir
      local lspconfig = require('lspconfig')
      local default_root_dir = function(fname)
        return lspconfig.util.root_pattern(".git")(fname) or vim.fn.getcwd()
      end

      for server, _ in pairs(servers) do
        local config = lspconfig[server].document_config or {}
        config.root_dir = default_root_dir
        lspconfig[server].setup(config)
      end
      -- ============================================

      for server, filetypes in pairs(servers) do
        vim.api.nvim_create_autocmd("FileType", {
          pattern = filetypes,
          callback = function()
            pcall(vim.lsp.enable, server)
          end,
          group = vim.api.nvim_create_augroup("LspEnable_" .. server, {}),
        })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }

          -- Navigation
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Show references" }))
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show hover documentation" }))

          -- Actions
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))

          -- Diagnostics
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostic in float" }))
        end,
      })
    end,
  },
}
