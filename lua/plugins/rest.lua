return {
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
