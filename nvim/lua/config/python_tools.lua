return {
  "nvimtools/none-ls.nvim",  -- fork of null-ls
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local ok, null_ls = pcall(require, "null-ls")
    if not ok then
      vim.notify("none-ls not available", vim.log.levels.WARN)
      return
    end

    local b = null_ls.builtins

    -- Only register Black and Pylint
    null_ls.setup({
      sources = {
        b.formatting.black,
        b.diagnostics.pylint,
      },
      on_attach = function() end, -- nothing runs automatically
    })

    -- Manual Black formatter
    vim.api.nvim_create_user_command("PyFormat", function()
      vim.lsp.buf.format({
        async = true,
        filter = function(c) return c.name == "null-ls" or c.name == "none-ls" end,
      })
    end, { desc = "Run Black formatter on current Python file" })

    -- Manual Pylint lint
    vim.api.nvim_create_user_command("PyLintFix", function()
      vim.lsp.buf.format({
        async = true,
        filter = function(c) return c.name == "null-ls" or c.name == "none-ls" end,
      })
      vim.diagnostic.setloclist({ open = true })
    end, { desc = "Run Pylint on current Python file" })

    vim.notify("Python tools ready: :PyFormat (Black) and :PyLintFix (Pylint)", vim.log.levels.INFO)
  end,
}
