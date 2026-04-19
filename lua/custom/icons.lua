local M = {}

local devicon = {
  icon = " ",
  color = "#FAF743",
  cterm_color = "227",
  name = "Env",
}

local envs = {
  ".env.local",
  ".env.dev",
  ".env.uat",
  ".env.prod",
  ".env.development",
  ".env.production",
  ".env.staging",
}

local lists = {}
for _, env in pairs(envs) do
  lists[env] = devicon
end

M.override = lists

M.completion_icons = {
  kind_icons = {
    Text = "󰉿 ",
    Method = "󰊕 ",
    Function = "󰊕 ",
    Constructor = "󰒓 ",

    Field = "󰜢 ",
    Variable = "󰆦 ",
    Property = "󰖷 ",

    Class = "󱡠 ",
    Interface = "󱡠 ",
    Struct = "󱡠 ",
    Module = "󰅩 ",

    Unit = "󰪚 ",
    Value = "󰦨 ",
    Enum = "󰦨 ",
    EnumMember = "󰦨 ",

    Keyword = "󰻾 ",
    Constant = "󰏿 ",

    Snippet = "󱄽 ",
    Color = "󰏘 ",
    File = "󰈔 ",
    Reference = "󰬲 ",
    Folder = "󰉋 ",
    Event = "󱐋 ",
    Operator = "󰪚 ",
    TypeParameter = "󰬛 ",
  },
  my_icons = {
    Text = " ",
    Method = "󰆧 ",
    Function = "󰊕 ",
    Constructor = " ",

    Field = "󰜢 ",
    Variable = "󰀫 ",
    Property = "󰖷 ",

    Class = "󰠱 ",
    Interface = " ",
    Struct = "󱡠 ",
    Module = "󰅩 ",

    Unit = "󰪚 ",
    Value = "󰎠 ",
    Enum = " ",
    EnumMember = " ",

    Keyword = "󰌋 ",
    Constant = "󰏿 ",

    Snippet = " ",
    Color = "󰏘 ",
    File = "󰈙 ",
    Reference = " ",
    Folder = "󰉋 ",
    Event = " ",
    Operator = "󰆕 ",
    TypeParameter = "󰬛 ",
  },
  cmp_icons = {
    Text = " ",
    Method = "󰆧 ",
    Function = "󰊕 ",
    Constructor = " ",
    Field = "󰇽 ",
    Variable = "󰂡 ",
    Class = "󰠱 ",
    Interface = " ",
    Module = " ",
    Property = "󰜢 ",
    Unit = " ",
    Value = "󰎠 ",
    Enum = " ",
    Keyword = "󰌋 ",
    Snippet = " ",
    Color = "󰏘 ",
    File = "󰈙 ",
    Reference = " ",
    Folder = "󰉋 ",
    EnumMember = " ",
    Constant = "󰏿 ",
    Struct = " ",
    Event = " ",
    Operator = "󰆕 ",
    TypeParameter = "󰅲 ",
  },
  lspkind = {
    Text = "󰉿 ",
    Method = "󰆧 ",
    Function = "󰊕 ",
    Constructor = " ",
    Field = "󰜢 ",
    Variable = "󰀫 ",
    Class = "󰠱 ",
    Interface = " ",
    Module = " ",
    Property = "󰜢 ",
    Unit = "󰑭 ",
    Value = "󰎠 ",
    Enum = " ",
    Keyword = "󰌋 ",
    Snippet = " ",
    Color = "󰏘 ",
    File = "󰈙 ",
    Reference = "󰈇 ",
    Folder = "󰉋 ",
    EnumMember = " ",
    Constant = "󰏿 ",
    Struct = "󰙅 ",
    Event = " ",
    Operator = "󰆕 ",
    TypeParameter = " ",
  },
  codicons = {
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = " ",
    Field = " ",
    Variable = " ",
    Class = " ",
    Interface = " ",
    Module = " ",
    Property = " ",
    Unit = " ",
    Value = " ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
  },
}

M.lsp_signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }

return M
