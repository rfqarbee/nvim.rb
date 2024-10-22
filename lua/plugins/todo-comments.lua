return {
  "folke/todo-comments.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    keywords = {
      FIX = {
        icon = " ",
        color = "error",
        alt = { "BUG", "ISSUE" },
      },
      TODO = { icon = " ", color = "todo" },
      HACK = { icon = " ", color = "warning", alt = { "CHECK", "" } },
      WARNING = { icon = " ", color = "warning", alt = { "WARM", "TEMP" } },
      PERFORMANCE = { icon = " ", color = "performance", alt = { "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    colors = {
      todo = { "#5ca5fe", "#3db8ff" },
      warning = { "#ffbe3d", "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      hint = { "#10B981", "DiagnosticHint", "#428aed" },
      performance = "#04d145",
      test = { "Identifier", "#a26ef5" },
    },
  },
}
