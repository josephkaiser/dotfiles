--
-- KEYMAPS
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete to clipboard" })

-- Filetree
-- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
-- vim.keymap.set("n", "<leader>r", ":NvimTreeFocus<CR>", { desc = "Focus on file tree" })

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
vim.keymap.set("n", "<leader>fb", function()
  vim.cmd("!~/.local/share/nvim/mason/bin/black %")
end, { desc = "Format with Black" })

-- Diagnostic in float
vim.keymap.set("n", 'gl', function()
  vim.diagnostic.open_float(nil, { focus=false })
end)
--
-- lua/config/keymaps.lua
-- local M = {}

-- single source of truth for global mappings
-- M.global = {
  -- clipboard
  -- { mode = { "n", "v" }, lhs = "<leader>y", rhs = '"+y', desc = "Yank to clipboard" },
  -- { mode = { "n", "v" }, lhs = "<leader>d", rhs = '"+d', desc = "Delete to clipboard" },

  -- comment (Comment.nvim)
  -- { mode = "n", lhs = "<leader>/", rhs = function()
      -- require("Comment.api").toggle.linewise.current()
    -- end, desc = "Toggle comment" },
  -- { mode = "v", lhs = "<leader>/", rhs = function()
      -- require("Comment.api").toggle.linewise(vim.fn.visualmode())
    -- end, desc = "Toggle comment" },

  -- buffer ops (leave navigation that doesn't need plugin here if you want)
  -- { mode = "n", lhs = "<leader>x", rhs = ":bd<CR>",                 desc = "Close buffer" },

  -- format with Black (Mason path)
  -- { mode = "n", lhs = "<leader>=b", rhs = function()
      -- vim.cmd("!~/.local/share/nvim/mason/bin/black %")
    -- end, desc = "Format with Black" },
-- }

-- function M.apply()
  -- for _, m in ipairs(M.global) do
    -- vim.keymap.set(m.mode, m.lhs, m.rhs, { silent = true, desc = m.desc })
  -- end
-- end

-- expose clues so mini-clue can import them without retyping
-- function M.clues()
  -- local out = {}
  -- for _, m in ipairs(M.global) do
    -- if type(m.lhs) == "string" and m.lhs:find("^<leader>") and m.desc then
      -- local modes = type(m.mode) == "table" and m.mode or { m.mode }
      -- for _, md in ipairs(modes) do
        -- table.insert(out, { mode = md, keys = m.lhs, desc = m.desc })
      -- end
    -- end
  -- end
  -- return out
-- end

-- return M
