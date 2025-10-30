return {
  "echasnovski/mini.clue",
  version = false,
  lazy = false,
  config = function()
    local miniclue = require("mini.clue")
    
    -- -- DAP Keymaps for F-keys + <leader>d-prefixed so mini.clue can hint
    -- local dap = require("dap")
    -- local ok_dapui, dapui = pcall(require, "dapui")

    -- add plugin leader clues here
    local plugin_leader_clues = {
      -- diagnostic
      { mode = "n", keys = "gl", desc = "Diagnose error message" },

      -- bufferline
      { mode = "n", keys = "<leader>n",  desc = "Next buffer" },
      { mode = "n", keys = "<leader>p",  desc = "Previous buffer" },
      { mode = "n", keys = "<leader>x",  desc = "Close buffer" },
      { mode = "n", keys = "<leader>=b", desc = "Format with Black" },

      -- persistence.nvim
      { mode = "n", keys = "<leader>qs", desc = "Restore session" },
      { mode = "n", keys = "<leader>ql", desc = "Restore last session" },
      { mode = "n", keys = "<leader>qd", desc = "Don't save session" },
      { mode = "n", keys = "<leader>qS", desc = "Save session now" },

      -- telescope
      { mode = "n", keys = "<leader>ff", desc = "Find files" },
      { mode = "n", keys = "<leader>fg", desc = "Live grep" },
      { mode = "n", keys = "<leader>fb", desc = "Buffers list" },
      { mode = "n", keys = "<leader>fh", desc = "Help tags" },

      -- LSP
      { mode = "n", keys = "gd",         desc = "Go to definition" },
      { mode = "n", keys = "gr",         desc = "References" },
      { mode = "n", keys = "K",          desc = "Hover docs" },
      { mode = "n", keys = "<leader>rn", desc = "Rename symbol" },
      { mode = "n", keys = "<leader>ca", desc = "Code action" },
      { mode = "n", keys = "[d",         desc = "Prev diagnostic" },
      { mode = "n", keys = "]d",         desc = "Next diagnostic" },
      { mode = "n", keys = "<leader>lr", desc = "LSP: Rename" },
      { mode = "n", keys = "<leader>la", desc = "LSP: Code action" },
      { mode = "n", keys = "<leader>le", desc = "LSP: Line diagnostics" },

      -- DAP
      { mode = "n", keys = "<leader>dc", desc = "Continue (F5)" },
      { mode = "n", keys = "<leader>db", desc = "Toggle breakpoint (F9)" },
      { mode = "n", keys = "<leader>do", desc = "Step over (F10)" },
      { mode = "n", keys = "<leader>di", desc = "Step into (F11)" },
      { mode = "n", keys = "<leader>du", desc = "Step out (F12)" },
      { mode = "n", keys = "<leader>dB", desc = "Clear breakpoints" },
      { mode = "n", keys = "<leader>dr", desc = "Restart" },
      { mode = "n", keys = "<leader>dq", desc = "Terminate" },
      { mode = "n", keys = "<leader>dU", desc = "Toggle DAP UI" },

      -- Treesitter textobjects (adjust to your mappings)
      { mode = "o", keys = "<CR>",   desc = "TS: Node incremental" },
      { mode = "x", keys = "<CR>",   desc = "TS: Node incremental" },
      { mode = "o", keys = "<S-CR>", desc = "TS: Scope incremental" },
      { mode = "x", keys = "<S-CR>", desc = "TS: Scope incremental" },
      { mode = "o", keys = "<BS>",   desc = "TS: Node decremental" },
      { mode = "x", keys = "<BS>",   desc = "TS: Node decremental" },

      -- iron.nvim (REPL)
      { mode = "n", keys = "<leader>rr",       desc = "Toggle REPL" },
      { mode = "n", keys = "<leader>rR",       desc = "Restart REPL" },
      { mode = "n", keys = "<leader>sc",       desc = "Send motion" },
      { mode = "v", keys = "<leader>sc",       desc = "Send selection" },
      { mode = "n", keys = "<leader>sf",       desc = "Send file" },
      { mode = "n", keys = "<leader>sl",       desc = "Send line" },
      { mode = "n", keys = "<leader>sp",       desc = "Send paragraph" },
      { mode = "n", keys = "<leader>su",       desc = "Send to cursor" },
      { mode = "n", keys = "<leader>sm",       desc = "Send mark" },
      { mode = "n", keys = "<leader>sb",       desc = "Send code block" },
      { mode = "n", keys = "<leader>sn",       desc = "Send block + next" },
      { mode = "n", keys = "<leader>mc",       desc = "Mark motion" },
      { mode = "v", keys = "<leader>mc",       desc = "Mark selection" },
      { mode = "n", keys = "<leader>md",       desc = "Remove mark" },
      { mode = "n", keys = "<leader>s<cr>",    desc = "Send CR to REPL" },
      { mode = "n", keys = "<leader>s<leader>",desc = "Interrupt REPL" },
      { mode = "n", keys = "<leader>sq",       desc = "Quit REPL" },
      { mode = "n", keys = "<leader>cl",       desc = "Clear REPL" },
    }

    -- build a flat list of clues
    local clues = {}
    local function add(list) if type(list) == "table" then vim.list_extend(clues, list) end end
    add(miniclue.gen_clues.builtin_completion())
    add(miniclue.gen_clues.marks())
    add(miniclue.gen_clues.registers())
    add(miniclue.gen_clues.windows())
    add(miniclue.gen_clues.z())
    add(global_clues)
    add(plugin_leader_clues)
    add(miniclue.gen_clues.g())

    miniclue.setup({
      triggers = {
        { mode = "n", keys = "<leader>" },
        { mode = "v", keys = "<leader>" },
        { mode = "n", keys = "g" },
        { mode = "n", keys = "]" },
        { mode = "n", keys = "[" },
      },
      clues = clues,
      window = { delay = 100, config = { border = "single" } },
    })
  end,
}
