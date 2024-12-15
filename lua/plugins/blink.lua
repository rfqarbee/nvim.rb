return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      -- ????
      -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "snippets" } })
      require("snippets")
      -- require("luasnip").filetype_extend("typescript", { "javascript" })
    end,
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
    keymap = { preset = "default" },
    sources = {
      default = { "lsp", "path", "luasnip", "buffer" },
      per_filetype = {
        sql = { "vim-dadbod-completion", "path" },
      },
      cmdline = function()
        local type = vim.fn.getcmdtype()
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        if type == ":" then
          return { "cmdline" }
        end
        return {}
      end,
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
