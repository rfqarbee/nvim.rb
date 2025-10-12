return {
  "oysandvik94/curl.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local curl = require("curl").setup({})
    local map = require("custom.utils").map
    map("n", "<leader>cf", function()
      curl.create_global_collection()
    end)
    map("n", "<leader>co", function()
      require("curl").pick_global_collection()
    end)
  end,
}
