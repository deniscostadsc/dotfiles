return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = {enable = true},
            indent = {enable = true},
            autotage = {enable = true},
            ensure_installed = {"python", "bash", "yaml"},
            auto_install = false
        })
    end
}
