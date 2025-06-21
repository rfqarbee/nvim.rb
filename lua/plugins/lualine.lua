return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup({
      options = {
        -- theme = "ayu_mirage",
        always_show_tabline = false,
        disabled_filetypes = {
          statusline = { "fugitiveblame", "qf", "quifckfix", "fugitive" },
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          {
            'tabs',
            mode = 0,
          }
        },
        lualine_c = {
          { 'filename', path = 0 },
        },
        lualine_x = { "diagnostics", "diff" },
        lualine_y = { 'filetype', { 'lsp_status', symbols = { separator = "  " } } },
        lualine_z = { 'location', 'branch' },
      },
      extensions = { 'oil', 'fugitive', 'nvim-dap-ui', "trouble", "fzf" }
    })
  end
}
