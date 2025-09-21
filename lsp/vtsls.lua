return {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "vue", "typescript", "javascript", "typescriptreact", "javascriptreact" },
  root_markers = {
    {
      "tsconfig.json",
      "package.json",
      "package-lock.json",
      "pnpm-lock.yaml",
      "yarn.lock",
      "bun.lockb",
      "bun.lock",
    },
    ".git",
  },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vim.fn.stdpath("data")
              .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
    },
  },
}
