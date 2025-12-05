return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      -- pdb-style keybindings
      { "<leader>dc", function() require("dap").continue() end, desc = "DAP: Continue (c)" },
      { "<leader>dn", function() require("dap").step_over() end, desc = "DAP: Next/Step over (n)" },
      { "<leader>ds", function() require("dap").step_into() end, desc = "DAP: Step into (s)" },
      { "<leader>dr", function() require("dap").step_out() end, desc = "DAP: Return/Step out (r)" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Break/Toggle breakpoint (b)" },
      { "<leader>dB", function() require("dap").clear_breakpoints() end, desc = "DAP: Clear all breakpoints" },
      { "<leader>dq", function() require("dap").terminate() end, desc = "DAP: Quit (q)" },
      { "<leader>dR", function() require("dap").restart() end, desc = "DAP: Restart" },
      
      -- Keep F-key bindings for convenience
      { "<F5>", function() require("dap").continue() end, desc = "DAP: Continue" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
      { "<F10>", function() require("dap").step_over() end, desc = "DAP: Step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "DAP: Step into" },
      { "<F12>", function() require("dap").step_out() end, desc = "DAP: Step out" },
    },
    config = function()
      -- Mason will handle debugpy installation and configuration
      -- No manual python path needed!
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
      -- Auto-install these debuggers
      ensure_installed = { "python" },
      
      -- Auto-configure them
      automatic_installation = true,
      
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,
        
        -- Custom Python configuration
        python = function(config)
          config.adapters = {
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
            args = { "-m", "debugpy.adapter" },
          }
          config.configurations = {
            {
              type = "python",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              console = "integratedTerminal",
              pythonPath = function()
                -- Use the python from current environment or fallback to system
                local venv_python = os.getenv("VIRTUAL_ENV") and (os.getenv("VIRTUAL_ENV") .. "/bin/python")
                return venv_python or vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
              end,
            },
          }
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { 
      "mfussenegger/nvim-dap", 
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>dU", function() require("dapui").toggle() end, desc = "DAP UI: Toggle" },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      
      -- Auto-open/close UI
      dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui"] = function() dapui.close() end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {},
  },
}
