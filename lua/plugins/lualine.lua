return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup({
      options = {
        always_show_tabline = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { "fugitiveblame", "qf" },
          winbar = { "trouble", "fugitive", "quickfix", "qf" },
        }
      },
      tabline = {
        lualine_b = {
          {
            'tabs',
            mode = 2,
            tabs_color = { active = 'lualine_a_insert' }
          }
        },
      },
      sections = {
        lualine_a = { 'mode', },
        lualine_b = {},
        lualine_c = { "filesize", { 'filename', path = 1 } },
        lualine_x = { "diagnostics", "diff", 'branch', 'filetype', { 'lsp_status', symbols = { separator = "  " } } },
        lualine_y = {},
        lualine_z = { 'location' },
      },
      extensions = { 'oil', 'fugitive', 'nvim-dap-ui', "trouble", "fzf" }
    })
  end
}
