vim.api.nvim_command("hi clear")
if vim.fn.exists("syntax_on") then
  vim.api.nvim_command("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "doom_one"

local function highlight(group, color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local sp = color.sp and "guisp=" .. color.sp or ""
  vim.api.nvim_command("highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp)
end

local palettes = {
  diff_red = "#fb4934",
  diff_green = "#8ec07c",
  diff_blue = "#458588",
  diff_yellow = "#fabd2f",
  none = "NONE",
  fg = "#bbc2cf",
  fg_1 = "#dfdfdf",
  bg0 = "#282c34",
  bg1 = "#202328",
  bg2 = "#1c1f24",
  bg3 = "#3f444a",
  bg5 = "#23272e",
  normal_bg_m = "#2c2e36",
  disabled = "#676e95",
  disabled_alt = "#4c566a",
  hint_fg = "#86e1fc",
  hint_bg = "#2c374a",
  info_fg = "#82aaff",
  info_bg = "#2c314a",
  error_fg = "#ff757f",
  warn_fg = "#ffa500",
  h1 = "#82aaff",
  h2 = "#ffc777",
  h3 = "#4fd6be",
  h4 = "#c3e88d",
  h5 = "#c099ff",
  h6 = "#fca7ea",
  h1bg = "#273849",
  h2bg = "#252a3f",
  h4bg = "#3a273a",
  h5bg = "#394b70",
  gray = "#5d656b",
  gray_alt = "#7e8294",
  gray_altalt = "#4c566a",
  red = "#ff665c",
  yellow = "#ecbe7b",
  orange = "#e0af68",
  dark_orange = "#da8548",
  light_orange = "#ffc777",
  green = "#98be75",
  cyan = "#46d9ff",
  dark_cyan = "#5699af",
  blue = "#51afef",
  dark_blue = "#91a4ff",
  fav_purple = "#a9a1e1",
  purple = "#db8ffc",
  purple_dark = "#c678dd",
  pink = "#fca7ea",
  dark_pink = "#f268bf",
  variable = "#a9b7d1",
}

local groups = {
  ["@variable"] = { fg = palettes.variable },
  Normal = { fg = palettes.fg, bg = palettes.bg5 }, -- normal text and background color
  SignColumn = { fg = palettes.fg, bg = palettes.bg1 },
  EndOfBuffer = { fg = palettes.disabled }, -- ~ lines at the end of a buffer
  NormalFloat = { fg = palettes.variable, bg = palettes.bg5 }, -- normal text and background color for floating windows
  FloatBorder = { fg = palettes.fav_purple, bg = palettes.bg5 },
  ColorColumn = { fg = palettes.none, bg = palettes.bg0 }, --  used for the columns set with 'colorcolumn'
  Conceal = { fg = palettes.gray }, -- placeholder characters substituted for concealed text (see 'conceallevel')
  -- Cursor = { fg = palettes.cyan, bg = palettes.none, style = "reverse" }, -- the character under the cursor
  -- CursorIM = { fg = palettes.cyan, bg = palettes.none, style = "reverse" }, -- like Cursor, but used when in IME mode
  Directory = { fg = palettes.dark_pink, bg = palettes.none }, -- directory names (and other special names in listings)
  DiffAdd = { fg = palettes.diff_green, bg = palettes.bg3 }, -- diff mode: Added line
  DiffChange = { fg = palettes.diff_blue, bg = palettes.bg3 }, --  diff mode: Changed line
  DiffDelete = { fg = palettes.diff_red, bg = palettes.bg3 }, -- diff mode: Deleted line
  DiffText = { fg = palettes.diff_yellow, bg = palettes.bg3 }, -- diff mode: Changed text within a changed line
  ErrorMsg = { fg = palettes.error_fg, style = "bold" }, -- error messages
  Folded = { fg = palettes.gray, palettes.none, style = "italic" },
  FoldColumn = { fg = palettes.blue },
  IncSearch = { fg = palettes.pink },
  Yank = { bg = palettes.pink },
  Search = { fg = palettes.pink },
  CurSearch = { fg = palettes.pink, style = "reverse" },
  LineNr = { fg = palettes.disabled },
  CursorLineNr = { fg = palettes.cyan },
  MatchParen = { fg = palettes.dark_pink, bg = palettes.bg3 },
  Delimiter = { fg = palettes.dark_cyan },
  ModeMsg = { fg = palettes.cyan, style = "bold" },
  MoreMsg = { fg = palettes.cyan, style = "bold" },
  NonText = { fg = palettes.bg3 },
  -- Pmenu = { fg = palettes.cyan, bg = palettes.blue },
  -- PmenuSel = { fg = palettes.blue, bg = palettes.blue, style = "bold" },
  -- PmenuSbar = { fg = palettes.blue, bg = palettes.blue },
  -- PmenuThumb = { fg = palettes.fg, bg = palettes.fav_purple },

  Question = { fg = palettes.green, style = "bold" },
  QuickFixLine = { fg = palettes.blue, bg = palettes.bg1, style = "bold,italic" },
  qfLineNr = { fg = palettes.blue, bg = palettes.bg1 },
  SpecialKey = { fg = palettes.bg3 },
  SpellBad = { fg = palettes.red, bg = palettes.none, style = "italic,undercurl" },
  SpellCap = { fg = palettes.blue, bg = palettes.none, style = "italic,undercurl" },
  SpellLocal = { fg = palettes.cyan, bg = palettes.none, style = "italic,undercurl" },
  SpellRare = { fg = palettes.cyan, bg = palettes.none, style = "italic,undercurl" },
  StatusLine = { fg = palettes.blue, bg = palettes.bg0 },
  StatusLineNC = { fg = palettes.gray },
  StatusLineTerm = { fg = palettes.fg, bg = palettes.bg3 },
  StatusLineTermNC = { fg = palettes.fg, bg = palettes.bg3 },
  TabLineFill = { fg = palettes.fg },
  TablineSel = { fg = palettes.green, bg = palettes.bg5 },
  Tabline = { fg = palettes.gray },
  Title = { fg = palettes.yellow, bg = palettes.none, style = "bold" },
  Visual = { fg = palettes.none, bg = palettes.h5bg },
  VisualNOS = { fg = palettes.none }, --style = "reverse" },
  WarningMsg = { fg = palettes.orange, style = "bold" },
  WildMenu = { fg = palettes.bg0, bg = palettes.blue, style = "bold" },
  CursorColumn = { fg = palettes.none, bg = palettes.fg },
  CursorLine = { fg = palettes.none, bg = palettes.bg1, style = nil, "underline" },
  ToolbarLine = { fg = palettes.fg, bg = palettes.bg1 },
  ToolbarButton = { fg = palettes.fg, bg = palettes.none, style = "bold" },
  NormalMode = { fg = palettes.red, bg = palettes.none },
  InsertMode = { fg = palettes.purple, bg = palettes.none, style = "reverse" },
  ReplacelMode = { fg = palettes.red, bg = palettes.none, style = "reverse" },
  VisualMode = { fg = palettes.cyan, bg = palettes.none, style = "reverse" },
  VertSplit = { fg = "#1d1d1d" },
  WinSeparator = { fg = "#1d1d1d" },
  CommandMode = { fg = palettes.gray, bg = palettes.none, style = "reverse" },
  Warnings = { fg = palettes.warn_fg },
  healthError = { fg = palettes.error_fg },
  healthSuccess = { fg = palettes.green },
  healthWarning = { fg = palettes.warn_fg },

  --common
  Type = { fg = palettes.fav_purple }, -- int, long, char, etpalettes.
  StorageClass = { fg = palettes.blue }, -- static, register, volatile, etpalettes.
  Structure = { fg = palettes.blue }, -- struct, union, enum, etpalettes.
  Constant = { fg = palettes.dark_blue }, -- any constant
  Comment = { fg = palettes.gray, bg = palettes.none, style = "italic" },
  Conditional = { fg = palettes.blue, bg = palettes.none }, -- italic if, then, else, endif, switch, etc.
  Keyword = { fg = palettes.blue, bg = palettes.none }, -- italic for, do, while, etc.
  Repeat = { fg = palettes.blue, bg = palettes.none }, -- italic any other keyword
  Boolean = { fg = palettes.dark_blue, bg = palettes.none }, -- true , false
  Function = { fg = palettes.purple, bg = palettes.none },
  Identifier = { fg = palettes.blue, bg = palettes.none }, -- any variable name
  String = { fg = palettes.green, bg = palettes.none }, -- Any string
  Character = { fg = palettes.green }, -- any character constant: 'c', '\n'
  Number = { fg = palettes.dark_orange }, -- a number constant: 5
  Float = { fg = palettes.dark_orange }, -- a floating point constant: 2.3e10
  Statement = { fg = palettes.blue }, -- any statement
  Label = { fg = palettes.blue }, -- case, default, etpalettes.
  Operator = { fg = palettes.none }, -- sizeof", "+", "*", etpalettes.
  Exception = { fg = palettes.purple }, -- try, catch, throw
  PreProc = { fg = palettes.blue }, -- generic Preprocessor
  Include = { fg = palettes.purple }, -- preprocessor #include
  Define = { fg = palettes.blue }, -- preprocessor #define
  Macro = { fg = palettes.blue }, -- same as Define
  Typedef = { fg = palettes.blue }, -- A typedef
  PreCondit = { fg = palettes.blue }, -- preprocessor #if, #else, #endif, etpalettes.
  Special = { fg = palettes.yellow, bg = palettes.none }, -- any special symbol
  SpecialChar = { fg = palettes.yellow }, -- special character in a constant
  Tag = { fg = palettes.red }, -- you can use CTRL-] on thi:s
  SpecialComment = { fg = palettes.blue, style = "italic" }, -- special things inside a comment
  Debug = { fg = palettes.red }, -- debugging statements
  Underlined = { fg = palettes.cyan, bg = palettes.none, style = "underline" }, -- text that stands out, HTML links
  Ignore = { fg = palettes.gray_alt }, -- left blank, hidden
  Error = { fg = palettes.error_fg, bg = palettes.none, style = "bold,underline" }, -- any erroneous construct
  Todo = { fg = palettes.info_fg, bg = palettes.none, style = "bold,italic" }, -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
  -- HTML
  htmlArg = { fg = palettes.orange },
  htmlBold = { fg = palettes.orange, bg = palettes.none, style = "bold" },
  htmlEndTag = { fg = palettes.fg },
  htmlstyle = { fg = palettes.cyan, bg = palettes.none, style = "italic" },
  htmlLink = { fg = palettes.cyan, style = "underline" },
  htmlSpecialChar = { fg = palettes.orange },
  htmlSpecialTagName = { fg = palettes.blue, style = "bold" },
  htmlTag = { fg = palettes.fg },
  htmlTagN = { fg = palettes.blue },
  htmlTagName = { fg = palettes.blue, "bold" },
  htmlTitle = { fg = palettes.fg },
  htmlH1 = { fg = palettes.blue, style = "bold" },
  htmlH2 = { fg = palettes.blue, style = "bold" },
  htmlH3 = { fg = palettes.blue, style = "bold" },
  htmlH4 = { fg = palettes.blue, style = "bold" },
  htmlH5 = { fg = palettes.blue, style = "bold" },
  -- Markdown
  markdownH1 = { fg = palettes.h1, bg = palettes.h1bg, style = "bold" },
  markdownH2 = { fg = palettes.h2, bg = palettes.h2bg, style = "bold" },
  markdownH3 = { fg = palettes.h3, bg = palettes.h3bg, style = "bold" },
  markdownH4 = { fg = palettes.h4, bg = palettes.h3bg, style = "bold" },
  markdownH5 = { fg = palettes.h5, bg = palettes.h5bg, style = "bold" },
  markdownH6 = { fg = palettes.h6, bg = palettes.h5bg, style = "bold" },
  markdownHeadingDelimiter = { fg = palettes.red },
  markdownHeadingRule = { fg = palettes.gray },
  markdownId = { fg = palettes.cyan },
  markdownIdDeclaration = { fg = palettes.blue },
  markdownIdDelimiter = { fg = palettes.cyan },
  markdownstyle = { fg = palettes.cyan, bg = palettes.none, style = "italic" },
  markdownLinkDelimiter = { fg = palettes.cyan },
  markdownLinkText = { fg = palettes.blue },
  markdownListMarker = { fg = palettes.red },
  markdownOrderedListMarker = { fg = palettes.red },
  markdownRule = { fg = palettes.gray },
  markdownUrl = { fg = palettes.cyan, bg = palettes.none, style = "underline" },
  markdownBlockquote = { fg = palettes.gray },
  markdownBold = { fg = palettes.orange, bg = palettes.none, style = "bold" },
  markdownCode = { fg = palettes.purple, bg = palettes.bg1 },
  markdownCodeBlock = { fg = palettes.green },
  markdownCodeDelimiter = { fg = palettes.green },

  --NOTE: cuz treesitter plugin is not yet looaded, hence top takes precedence
  -- TreeSitter highlight groups
  -- TSComment = { fg = palettes.gray, bg = palettes.none , style = "italic"}, -- For comment blocks.
  -- TSConditional = { fg = palettes.light_blue }, -- For keywords related to conditionnals.
  -- TSKeyword = { fg = palettes.orange }, -- For keywords that don't fall in previous categories.
  -- TSAnnotation = { fg = palettes.orange }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
  -- TSRepeat = { fg = palettes.blue }, -- For keywords related to loops.
  -- TSAttribute = { fg = palettes.cyan }, -- (unstable) TODO: docs
  -- TSKeywordFunction = { fg = palettes.blue }, -- For keywords used to define a fuction.
  -- TSCharacter = { fg = palettes.orange }, -- For characters.
  -- TSBoolean = { fg = palettes.orange, bg = palettes.none }, -- true or false
  -- TSFunction = { fg = palettes.purple }, -- For fuction (calls and definitions).
  -- TSMethod = { fg = palettes.purple }, -- For method calls and definitions.
  -- TSConstructor = { fg = palettes.red }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
  -- TSFuncBuiltin = { fg = palettes.orange }, -- For builtin functions: `table.insert` in Lua.
  -- TSConstant = { fg = palettes.violet }, -- For constants
  -- TSVariable = { fg = palettes.light_pink }, -- Any variable name that does not have another highlight.
  -- TSVariableBuiltin = { fg = palettes.cyan }, -- Variable names that are defined by the languages, like `this` or `self`.        TSConstBuiltin = {fg = orange}, -- For constant that are built in the language: `nil` in Lua.
  -- TSConstMacro = { fg = palettes.cyan }, -- For constants that are defined by macros: `NULL` in palettes.
  -- TSError = { fg = palettes.error_fg }, -- For syntax/parser errors.
  -- TSException = { fg = palettes.blue }, -- For exception related keywords.
  -- TSField = { fg = palettes.red }, -- For fields.
  -- TSFloat = { fg = palettes.red }, -- For floats.
  -- TSFuncMacro = { fg = palettes.orange }, -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
  -- TSInclude = { fg = palettes.blue }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
  -- TSLabel = { fg = palettes.cyan }, -- For labels: `label:` in C and `:label:` in Lua.
  -- TSNamespace = { fg = palettes.cyan }, -- For identifiers referring to modules and namespaces.
  -- TSNumber = { fg = palettes.red }, -- For all numbers
  -- TSOperator = { fg = palettes.blue }, -- For any operator: `+`, but also `->` and `*` in palettes.
  -- TSParameter = { fg = palettes.violet }, -- For parameters of a function.
  -- TSParameterReference = { fg = palettes.fg }, -- For references to parameters of a function.
  -- TSProperty = { fg = palettes.violet }, -- Same as `TSField`.
  -- TSPunctDelimiter = { fg = palettes.fg }, -- For delimiters ie: `.`
  -- TSPunctBracket = { fg = palettes.purple }, -- For brackets and parens.
  -- TSPunctSpecial = { fg = palettes.yellow }, -- For special punctutation that does not fall in the catagories before.
  -- TSString = { fg = palettes.green }, -- For strings.
  -- TSStringRegex = { fg = palettes.blue }, -- For regexes.
  -- TSStringEscape = { fg = palettes.orange }, -- For escape characters within a string.
  -- TSSymbol = { fg = palettes.orange }, -- For identifiers referring to symbols or atoms.
  -- TSType = { fg = palettes.orange }, -- For types.
  -- TSTypeBuiltin = { fg = palettes.cyan }, -- For builtin types.
  -- TSTag = { fg = palettes.blue }, -- Tags like html tag names.
  -- TSTagDelimiter = { fg = palettes.blue }, -- Tag delimiter like `<` `>` `/`
  -- TSText = { fg = palettes.violet }, -- For strings considered text in a markup language.
  -- TSTextReference = { fg = palettes.orange }, -- FIXME
  -- TSEmphasis = { fg = palettes.violet }, -- For text to be represented with emphasis.
  -- TSUnderline = { fg = palettes.fg, bg = palettes.none, style = "underline" }, -- For text to be represented with an underline.
  -- TSStrike = {}, -- For strikethrough text.
  -- TSTitle = { fg = palettes.fg, bg = palettes.none, style = "bold" }, -- Text that is part of a title.
  -- TSLiteral = { fg = palettes.fg }, -- Literal text.
  -- TSURI = { fg = palettes.purple }, -- Any URL like a link or email.
  --TSNone =                    { },    -- TODO: docs

  -- Lsp highlight groups
  LspDiagnosticsDefaultError = { fg = palettes.error_fg, style = "bold" }, -- used for "Error" diagnostic virtual text
  LspDiagnosticsSignError = { fg = palettes.error_fg }, -- used for "Error" diagnostic signs in sign column
  LspDiagnosticsFloatingError = { fg = palettes.error_fg, style = "bold" }, -- used for "Error" diagnostic messages in the diagnostics float
  LspDiagnosticsVirtualTextError = { fg = palettes.error_fg, style = "bold" }, -- Virtual text "Error"
  LspDiagnosticsUnderlineError = { fg = palettes.error_fg, style = "undercurl", sp = palettes.error_fg }, -- used to underline "Error" diagnostics.
  LspDiagnosticsDefaultWarning = { fg = palettes.warn_fg }, -- used for "Warning" diagnostic signs in sign column
  LspDiagnosticsSignWarning = { fg = palettes.warn_fg }, -- used for "Warning" diagnostic signs in sign column
  LspDiagnosticsFloatingWarning = { fg = palettes.warn_fg, style = "bold" }, -- used for "Warning" diagnostic messages in the diagnostics float
  LspDiagnosticsVirtualTextWarning = { fg = palettes.warn_fg, style = "bold" }, -- Virtual text "Warning"
  LspDiagnosticsUnderlineWarning = { fg = palettes.warn_fg, style = "undercurl", sp = palettes.warn_fg }, -- used to underline "Warning" diagnostics.
  LspDiagnosticsDefaultInformation = { fg = palettes.info_fg }, -- used for "Information" diagnostic virtual text
  LspDiagnosticsSignInformation = { fg = palettes.info_fg }, -- used for "Information" diagnostic signs in sign column
  LspDiagnosticsFloatingInformation = { fg = palettes.info_fg, style = "bold" }, -- used for "Information" diagnostic messages in the diagnostics float
  LspDiagnosticsVirtualTextInformation = { fg = palettes.info_fg, style = "bold" }, -- Virtual text "Information"
  LspDiagnosticsUnderlineInformation = { fg = palettes.info_fg, style = "undercurl", sp = palettes.info_fg }, -- used to underline "Information" diagnostics.
  LspDiagnosticsDefaultHint = { fg = palettes.hint_fg }, -- used for "Hint" diagnostic virtual text
  LspDiagnosticsSignHint = { fg = palettes.hint_fg }, -- used for "Hint" diagnostic signs in sign column
  LspDiagnosticsFloatingHint = { fg = palettes.hint_fg, style = "bold" }, -- used for "Hint" diagnostic messages in the diagnostics float
  LspDiagnosticsVirtualTextHint = { fg = palettes.hint_fg, style = "bold" }, -- Virtual text "Hint"
  LspDiagnosticsUnderlineHint = { fg = palettes.hint_fg, style = "undercurl", sp = palettes.hint_fg }, -- used to underline "Hint" diagnostics.
  LspReferenceText = { fg = palettes.none, bg = palettes.bg3 }, -- used for highlighting "text" references
  LspReferenceRead = { fg = palettes.none, bg = palettes.bg3 }, -- used for highlighting "read" references
  LspReferenceWrite = { fg = palettes.none, bg = palettes.bg3 }, -- used for highlighting "write" references

  -- Plugins highlight groups
  DiagnosticError = { fg = palettes.error_fg },
  DiagnosticWarning = { fg = palettes.warn_fg },
  DiagnosticWarn = { fg = palettes.warn_fg },
  DiagnosticInformation = { fg = palettes.info_fg },
  DiagnosticInfo = { fg = palettes.info_fg },
  DiagnosticHint = { fg = palettes.hint_fg },
  DiagnosticTruncateLine = { fg = palettes.fg },
  LspFloatWinNormal = { bg = palettes.bg1, fg = palettes.red },
  LspFloatWinBorder = { bg = palettes.red, fg = palettes.red },
  ReferencesCount = { fg = palettes.purple },
  DefinitionCount = { fg = palettes.purple },
  DefinitionIcon = { fg = palettes.blue },
  ReferencesIcon = { fg = palettes.blue },
  TargetWord = { fg = palettes.cyan },

  -- LspTrouble
  LspTroubleText = { fg = palettes.bg4 },
  LspTroubleCount = { fg = palettes.blue, bg = palettes.bg3 },
  LspTroubleNormal = { fg = palettes.fg, bg = palettes.bg0 },
  -- Diff
  diffAdded = { fg = palettes.diff_green },
  diffRemoved = { fg = palettes.diff_red },
  diffChanged = { fg = palettes.diff_blue },
  diffOldFile = { fg = palettes.bg4 },
  diffNewFile = { fg = palettes.fg },
  diffFile = { fg = palettes.gray },
  diffLine = { fg = palettes.yellow },
  diffIndexLine = { fg = palettes.purple },
  gitcommitBlank = { fg = palettes.fav_purple },

  -- Neogit
  -- NeogitBranch = { fg = palettes.gray_alt },
  -- NeogitRemote = { fg = palettes.purple },
  -- NeogitHunkHeader = { fg = palettes.fg, bg = palettes.cyan },
  -- NeogitHunkHeaderHighlight = { fg = palettes.blue },
  -- NeogitDiffContextHighlight = { fg = palettes.fg },
  -- NeogitDiffDeleteHighlight = { fg = palettes.red },
  -- NeogitDiffAddHighlight = { fg = palettes.green },

  -- GitSigns
  GitSignsAdd = { fg = palettes.diff_green }, -- diff mode: Added line |diff.txt|
  GitSignsAddNr = { fg = palettes.diff_green }, -- diff mode: Added line |diff.txt|
  GitSignsAddLn = { fg = palettes.diff_green }, -- diff mode: Added line |diff.txt|
  GitSignsChange = { fg = palettes.fav_purple }, -- diff mode: Changed line |diff.txt|
  GitSignsChangeNr = { fg = palettes.fav_purple }, -- diff mode: Changed line |diff.txt|
  GitSignsChangeLn = { fg = palettes.fav_purple }, -- diff mode: Changed line |diff.txt|
  GitSignsDelete = { fg = palettes.diff_red }, -- diff mode: Deleted line |diff.txt|
  GitSignsDeleteNr = { fg = palettes.diff_red }, -- diff mode: Deleted line |diff.txt|
  GitSignsDeleteLn = { fg = palettes.diff_red }, -- diff mode: Deleted line |diff.txt|
  -- Telescope
  TelescopePromptBorder = { fg = palettes.purple },
  TelescopeResultsBorder = { fg = palettes.purple },
  TelescopePreviewBorder = { fg = palettes.purple },
  FzfLuaBorder = { fg = palettes.fav_purple },
  -- WhichKey
  WhichKey = { fg = palettes.purple, style = "bold" },
  WhichKeyGroup = { fg = palettes.violet, style = "italic" },
  WhichKeyDesc = { fg = palettes.blue, style = "bold" },
  WhichKeySeperator = { fg = palettes.green },
  WhichKeyFloating = { bg = palettes.bg1 },
  WhichKeyFloat = { bg = palettes.bg1 },
  -- Indent Blankline
  IndentBlanklineChar = { fg = palettes.disabled },
  IndentBlanklineContextChar = { fg = palettes.cyan },
  -- Nvim dap
  DapBreakpoint = { fg = palettes.red },
  DapStopped = { fg = palettes.green },

  CmpItemAbbrDeprecatedDefault = { style = "strikethrough" },
  CmpItemAbbrDeprecated = { style = "strikethrough" },
  CmpItemAbbrMatch = { fg = palettes.blue },
  CmpItemAbbrMatchFuzzy = { fg = palettes.blue },
  CmpItemKindVariable = { fg = palettes.blue },
  CmpItemKindInterface = { fg = palettes.blue },
  CmpItemKindText = { fg = palettes.fg },
  CmpItemKindFunction = { fg = palettes.purple },
  CmpItemKindMethod = { fg = palettes.purple },
  CmpItemKindKeyword = { fg = palettes.blue },
  CmpItemKindProperty = { fg = palettes.blue },
  CmpItemKindUnit = { fg = palettes.blue },
}

for group, value in pairs(groups) do
  highlight(group, value)
end

local doom_one = {
  visual = {
    a = { fg = palettes.bg0, bg = palettes.blue, gui = "bold" },
    b = { fg = palettes.cyan, bg = palettes.bg3 },
  },
  replace = {
    a = { fg = palettes.bg0, bg = palettes.disabled, gui = "bold" },
    b = { fg = palettes.purple, bg = palettes.bg3 },
  },
  inactive = {
    a = { fg = palettes.fg, bg = palettes.bg3, gui = "bold" },
    b = { fg = palettes.fg, bg = palettes.bg3 },
    c = { fg = palettes.fg, bg = palettes.bg3 },
  },
  normal = {
    a = { fg = palettes.bg0, bg = palettes.dark_cyan, gui = "bold" },
    b = { fg = palettes.blue, bg = palettes.bg3 },
    c = { fg = palettes.fg, bg = palettes.bg3 },
  },
  insert = {
    a = { fg = palettes.bg0, bg = palettes.purple, gui = "bold" },
    b = { fg = palettes.green, bg = palettes.bg3 },
  },
  command = {
    a = { fg = palettes.bg0, bg = palettes.red, gui = "bold" },
    b = { fg = palettes.green, bg = palettes.bg3 },
  },
}
