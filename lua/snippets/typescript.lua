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
  s(
    "neaf",
    fmt("const {} = ({}) => {{{}}}", {
      i(1),
      i(2),
      i(3),
    })
  ),
  s(
    "asaf",
    fmt("async ({} ,{}) => {{{}}}", {
      i(1),
      i(2),
      i(3),
    })
  ),
  s(
    "easf",
    fmt("export const {} = async ({} ,{}) => {{{}}}", {
      i(1),
      i(2),
      i(3),
      i(4),
    })
  ),
  s(
    "eaf",
    fmt("export const {} = ({}) => {{{}}}", {
      i(1),
      i(2),
      i(3),
    })
  ),
  s(
    "clog",
    fmt('console.log("Log: {}",{})', {
      i(1),
      i(2),
    })
  ),
  s(
    "tne",
    fmt([[if({}) {{ throw new Error({}) }}]], {
      i(1),
      i(2),
    })
  ),
})

ls.filetype_extend("typescriptreact", { "typescript", "javascript", "javascriptreact" })
