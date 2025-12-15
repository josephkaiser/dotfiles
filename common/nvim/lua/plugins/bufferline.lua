-- Bufferline (tabs for buffers)
return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>n", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<leader>p", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          separator_style = "slant",
          show_close_icon = false,
        }
      })
      -- vim.opt.termguicolors = true
      -- vim.opt.showtabline = 2
    end
}
