--Set option
local opt = vim.opt
vim.g.have_nerd_font = true
vim.g.loaded_netrw = 1 -- disable netrw
vim.g.loaded_netrwPlugin = 1

vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "sh",
  },
})

opt.showtabline = 1

opt.termguicolors = true
opt.background = "dark"
opt.guicursor = "n-v-c:block-nCursor,i-ci-ve:block-blinkwait300-blinkon50-blinkoff50,r-cr:hor20,o:hor50"
opt.mouse = "a"

opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.autoindent = true
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true

opt.wrap = false

opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.inccommand = "split"
opt.smartcase = true

opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.showmode = false
opt.laststatus = 3

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = "-", nbsp = "␣", space = " ", precedes = "⇠", extends = "⇢" } -- ·
opt.fillchars:append({ eob = " " })
opt.scrolloff = 6

opt.completeopt = { "menuone", "noselect", "menu", "noinsert" }

opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.cache/undodir"
opt.isfname:append("@-@")
opt.updatetime = 50

opt.spell = false
opt.spelllang = { "en_us", "en" }

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevelstart = 99
