return {
  {
    'NTBBloodbath/doom-one.nvim',
    config = function()
      vim.g.doom_one_italic_comments = true
      vim.g.doom_one_diagnostics_text_color = false
      function toggle_background()
        ---@diagnostic disable-next-line: undefined-field
        if vim.opt.background:get() == 'dark' then
          vim.opt.background = 'light'
        else
          vim.opt.background = 'dark'
        end
      end

      vim.api.nvim_set_keymap('n', '<space>cl', ':lua toggle_background()<CR>', {
        silent = true,
        noremap = true,
      })
    end
  },
  {
    'luisiacc/gruvbox-baby', branch = 'main'
  },
  {
    'kaiuri/nvim-juliana',
    lazy = false,
    opts = { --[=[ configuration --]=] },
    config = true,
  },
  {
    "sainnhe/gruvbox-material"
  }
}
