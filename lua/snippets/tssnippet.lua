local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("typescript", {
  s(
    "ter",
    fmt("{} ? {} : {}", {
      i(1),
      i(2),
      i(3),
    })
  ),
})

ls.filetype_extend("typescriptreact", { "typescript" })
