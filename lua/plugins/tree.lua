-- i wont use it, the only purpose code review and shit with collegue
return {
  "nvim-tree/nvim-tree.lua",
  lazy = true,
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional
  },
  keys = {
    { "<leader>nt", "<cmd>NvimTreeToggle<cr>", desc = "Neotree" },
  },
  opts = {
    renderer = {
      indent_markers = {
        enable = true,
        inline_arrows = true,
      },
      icons = {
        show = {
          folder_arrow = false,
        },
      },
    },
  },
}
