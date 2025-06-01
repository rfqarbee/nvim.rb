local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command
local MiscGroup = vim.api.nvim_create_augroup("miscGroup", { clear = true })
local gitGroup = vim.api.nvim_create_augroup("mygit", { clear = true })
local WhiteSpace = vim.api.nvim_create_augroup("httpGroup", { clear = true })
local YankGroup = vim.api.nvim_create_augroup("HiglightYank", { clear = true })

-- stole from reddit
-- autocmd("CursorHold", {
--   callback = function()
--     vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
--   end
-- })

autocmd("BufWritePre", {
  desc = "Delete trailing whitespace",
  pattern = "*",
  group = WhiteSpace,
  command = [[%s/\s\+$//e]],
})

autocmd("TextYankPost", {
  desc = "Highlight when yank",
  group = YankGroup,
  callback = function()
    vim.hl.on_yank({ timeout = 100 })
  end,
})

autocmd("VimResized", {
  desc = "Resize",
  pattern = "*",
  group = vim.api.nvim_create_augroup("ResizeWin", { clear = true }),
  command = "horizontal wincmd = | vertical wincmd =",
})

usercmd("ToggleDiagnostics", function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  else
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end
end, {})

autocmd("User", {
  group = gitGroup,
  pattern = "FugitiveEditor",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = 0, noremap = true })
  end,
})

autocmd("FileType", {
  pattern = "help",
  group = MiscGroup,
  callback = function()
    local ft = vim.bo.filetype
    vim.keymap.set({ "n", "x" }, "q", "<cmd>:quit<cr>", { desc = "Quit " .. ft, buffer = true, noremap = true })
    vim.keymap.set("n", "-", "<nop>", { buffer = true, noremap = true })

    if ft == "help" then
      vim.cmd("wincmd L")
      vim.cmd("vert resize 90")
    end
  end,
})

autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end,
})
