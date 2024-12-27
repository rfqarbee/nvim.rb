return {
  "MeanderingProgrammer/render-markdown.nvim",
  config = function()
    require("render-markdown").setup({
      debounce = 400,
      sign = {
        enabled = false,
      },
      anti_conceal = {
        ignore = {
          quote = false,
          code_background = false,
          callout = false,
        },
      },
      heading = {
        enabled = false,
      },
      paragraph = {
        enabled = false,
      },
      code = {
        style = "full",
        width = "block",
        border = "none",
        disable_background = { "diff" },
      },
      dash = {
        width = 79,
      },
      link = {
        enabled = false,
      },
      checkbox = {
        position = "overlay",
        custom = {
          todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
        },
      },
      pipe_table = {
        cell = "raw",
      },
      win_options = {
        conceallevel = {
          rendered = 0, -- i just want flavour, dont want total concealment
        },
      },
    })
  end,
}
