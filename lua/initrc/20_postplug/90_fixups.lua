-- this file fixes up bugs or other "weird" functionality in plugins

-- fix up unable to change binding in neotest summary
vim.api.nvim_create_autocmd("FileType", {
  pattern = "neotest-summary",
  callback = function()
    -- Unmap 'w' in the summary buffer
    vim.keymap.set("n", "w", "<Nop>", { buffer = true })
  end,
})
