return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
  },
  config = function()
    local wk = require("which-key")
    
    wk.setup({
      preset = "modern",
      delay = 300,
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      win = {
        border = "single",
      },
    })

    -- Register LSP keybindings (these show up when LSP is attached)
    wk.add({
      -- LSP non-leader bindings
      { "K", desc = "Hover docs" },
      { "gd", desc = "Go to definition" },
      { "gD", desc = "Go to declaration" },
      { "gt", desc = "Go to type definition" },
      { "gr", desc = "References" },
      { "gi", desc = "Go to implementation" },
      { "[d", desc = "Prev diagnostic" },
      { "]d", desc = "Next diagnostic" },
      
      -- Leader-based LSP bindings
      { "<leader>rn", desc = "Rename symbol" },
      { "<leader>ca", desc = "Code action" },
      { "<leader>f", desc = "Format buffer" },
      { "<leader>e", desc = "Show diagnostic" },
      
      -- Bufferline
      { "<leader>n", desc = "Next buffer" },
      { "<leader>p", desc = "Previous buffer" },
      { "<leader>x", desc = "Close buffer" },
      { "<leader>=b", desc = "Format with Black" },
      
      -- Telescope group
      { "<leader>f", group = "Find" },
      { "<leader>ff", desc = "Find files" },
      { "<leader>fg", desc = "Live grep" },
      { "<leader>fb", desc = "Buffers list" },
      { "<leader>fh", desc = "Help tags" },
      
      -- Window controls
      { "<leader>w", group = "Window controls" },
      
      -- DAP group
      { "<leader>d", group = "Debug" },
      { "<leader>dc", desc = "Continue (c)" },
      { "<leader>dn", desc = "Next/Step over (n)" },
      { "<leader>ds", desc = "Step into (s)" },
      { "<leader>dr", desc = "Return/Step out (r)" },
      { "<leader>db", desc = "Break/Toggle breakpoint (b)" },
      { "<leader>dB", desc = "Clear all breakpoints" },
      { "<leader>dq", desc = "Quit (q)" },
      { "<leader>dR", desc = "Restart" },
      { "<leader>dU", desc = "Toggle UI" },
    })
  end,
}
