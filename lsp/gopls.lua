return {
  cmd = { 'gopls' },
  filetypes = { "go" },
  root_markers = { { 'go.mod', 'go.sum' }, 'git' },
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
      gofumpt = true
    }
  }
}
