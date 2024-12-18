return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
  },
  version = "v0.*",
  opts = {
    snippets = {
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    },
    keymap = {
      preset = "default",
    },
    sources = {
      default = { "lsp", "path", "luasnip", "buffer" },
      per_filetype = {
        sql = { "vim-dadbod-completion", "path" },
      },
      providers = {
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
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        border = "single",
        draw = {
          treesitter = true,
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
        },
      },
      documentation = {
        auto_show = true,
        window = {
          border = "single",
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
