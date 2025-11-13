-- ~/.config/nvim/lua/plugins/null-ls.lua
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local ok, null_ls = pcall(require, "null-ls")
    if not ok then
      vim.notify("none-ls not available", vim.log.levels.WARN)
      return
    end

    local b = null_ls.builtins

    -- Helper to check if a command exists
    local function executable_exists(cmd)
      return vim.fn.executable(cmd) == 1
    end

    -- Build sources table
    local sources = {
      b.formatting.black,  -- always available if black is in PATH
    }

    if executable_exists("pylint") then
      table.insert(sources, b.diagnostics.pylint)
    end

    null_ls.setup({
      sources = sources,
      on_attach = function() end, -- nothing runs automatically
    })

    -- Manual commands
    vim.api.nvim_create_user_command("PyFormat", function()
      vim.lsp.buf.format({
        async = true,
        filter = function(c) return c.name == "null-ls" or c.name == "none-ls" end,
      })
    end, { desc = "Run Black formatter on current Python file" })

    vim.api.nvim_create_user_command("PyLintFix", function()
      if executable_exists("pylint") then
        vim.lsp.buf.format({
          async = true,
          filter = function(c) return c.name == "null-ls" or c.name == "none-ls" end,
        })
        vim.diagnostic.setloclist({ open = true })
      else
        vim.notify("Pylint not installed, skipping.", vim.log.levels.WARN)
      end
    end, { desc = "Run Pylint on current Python file" })

    vim.notify("none-ls: manual Black + optional Pylint commands ready.", vim.log.levels.INFO)
  end,
}
