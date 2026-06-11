vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

local parsers = {
  "bash",
  "comment",
  "cpp",
  "css",
  "csv",
  "dart",
  "disassembly",
  "dockerfile",
  "go",
  "html",
  "http",
  "jsdoc",
  "json",
  "json5",
  "jq",
  "lua",
  "make",
  "svelte",
  "sql",
  "javascript",
  "typescript",
  "yaml",
  "zig",
}
require("nvim-treesitter").setup({})
require("nvim-treesitter").install(parsers)

for _, ft in pairs(parsers) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      vim.treesitter.start()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end
