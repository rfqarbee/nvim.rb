vim.api.nvim_command("hi clear")
if vim.fn.exists("syntax_on") then
  vim.api.nvim_command("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "doom_one"

local function highlight(group, color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local cterm = color.cterm and "cterm=" .. color.cterm or ""
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local sp = color.sp and "guisp=" .. color.sp or ""
  vim.api.nvim_command("highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp .. " " .. cterm)
end

local palettes = {
  black = "#000000",
  diff_change = "#fb4934",
  diff_new = "#8ec07c",
  diff_modified = "#458588",
  diff_text = "#fabd2f",
  none = "NONE",
  fg = "#bbc2cf",
  fg_txt = "#dfdfdf",
  bg = "#282c34",
  bg_hl = "#3f444a",
  bg0 = "#282c34",
  bg1 = "#202328",
  bg2 = "#1c1f24",
  bg3 = "#3f444a",
  bg4 = "#23272e",
  normal_bg_m = "#2c2e36",
  disabled = "#676e95",
  disabled_alt = "#4c566a",
  hint_fg = "#86e1fc",
  hint_bg = "#2c374a",
  info_fg = "#82aaff",
  info_bg = "#2c374a",
  error_fg = "#ff757f",
  warn_fg = "#ffa500",
  h1_md = "#82aaff",
  h2_md = "#ffc777",
  h3_md = "#4fd6be",
  h4_md = "#c3e88d",
  h5_md = "#c099ff",
  h6_md = "#fca7ea",
  h1_bg = "#273849",
  h2_bg = "#252a3f",
  h4_bg = "#3a273a",
  h5_bg = "#394b70",
  gray = "#5d656b",
  gray_alt = "#7e8294",
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
  doom_purp = "#a9a1e1",
  purple = "#db8ffc",
  purple_dark = "#c678dd",
  pink = "#fca7ea",
  dark_pink = "#f268bf",
  variable = "#a9b7d1",
}

local groups = {
  ["@variable"] = { fg = palettes.variable },
  ["@variable.member"] = { fg = palettes.variable },
  ["@tag.attribute"] = { fg = palettes.doom_purp },

  -- editor highlight groups
  Normal = { fg = palettes.fg, bg = palettes.bg0 },                            -- normal text and background color
  SignColumn = { fg = palettes.fg, bg = palettes.bg0 },
  EndOfBuffer = { fg = palettes.disabled },                                    -- ~ lines at the end of a buffer
  NormalFloat = { fg = palettes.variable, bg = palettes.bg0 },                 -- normal text and background color for floating windows
  FloatBorder = { fg = palettes.disabled, bg = palettes.bg0 },
  ColorColumn = { fg = palettes.none, bg = palettes.bg3 },                     --  used for the columns set with 'colorcolumn'
  Conceal = { fg = palettes.gray },                                            -- placeholder characters substituted for concealed text (see 'conceallevel')
  Cursor = { fg = palettes.white, bg = palettes.bg0, style = "reverse" },      -- the character under the cursor
  CursorIM = { fg = palettes.cyan, bg = palettes.none, style = "reverse" },    -- like Cursor, but used when in IME mode
  Directory = { fg = palettes.dark_pink, bg = palettes.none, style = "bold" }, -- directory names (and other special names in listings)
  DiffAdd = { fg = palettes.diff_new, bg = palettes.bg_hl },                   -- diff mode: Added line
  DiffChange = { fg = palettes.diff_modified, bg = palettes.bg_hl },           --  diff mode: Changed line
  DiffDelete = { fg = palettes.diff_change, bg = palettes.bg_hl },             -- diff mode: Deleted line
  DiffText = { fg = palettes.diff_text, bg = palettes.bg_hl },                 -- diff mode: Changed text within a changed line
  ErrorMsg = { fg = palettes.error_fg, style = "bold" },                       -- error messages
  Folded = { fg = palettes.h3_md, bg = palettes.h1_bg, style = "italic" },
  FoldColumn = { fg = palettes.blue },
  IncSearch = { fg = palettes.dark_pink, style = "reverse,bold", bg = palettes.none },
  LineNr = { fg = palettes.disabled },
  CursorLineNr = { fg = palettes.cyan },
  MatchParen = { fg = palettes.dark_pink, bg = palettes.bg_hl },
  Delimiter = { fg = palettes.dark_cyan },
  ModeMsg = { fg = palettes.cyan, style = "bold" },
  MoreMsg = { fg = palettes.cyan, style = "bold" },
  NonText = { fg = palettes.bg_hl },
  Pmenu = { fg = palettes.none, bg = palettes.bg0 },
  PmenuSel = { fg = palettes.none, bg = palettes.h5_bg, style = "bold" },
  PmenuSbar = { fg = palettes.white, bg = palettes.none },
  PmenuThumb = { fg = palettes.red, bg = palettes.bg3 },
  Question = { fg = palettes.green, style = "bold" },
  QuickFixLine = { fg = palettes.blue, bg = palettes.white, style = "bold,italic" },
  qfLineNr = { fg = palettes.blue, bg = palettes.bg1 },
  Search = { fg = palettes.dark_pink, style = "bold", bg = palettes.h2_bg },
  SpecialKey = { fg = palettes.bg_hl },
  SpellBad = { fg = palettes.red, bg = palettes.none, style = "italic,undercurl" },
  SpellCap = { fg = palettes.blue, bg = palettes.none, style = "italic,undercurl" },
  SpellLocal = { fg = palettes.cyan, bg = palettes.none, style = "italic,undercurl" },
  SpellRare = { fg = palettes.cyan, bg = palettes.none, style = "italic,undercurl" },
  StatusLineQF = { fg = palettes.purple },
  StatusLine = { fg = palettes.h1_md, bg = palettes.bg1 },
  StatusLineCustom = { fg = palettes.bg1, bg = palettes.h1_md },
  StatusLineNormal = { fg = palettes.yellow, bg = palettes.bg0 },
  StatusLineInsert = { fg = palettes.bg1, bg = palettes.green },
  StatusLineExtra = { fg = palettes.none, bg = palettes.none },
  StatusLineVisual = { fg = palettes.bg1, bg = palettes.yellow },
  StatusLineReplace = { fg = palettes.bg1, bg = palettes.red },
  StatusLineCmd = { fg = palettes.bg1, bg = "#7aa2f7" },
  StatusLineNC = { fg = palettes.gray },
  StatusLineTerm = { fg = palettes.fg, bg = palettes.bg_hl },
  StatusLineTermNC = { fg = palettes.fg, bg = palettes.bg_hl },
  TabLineFill = { fg = palettes.fg },
  TablineSel = { fg = palettes.h2_md, bg = palettes.bg0 },
  Tabline = { fg = palettes.gray },
  Title = { fg = palettes.yellow, bg = palettes.none, style = "bold" },
  Visual = { fg = palettes.none, bg = palettes.h5_bg },
  VisualNOS = { fg = palettes.none }, --style = "reverse" },
  WarningMsg = { fg = palettes.orange, style = "bold" },
  WildMenu = { fg = palettes.bg, bg = palettes.blue, style = "bold" },
  CursorColumn = { fg = palettes.none, bg = palettes.fg },
  CursorLine = { fg = palettes.none, bg = palettes.bg4, style = nil, "underline" },
  ToolbarLine = { fg = palettes.fg, bg = palettes.bg1 },
  ToolbarButton = { fg = palettes.fg, bg = palettes.none, style = "bold" },
  VertSplit = { fg = "#1d1d1d" },
  WinSeparator = { fg = "#1d1d1d" },
  CommandMode = { fg = palettes.gray, bg = palettes.none, style = "reverse" },
  Warnings = { fg = palettes.warn_fg },
  healthError = { fg = palettes.error_fg },
  healthSuccess = { fg = palettes.green },
  healthWarning = { fg = palettes.warn_fg },
  Yank = { bg = palettes.dark_pink, style = "bold" },
  CurSearch = { fg = palettes.dark_pink, style = "reverse,bold", bg = palettes.none },

  --common
  Type = { fg = palettes.orange },                             -- int, long, char, etpalettes.
  Keyword = { fg = palettes.blue, bg = palettes.none },        -- italic for, do, while, etc.
  Repeat = { fg = palettes.blue, bg = palettes.none },         -- italic any other keyword
  StorageClass = { fg = palettes.blue },                       -- static, register, volatile, etpalettes.
  Structure = { fg = palettes.blue },                          -- struct, union, enum, etpalettes.
  Statement = { fg = palettes.blue },                          -- any statement
  Label = { fg = palettes.blue },                              -- case, default, etpalettes.
  PreProc = { fg = palettes.blue },                            -- generic Preprocessor
  Define = { fg = palettes.blue },                             -- preprocessor #define
  Macro = { fg = palettes.blue },                              -- same as Define
  Typedef = { fg = palettes.blue },                            -- A typedef
  Conditional = { fg = palettes.blue, bg = palettes.none },    -- italic if, then, else, endif, switch, etc.
  Constant = { fg = palettes.dark_blue },                      -- any constant
  Comment = { fg = palettes.gray, bg = palettes.none, style = "italic" },
  Boolean = { fg = palettes.dark_orange, bg = palettes.none }, -- true , false
  Function = { fg = palettes.purple_dark, bg = palettes.none },
  Identifier = { fg = palettes.blue, bg = palettes.none },     -- any variable name
  String = { fg = palettes.green, bg = palettes.none },        -- Any string
  Character = { fg = palettes.green },                         -- any character constant: 'c', '\n'
  Number = { fg = palettes.dark_orange },                      -- a number constant: 5
  Float = { fg = palettes.dark_orange },                       -- a floating point constant: 2.3e10
  PreCondit = { fg = palettes.blue },                          -- preprocessor #if, #else, #endif, etpalettes.
  Operator = { fg = palettes.none },                           -- sizeof", "+", "*", etpalettes.
  Exception = { fg = palettes.purple },                        -- try, catch, throw
  Include = { fg = palettes.purple },                          -- preprocessor #include
  Special = { fg = palettes.yellow, bg = palettes.none },      -- any special symbol
  SpecialChar = { fg = palettes.yellow },                      -- special character in a constant
  Tag = { fg = palettes.orange },
  fugitiveHelpTag = { fg = palettes.red },
  SpecialComment = { fg = palettes.blue, style = "italic" },                        -- special things inside a comment
  Debug = { fg = palettes.red },                                                    -- debugging statements
  Underlined = { fg = palettes.cyan, bg = palettes.none, style = "underline" },     -- text that stands out, HTML links
  Ignore = { fg = palettes.gray_alt },                                              -- left blank, hidden
  Error = { fg = palettes.error_fg, bg = palettes.none, style = "bold,undercurl" }, -- any erroneous construct
  Todo = { fg = palettes.info_fg, bg = palettes.none, style = "bold,italic" },      -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX

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
  ["@markup.heading.1.markdown"] = { fg = palettes.h1_md, style = "bold" },
  ["@markup.heading.2.markdown"] = { fg = palettes.h2_md, style = "bold" },
  ["@markup.heading.3.markdown"] = { fg = palettes.h3_md, style = "bold" },
  ["@markup.heading.4.markdown"] = { fg = palettes.h4_md, style = "bold" },
  ["@markup.heading.5.markdown"] = { fg = palettes.h5_md, style = "bold" },
  ["@markup.heading.6.markdown"] = { fg = palettes.h6_md, style = "bold" },
  ["@markup.quote.markdown"] = { fg = palettes.fg, style = "bold" },
  ["@markup.raw.markdown_inline"] = { fg = palettes.doom_purp, bg = palettes.bg4, style = "bold" },
  ["@markup.list.markdown"] = { fg = palettes.dark_orange, style = "bold" },
  ["@markup.list.checked.markdown"] = { fg = palettes.info_fg, style = "bold" },
  ["@markup.link.label.markdown_inline"] = { fg = palettes.dark_cyan, style = "bold" },
  ["@markup.link.markdown_inline"] = { fg = palettes.dark_cyan, style = "bold" },
  ["@markup.link.url.markdown_inline"] = { fg = palettes.dark_cyan, style = "bold" },
  ["@punctuation.special.markdown"] = { fg = palettes.hint_fg, style = "bold" },
  markdownH1 = { fg = palettes.h1_md, style = "bold" },
  markdownH2 = { fg = palettes.h2_md, style = "bold" },
  markdownH3 = { fg = palettes.h3_md, style = "bold" },
  markdownH4 = { fg = palettes.h4_md, style = "bold" },
  markdownH5 = { fg = palettes.h5_md, style = "bold" },
  markdownH6 = { fg = palettes.h6_md, style = "bold" },
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
  TSComment = { fg = palettes.gray, bg = palettes.none, style = "italic" },    -- For comment blocks.
  TSConditional = { fg = palettes.light_blue },                                -- For keywords related to conditionnals.
  TSKeyword = { fg = palettes.blue },                                          -- For keywords that don't fall in previous categories.
  TSAnnotation = { fg = palettes.orange },                                     -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
  TSRepeat = { fg = palettes.blue },                                           -- For keywords related to loops.
  TSAttribute = { fg = palettes.cyan },                                        -- (unstable) TODO: docs
  TSKeywordFunction = { fg = palettes.blue },                                  -- For keywords used to define a fuction.
  TSCharacter = { fg = palettes.orange },                                      -- For characters.
  TSBoolean = { fg = palettes.orange, bg = palettes.none },                    -- true or false
  TSFunction = { fg = palettes.purple },                                       -- For fuction (calls and definitions).
  TSMethod = { fg = palettes.purple },                                         -- For method calls and definitions.
  TSConstructor = { fg = palettes.red },                                       -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
  TSFuncBuiltin = { fg = palettes.orange },                                    -- For builtin functions: `table.insert` in Lua.
  TSConstant = { fg = palettes.violet },                                       -- For constants
  TSVariable = { fg = palettes.light_pink },                                   -- Any variable name that does not have another highlight.
  TSVariableBuiltin = { fg = palettes.cyan },                                  -- Variable names that are defined by the languages, like `this` or `self`.        TSConstBuiltin = {fg = orange}, -- For constant that are built in the language: `nil` in Lua.
  TSConstMacro = { fg = palettes.cyan },                                       -- For constants that are defined by macros: `NULL` in palettes.
  TSError = { fg = palettes.error_fg },                                        -- For syntax/parser errors.
  TSException = { fg = palettes.blue },                                        -- For exception related keywords.
  TSField = { fg = palettes.red },                                             -- For fields.
  TSFloat = { fg = palettes.red },                                             -- For floats.
  TSFuncMacro = { fg = palettes.orange },                                      -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
  TSInclude = { fg = palettes.blue },                                          -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
  TSLabel = { fg = palettes.cyan },                                            -- For labels: `label:` in C and `:label:` in Lua.
  TSNamespace = { fg = palettes.cyan },                                        -- For identifiers referring to modules and namespaces.
  TSNumber = { fg = palettes.red },                                            -- For all numbers
  TSOperator = { fg = palettes.blue },                                         -- For any operator: `+`, but also `->` and `*` in palettes.
  TSParameter = { fg = palettes.violet },                                      -- For parameters of a function.
  TSParameterReference = { fg = palettes.fg },                                 -- For references to parameters of a function.
  TSProperty = { fg = palettes.violet },                                       -- Same as `TSField`.
  TSPunctDelimiter = { fg = palettes.fg },                                     -- For delimiters ie: `.`
  TSPunctBracket = { fg = palettes.purple },                                   -- For brackets and parens.
  TSPunctSpecial = { fg = palettes.yellow },                                   -- For special punctutation that does not fall in the catagories before.
  TSString = { fg = palettes.green },                                          -- For strings.
  TSStringRegex = { fg = palettes.blue },                                      -- For regexes.
  TSStringEscape = { fg = palettes.orange },                                   -- For escape characters within a string.
  TSSymbol = { fg = palettes.orange },                                         -- For identifiers referring to symbols or atoms.
  TSType = { fg = palettes.orange },                                           -- For types.
  TSTypeBuiltin = { fg = palettes.cyan },                                      -- For builtin types.
  TSTag = { fg = palettes.blue },                                              -- Tags like html tag names.
  TSTagDelimiter = { fg = palettes.blue },                                     -- Tag delimiter like `<` `>` `/`
  TSText = { fg = palettes.violet },                                           -- For strings considered text in a markup language.
  TSTextReference = { fg = palettes.orange },                                  -- FIXME
  TSEmphasis = { fg = palettes.violet },                                       -- For text to be represented with emphasis.
  TSUnderline = { fg = palettes.fg, bg = palettes.none, style = "underline" }, -- For text to be represented with an underline.
  TSStrike = {},                                                               -- For strikethrough text.
  TSTitle = { fg = palettes.fg, bg = palettes.none, style = "bold" },          -- Text that is part of a title.
  TSLiteral = { fg = palettes.fg },                                            -- Literal text.
  TSURI = { fg = palettes.purple },                                            -- Any URL like a link or email.
  --TSNone =                    { },    -- TODO: docs

  -- Lsp highlight groups
  LspDiagnosticsDefaultError = { fg = palettes.error_fg, style = "undercurl" },
  LspDiagnosticsSignError = { fg = palettes.error_fg },                                                       -- used for "Error" diagnostic signs in sign column
  LspDiagnosticsFloatingError = { fg = palettes.error_fg, style = "bold" },                                   -- used for "Error" diagnostic messages in the diagnostics float
  LspDiagnosticsVirtualTextError = { fg = palettes.error_fg, style = "undercurl" },
  LspDiagnosticsUnderlineError = { fg = palettes.error_fg, style = "undercurl", sp = palettes.error_fg },     -- used to underline "Error" diagnostics.
  LspDiagnosticsDefaultWarning = { fg = palettes.warn_fg },                                                   -- used for "Warning" diagnostic signs in sign column
  LspDiagnosticsSignWarning = { fg = palettes.warn_fg },                                                      -- used for "Warning" diagnostic signs in sign column
  LspDiagnosticsFloatingWarning = { fg = palettes.warn_fg, style = "undercurl" },
  LspDiagnosticsVirtualTextWarning = { fg = palettes.warn_fg, style = "bold" },                               -- Virtual text "Warning"
  LspDiagnosticsUnderlineWarning = { fg = palettes.warn_fg, style = "undercurl", sp = palettes.warn_fg },     -- used to underline "Warning" diagnostics.
  LspDiagnosticsDefaultInformation = { fg = palettes.info_fg },                                               -- used for "Information" diagnostic virtual text
  LspDiagnosticsSignInformation = { fg = palettes.info_fg },                                                  -- used for "Information" diagnostic signs in sign column
  LspDiagnosticsFloatingInformation = { fg = palettes.info_fg, style = "bold" },                              -- used for "Information" diagnostic messages in the diagnostics float
  LspDiagnosticsVirtualTextInformation = { fg = palettes.info_fg, style = "bold" },                           -- Virtual text "Information"
  LspDiagnosticsUnderlineInformation = { fg = palettes.info_fg, style = "undercurl", sp = palettes.info_fg }, -- used to underline "Information" diagnostics.
  LspDiagnosticsDefaultHint = { fg = palettes.hint_fg },                                                      -- used for "Hint" diagnostic virtual text
  LspDiagnosticsSignHint = { fg = palettes.hint_fg },                                                         -- used for "Hint" diagnostic signs in sign column
  LspDiagnosticsFloatingHint = { fg = palettes.hint_fg, style = "bold" },                                     -- used for "Hint" diagnostic messages in the diagnostics float
  LspDiagnosticsVirtualTextHint = { fg = palettes.hint_fg, style = "bold" },                                  -- Virtual text "Hint"
  LspDiagnosticsUnderlineHint = { fg = palettes.hint_fg, style = "undercurl", sp = palettes.hint_fg },        -- used to underline "Hint" diagnostics.
  LspReferenceText = { fg = palettes.none, bg = palettes.bg_hl },                                             -- used for highlighting "text" references
  LspReferenceRead = { fg = palettes.none, bg = palettes.bg_hl },                                             -- used for highlighting "read" references
  LspReferenceWrite = { fg = palettes.none, bg = palettes.bg_hl },                                            -- used for highlighting "write" references

  DiagnosticError = { fg = palettes.error_fg },
  DiagnosticUnderlineError = { fg = palettes.error_fg, style = "undercurl" },
  DiagnosticWarning = { fg = palettes.warn_fg },
  DiagnosticWarn = { fg = palettes.warn_fg },
  DiagnosticUnderlineWarn = { fg = palettes.warn_fg, style = "undercurl" },
  DiagnosticInformation = { fg = palettes.info_fg },
  DiagnosticInfo = { fg = palettes.info_fg },
  DiagnosticUnderlineInfo = { fg = palettes.info_fg, style = "undercurl" },
  DiagnosticHint = { fg = palettes.hint_fg },
  DiagnosticUnderlineHint = { fg = palettes.hint_fg, style = "undercurl" },
  DiagnosticTruncateLine = { fg = palettes.fg },
  LspFloatWinNormal = { bg = palettes.bg1, fg = palettes.red },
  LspFloatWinBorder = { bg = palettes.red, fg = palettes.red },
  ReferencesCount = { fg = palettes.purple },
  DefinitionCount = { fg = palettes.purple },
  DefinitionIcon = { fg = palettes.blue },
  ReferencesIcon = { fg = palettes.blue },
  TargetWord = { fg = palettes.cyan },

  -- Diff
  diffAdded = { fg = palettes.diff_new },
  diffRemoved = { fg = palettes.diff_change },
  diffChanged = { fg = palettes.diff_modified },
  diffOldFile = { fg = palettes.bg4 },
  diffNewFile = { fg = palettes.fg },
  diffFile = { fg = palettes.gray },
  diffLine = { fg = palettes.yellow },
  diffIndexLine = { fg = palettes.purple },

  gitcommitBlank = { fg = palettes.doom_purp },
  gitbranch = { fg = palettes.h1_md, bg = palettes.info_bg },
  -- GitSigns
  GitSignsAdd = { fg = palettes.diff_new },
  GitSignsAddNr = { fg = palettes.diff_new },
  GitSignsAddLn = { fg = palettes.diff_new },
  GitSignsChange = { fg = palettes.doom_purp },
  GitSignsChangeNr = { fg = palettes.doom_purp },
  GitSignsChangeLn = { fg = palettes.doom_purp },
  GitSignsDelete = { fg = palettes.diff_change },
  GitSignsDeleteNr = { fg = palettes.diff_change },
  GitSignsDeleteLn = { fg = palettes.diff_change },

  -- fzf lua
  FzfLuaBorder = { fg = palettes.disabled },
  FzfLuaTitle = { fg = palettes.blue },
  FzfLuaFzfMatch = { fg = palettes.purple_dark, bg = palettes.red },
  FzfLuaFzfPrompt = { fg = palettes.info_fg },
  FzfLuaFzfCursorLine = { fg = palettes.green, bg = palettes.bg2 },
  FzfLuaFzfPointer = { fg = palettes.green, bg = palettes.bg2 },
  FzfLuaFzfNormal = { fg = palettes.blue, bg = palettes.bg0 },

  -- Nvim dap
  DapBreakpoint = { fg = palettes.red },
  DapStopped = { fg = palettes.green },

  CmpItemAbbrDeprecatedDefault = { style = "strikethrough" },
  CmpItemAbbrDeprecated = { style = "strikethrough" },
  CmpItemAbbrMatch = { fg = palettes.purple },
  CmpItemAbbrMatchFuzzy = { fg = palettes.purple },
  CmpItemKindVariable = { fg = palettes.blue },
  CmpItemKindInterface = { fg = palettes.blue },
  CmpItemKindText = { fg = palettes.variable },
  CmpItemKindFunction = { fg = palettes.purple_dark },
  CmpItemKindMethod = { fg = palettes.purple },
  CmpItemKindKeyword = { fg = palettes.blue },
  CmpItemKindProperty = { fg = palettes.blue },
  CmpItemKindUnit = { fg = palettes.blue },

  BlinkCmpMenuBorder = { fg = palettes.h5_bg, bg = palettes.bg0 },
  BlinkCmpLabelDeprecated = { style = "strikethrough" },
}

for group, value in pairs(groups) do
  highlight(group, value)
end
