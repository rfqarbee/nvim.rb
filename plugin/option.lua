--Set option
local opt = vim.opt
vim.g.have_nerd_font = true
-- vim.g.loaded_netrw = 1 -- disable netrw
-- vim.g.loaded_netrwPlugin = 1

vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})

opt.showtabline = 1

opt.termguicolors = true
opt.background = "dark"
opt.guicursor = "n-v-c:block-nCursor,i-ci-ve:block-blinkwait300-blinkon50-blinkoff50,r-cr:hor20,o:hor50"
opt.mouse = "a" -- enable mouse all mode

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true --:h breakindent if u forgot what this is already

opt.wrap = false -- word wrap

opt.hlsearch = true --highlight when searching
opt.incsearch = true
opt.ignorecase = true
opt.inccommand = "split"
opt.smartcase = true

opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.showmode = false --disable show mode cuz status line already show
opt.laststatus = 3 -- set statusline to global window

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = "-", nbsp = "␣", space = "·", precedes = "⇠", extends = "⇢" }
opt.fillchars:append({ eob = " " })
opt.scrolloff = 6

opt.completeopt = { "menuone", "noselect", "menu" }
--backup for undodir accessible by undotree nvim config dir
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.cache/undodir"
opt.isfname:append("@-@")
opt.updatetime = 50

opt.spelllang = { "en_us", "en" }
