return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local signs = require("custom.icons").lsp_signs
      local map = require("custom.utils").map
      vim.diagnostic.config({
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.INFO] = signs.Info,
            [vim.diagnostic.severity.HINT] = signs.Hint,
          },
        },
      })

      require("mason").setup()

      local ensure_installed = {
        "gopls",
        "lua_ls",
        "csharp_ls",
        "vtsls"
      }

      local function iscx()
        local dir = vim.fn.fnamemodify(vim.fn.getcwd(0), ":~:p:h")
        local match = string.find(dir, 'contract')
        if match == nil then
          return true
        else
          return false
        end
      end


      local vue_ls = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
      local vue_plugin = {
        name = '@vue/typescript-plugin',
        location = vue_ls,
        languages = { 'vue' },
        configNamespace = 'typescript',
      }
      local vtsls_config = {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                vue_plugin,
              },
            },
          },
        },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      }
      local vue_ls_config = {
        on_init = function(client)
          client.handlers['tsserver/request'] = function(_, result, context)
            local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
            if #clients == 0 then
              vim.notify('Could not found `vtsls` lsp client, vue_lsp would not work without it.', vim.log.levels.ERROR)
              return
            end
            local ts_client = clients[1]

            local param = unpack(result)
            local id, command, payload = unpack(param)
            ts_client:exec_cmd({
              title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
              command = 'typescript.tsserverRequest',
              arguments = {
                command,
                payload,
              },
            }, { bufnr = context.bufnr }, function(_, r)
              local response_data = { { id, r.body } }
              ---@diagnostic disable-next-line: param-type-mismatch
              client:notify('tsserver/response', response_data)
            end)
          end
        end,
      }


      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_enable = iscx()
      })
      vim.lsp.config('vtsls', vtsls_config)
      vim.lsp.config('vue_ls', vue_ls_config)
      local disable_semantic_tokens = {
        lua = true,
      }

      vim.api.nvim_create_autocmd({ "LspAttach" }, {
        group = vim.api.nvim_create_augroup("neovim-lsp-group", { clear = true }),
        callback = function(event)
          local bufnr = event.buf
          local client = assert(vim.lsp.get_client_by_id(event.data.client_id), "Must have valid client")
          local fzf = require("fzf-lua")

          map("n", "<leader>li", function()
            local ts = vim.lsp.get_clients({ name = "vtsls" })[1]
            if ts then
              return ts:exec_cmd(
                {
                  title = "Remove unsued",
                  command = "typescript.removedUnusedImports",
                  arguments = { vim.api.nvim_get_current_buf() }
                },
                { bufnr = bufnr })
            end
          end, { desc = "lsp organize ?" })
          map("n", "<leader>lo", function()
            local ts = vim.lsp.get_clients({ name = "vtsls" })[1]
            if ts then
              return ts:exec_cmd(
                {
                  title = "Organize Imports",
                  command = "typescript.organizeImports",
                  arguments = { vim.api.nvim_get_current_buf() }
                },
                { bufnr = bufnr })
            end
          end, { desc = "lsp organize" })
          map("n", "gd", vim.lsp.buf.definition, { desc = "Goto defintion" })
          map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
          map("n", "grh", vim.lsp.buf.signature_help, { desc = "Signature help" })
          map("n", "grs", fzf.lsp_document_symbols, { desc = "Document symbols" })
          map("n", "grd", fzf.lsp_typedefs, { desc = "Type definition" })
          map("n", "grw", fzf.lsp_workspace_symbols, { desc = "Workspace symbols" })
          map("n", "<M-e>", function()
            vim.diagnostic.open_float({ border = "rounded", source = "if_many" })
          end, { desc = "Diagnostics open float" })

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end

          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = bufnr,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = bufnr,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
  },
}
