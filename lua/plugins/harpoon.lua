return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local map = require("custom.utils").map
    local harpoon = require("harpoon")
    harpoon:setup()

    map("n", "<leader>a", function() harpoon:list():add() end)
    map("n", "\\", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    map("n", "<leader>1", function() harpoon:list():select(1) end)
    map("n", "<leader>2", function() harpoon:list():select(2) end)
    map("n", "<leader>3", function() harpoon:list():select(3) end)
    map("n", "<leader>4", function() harpoon:list():select(4) end)
    map("n", "<leader>j", function() harpoon:list():prev() end)
    map("n", "<leader>k", function() harpoon:list():next() end)
  end
}
