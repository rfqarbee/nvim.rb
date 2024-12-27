return {
  "saghen/blink.cmp",
  lazy = false,
  version = "*",
  opts = {
    keymap = {
      preset = "default",
    },
    sources = {
      default = { "lsp", "snippets", "buffer", "path" },
      per_filetype = {
        markdown = { "buffer", "path", "markdown" },
      },
      providers = {
        markdown = {
          name = "RenderMarkdown",
          module = "render-markdown.integ.blink",
        },
        snippets = {
          module = "blink.cmp.sources.snippets",
          opts = {
            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
            extended_filetypes = {
              typescript = { "javascript" },
              typescriptreact = { "typescript", "javascript" },
              svelte = { "javascript", "typescript" },
            },
            ignored_filetypes = {},
          },
        },
      },
    },
    completion = {
      list = {
        selection = function(ctx)
          return ctx.mode == "cmdline" and "auto_insert" or "preselect"
        end,
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        border = "rounded",
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
        },
      },
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
        },
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
      kind_icons = require("custom.icons").completion_icons.my_icons,
    },
  },
  opts_extend = { "sources.default" },
}
