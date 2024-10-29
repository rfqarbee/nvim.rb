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

ls.add_snippets("typescript", {
  s(
    "tagi",
    fmt("<{t}>{y}</{t}>", {
      t = i(1),
      y = i(2),
    }, { repeat_duplicates = true })
  ),
})

ls.add_snippets("typescript", {
  s("tagc", fmt("<{t}/>", { t = i(1) })),
})

ls.filetype_extend("typescriptreact", { "typescript" })
ls.filetype_extend("svelte", { "typescript" })
