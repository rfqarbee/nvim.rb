return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup({
      options = {
        always_show_tabline = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { "fugitiveblame", "qf", "quifckfix", "fugitive" },
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          { 'filename', path = 1 },
        },
        lualine_c = {
          {
            'tabs',
            mode = 2,
            -- tabs_color = { active = 'lualine_a_insert' }
          }
        },
        lualine_x = { "diagnostics", "diff" },
        lualine_y = { 'branch', 'filetype', { 'lsp_status', symbols = { separator = "  " } } },
        lualine_z = { 'location' },
      },
      extensions = { 'oil', 'fugitive', 'nvim-dap-ui', "trouble", "fzf" }
    })
  end
}
