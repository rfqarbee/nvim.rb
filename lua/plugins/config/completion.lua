return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 1000,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
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
            border = "double",
          }),
          documentation = cmp.config.window.bordered({
            border = "double",
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
              -- nvim_lsp = "[LSP]",
              -- luasnip = "[LuaSnip]",
              -- buffer = "[Buffer]",
            })[entry.source.name]
            return vim_item
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-5),
          ["<C-f>"] = cmp.mapping.scroll_docs(5),
          ["<C-y>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Insert,
                  select = true,
                })
              end
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }),
      })

      -- cmp.setup.cmdline(":", {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = "cmdline" },
      --     { name = "path" },
      --   }),
      --   matching = { disallow_symbol_nonprefix_matching = false },
      -- })

      -- cmp.setup.cmdline({ "/", "?" }, {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = "buffer" },
      --   },
      -- })

      cmp.event:on("confirm_done", autopairs.on_confirm_done())
    end,
  },
}
