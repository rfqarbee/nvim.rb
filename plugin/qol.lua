vim.pack.add({
  "https://github.com/Hoffs/omnisharp-extended-lsp.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/NMAC427/guess-indent.nvim",
  "https://github.com/mbbill/undotree",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
  { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("^3.0.0") },
})

require("nvim-web-devicons").setup({})
require("nvim-ts-autotag").setup()
require("nvim-surround").setup()
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "tsx", "typescript", "svelte", "lua", "go", "toml", "yaml", "html", "sql" },
  highlight = {
    enable = true, -- MUST be set to true
  },
})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_WindowLayout = 2
vim.g.undotree_DiffpanelHeight = 15
