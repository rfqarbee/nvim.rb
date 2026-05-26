-- local TSGroup = vim.api.nvim_create_augroup("tsgroup", { clear = true })
-- local parser_path = vim.fn.stdpath("config") .. "/parser/"
--
-- local parser = {
--   svelte = { "svelte" },
--   typescript = { "ts", "svelte", "tsx", "js", "jsx" },
-- }
--
-- for lang, extension in pairs(parser) do
--   vim.treesitter.language.add(lang, { path = parser_path .. lang .. ".so" })
--   vim.treesitter.language.register(lang, extension)
--
--   vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
--     group = TSGroup,
--     pattern = extension,
--     callback = function(args)
--       vim.notify("start treesitter")
--       vim.treesitter.start(args.buf, lang)
--     end,
--   })
-- end
vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- require("nvim-treesitter.configs").setup({
--   ensure_installed = { "c", "tsx", "typescript", "svelte", "lua", "go", "toml", "yaml", "html", "sql" },
--   highlight = {
--     enable = false, -- MUST be set to true
--   },
-- })
local parsers = {
  "bash",
  "css",
  "c_sharp",
  "comment",
  "csv",
  "dart",
  "dockerfile",
  "go",
  "html",
  "http",
  "jsdoc",
  "json",
  "json5",
  "lua",
  "make",
  "svelte",
  "tsx",
  "typescript",
  "yaml",
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
