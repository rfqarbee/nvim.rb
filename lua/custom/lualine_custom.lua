local status_color = require 'lualine.themes.onedark'

local bg1 = '#25292f'
local h1_md = '#7299ff'
local info_bg = '#2a3745'
local green = '#88a36b'
local yellow = '#d6b573'
local red = '#e05654'

status_color.normal.a.fg = bg1
status_color.normal.a.bg = h1_md
status_color.insert.a.fg = bg1       -- bg1
status_color.insert.a.bg = green     --green
status_color.visual.a.fg = bg1       --bg1
status_color.visual.a.bg = yellow    --yellow
status_color.replace.a.fg = bg1      --bg1
status_color.replace.a.bg = red      --red
status_color.command.a.fg = bg1      --red
status_color.command.a.bg = "7aa2f7" --red

status_color.normal.b.fg = h1_md
status_color.normal.b.bg = info_bg

return status_color
