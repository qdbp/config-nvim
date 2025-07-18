-- generic autogroup helpers
-- enable access/write highlight
-- TODO move to lsp specific secion? lsp is big
local mk_cmd = vim.api.nvim_create_autocmd

-- LSP
-- LSP autocommands live in 4x_lsp_*.lua

-- FOLDING
-- autofold
mk_cmd("BufEnter", {
  pattern = "*",
  callback = function(data)
    local name = vim.api.nvim_buf_get_name(data.buf)
    if name:match("diffview") or name:match("gitsigns") then
      vim.wo.foldmethod = "diff"
    elseif U.buffer_has_parser(data.buf) then
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    else
      vim.wo.foldmethod = "indent"
    end
  end,
})

-- DIFFVIEW
-- fix the folds for diffs, etc
mk_cmd("FileType", {
  pattern = { "DiffviewFiles", "DiffviewFileHistory" },
  callback = function() vim.wo.foldmethod = "diff" end,
})

-- TREE:
-- open automatically:
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
  vim.cmd("wincmd p")
end
mk_cmd({ "VimEnter" }, { callback = open_nvim_tree })
