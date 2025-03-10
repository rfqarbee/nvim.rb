return {
  "mfussenegger/nvim-jdtls",
  lazy = true,
  ft = { "java" },
  config = function()
    local home = vim.env.HOME

    local jdtls = require("jdtls")
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = home .. "/.local/share/java-workspace/" .. project_name -- metadata

    local system_os = ""
    if vim.fn.has("mac") == 1 then
      system_os = "mac"
    elseif vim.fn.has("unix") == 1 then
      system_os = "linux"
    elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
      system_os = "win"
    else
      print("OS not found, defaulting to 'linux'")
      system_os = "linux"
    end

    -- Needed for debugging
    local bundles = {
      vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
    }

    -- Needed for running/debugging unit tests
    vim.list_extend(
      bundles,
      vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-test/*.jar", true), "\n")
    )

    local config = {
      -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. home .. "/.local/share/nvim/mason/share/jdtls/lombok.jar",
        "-Xmx4g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        home .. "/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
        "-configuration", -- change if install jdtls manually instead of mason
        home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. system_os,
        "-data",
        workspace_dir,
      },

      root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "pom.xml", "build.gradle" }),

      -- Here you can configure eclipse.jdt.ls specific settings
      -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      settings = {
        java = {
          -- Replace this with the absolute path to your main java version
          -- home = "/usr/lib/jvm/jdk-23.0.2-oracle-x64",
          eclipse = {
            downloadSources = true,
          },
          configuration = {
            updateBuildConfiguration = "interactive",
            -- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
            -- The runtime name parameters need to match specific Java execution environments.  See https://github.com/tamago324/nlsp-settings.nvim/blob/2a52e793d4f293c0e1d61ee5794e3ff62bfbbb5d/schemas/_generated/jdtls.json#L317-L334
            -- runtimes = {
            --     {
            --         name = "JavaSE-11",
            --         path = "/usr/lib/jvm/java-11-openjdk-amd64",
            --     },
            --     {
            --         name = "JavaSE-17",
            --         path = "/usr/lib/jvm/java-17-openjdk-amd64",
            --     },
            --     {
            --         name = "JavaSE-19",
            --         path = "/usr/lib/jvm/java-19-openjdk-amd64",
            --     },
            -- },
          },
          maven = {
            downloadSources = true,
          },
          implementationsCodeLens = {
            enabled = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          signatureHelp = { enabled = true },
          format = {
            enabled = true,
            -- Formatting works by default, but you can refer to a specific file/URL if you choose
            -- settings = {
            --   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
            --   profile = "GoogleStyle",
            -- },
          },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
            importOrder = {
              "java",
              "javax",
              "com",
              "org",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
          },
        },
      },
      capabilities = require("blink.cmp").get_lsp_capabilities(),
      flags = {
        allow_incremental_sync = true,
      },
      init_options = {
        -- References the bundles defined above to support Debugging and Unit Testing
        bundles = bundles,
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
      },
    }

    -- Needed for debugging
    config["on_attach"] = function(client, bufnr)
      jdtls.setup_dap({ config_overrides = { hotcodereplace = "auto" } })
      require("jdtls.dap").setup_dap_main_class_configs()
    end

    jdtls.start_or_attach(config)
  end,
}
