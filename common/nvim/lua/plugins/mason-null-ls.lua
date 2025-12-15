-- ~/.config/nvim/lua/plugins/mason-null-ls.lua
return {
  "jay-babu/mason-null-ls.nvim",
  dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
  config = function()
    local ok, mason_null_ls = pcall(require, "mason-null-ls")
    if not ok then
      vim.notify("mason-null-ls not available", vim.log.levels.WARN)
      return
    end

    mason_null_ls.setup({
      ensure_installed = {},        -- empty table = nothing is auto-installed
      automatic_installation = false, -- disables background installs
      handlers = {},               -- we don’t need any handlers for auto-install
    })
  end,
}
