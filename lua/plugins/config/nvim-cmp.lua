return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    enabled = false,
    priority = 1000,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        dependencies = { "rafamadriz/friendly-snippets" },
        build = (function()
          if vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
      },
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local luasnip = require("luasnip")
      local autopairs = require("nvim-autopairs.completion.cmp")
      local icons = require("custom.icons")
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip").filetype_extend("typescript", { "javascript" })
      require("snippets")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "single",
          }),
          documentation = cmp.config.window.bordered({
            border = "single",
          }),
        },
        view = {
          entries = {
            name = "custom",
            follow_cursor = true,
          },
        },

        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", icons.completion_icons.my_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = "-lsp",
              luasnip = "-snip",
              buffer = "-buffer",
            })[entry.source.name]
            return vim_item
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-7),
          ["<C-f>"] = cmp.mapping.scroll_docs(7),
          ["<C-y>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                return luasnip.expand()
              else
                return cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Insert,
                  select = true,
                })
              end
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              return luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })

      cmp.event:on("confirm_done", autopairs.on_confirm_done())
    end,
  },
}
