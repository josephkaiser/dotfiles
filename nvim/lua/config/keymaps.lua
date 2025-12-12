-- KEYMAPS
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete to clipboard" })

-- window control
vim.keymap.set('n', '<leader>w', '<C-w>', { noremap = false }, { desc = "Window controls" })

-- Buffers
vim.keymap.set("n", "<leader>n", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>p", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>x", ":bd<CR>", { desc = "Close buffer" })

-- Comment.nvim
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle block comment" })

vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle line comment" })

-- Black
-- vim.keymap.set("n", "<leader>fb", function()
--   vim.cmd("!~/.local/share/nvim/mason/bin/black %")
-- end, { desc = "Format with Black" })

