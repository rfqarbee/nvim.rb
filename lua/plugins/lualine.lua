return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local custom = require("custom.statusline")
    local qf = require("custom.utils")
    require('lualine').setup({
      options = {
        -- theme = require('custom.lualine_custom'),
        always_divide_middle = false,
        always_show_tabline = false,
        globalstatus = true,
      },
      tabline = {
        lualine_b = {
          {
            'tabs',
            mode = 2,
            tabs_color = { active = 'lualine_b_normal' }
          }
        },
      },
      inactive_winbar = {
        lualine_c = { 'filename' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', "diff", "diagnostics" },
        lualine_c = { qf.qfix, custom.custominfo, { 'filename', path = 1 } },
        lualine_x = { 'searchcount' },
        lualine_y = { 'filetype', 'filesize', 'progress' },
        lualine_z = { 'location', { 'lsp_status', symbols = { separator = "  " } } },
      },
      extensions = { 'quickfix', 'oil', 'fugitive', 'nvim-dap-ui' }
    })
  end
}
