return {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed", -- better autocompletion
    "--header-insertion=iwyu", -- smarter header insertion
    "--suggest-missing-includes", -- suggest missing #includes
    "--cross-file-rename",
  },
  filetypes = { "c", "cpp" },
  root_markers = { { "compile_commands.json", ".clangd" }, "git" },
}
