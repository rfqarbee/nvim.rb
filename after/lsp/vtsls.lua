return {
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
  root_markers = {
    {
      "tsconfig.json",
      "package.json",
      "pnpm-lock.yaml",
    },
    ".git",
  },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "typescript-svelte-plugin",
            location = vim.fn.expand("$XDG_DATA_HOME")
              -- hash is randomize for each install, change this for new system
              .. "/pnpm/global/v11/21a0f-19e657612e4/node_modules/typescript-svelte-plugin",
            enableForWorkspaceTypescriptVersions = true,
          },
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
