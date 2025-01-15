-- deciding on which one
return {
  {
    "mistweaverco/kulala.nvim",
    config = function()
      require("kulala").setup({
        default_env = "development",
        default_view = "headers_body",
        default_winbar_panes = { "headers_body", "body", "headers", "scripts_output", "stats" },
        winbar = true,
      })
    end,
  },
  {
    "rest-nvim/rest.nvim",
    config = function()
      vim.g.rest_nvim = {
        cookies = {
          enable = false,
        },
        ui = {
          keybinds = {
            prev = "<S-Tab>",
            next = "<Tab>",
          },
        },
        highlight = {
          timeout = 20,
        },
      }
    end,
  },
}
