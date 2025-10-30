-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  -- Mason package manager
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Bridge between mason and nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local mlsp = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local caps = require("cmp_nvim_lsp").default_capabilities()
      local servers = {
          "pyright",    -- Python
          "bashls",     -- Bash
          "clangd",     -- C/C++
          "html",
          "cssls",
          "jsonls"

      }

      mlsp.setup({
        ensure_installed = servers,
        automatic_installation = true,
        handlers = {
          function(server)
            lspconfig[server].setup({
              capabilities = lsp_capabilities,
            })
          end,

          -- Python
          ["pyright"] = function()
            lspconfig.pyright.setup({
              capabilities = caps,
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "basic", -- off, basic, strict
                    diagnosticMode = "workspace",
                    autoImportCompletions = true,
                    useLibraryCodeForTypes = true,
                  },
                },
              },
            })
          end,
  
          -- Bash
          ["bashls"] = function()
            lspconfig.bashls.setup({
              capabilities = caps,
              filetypes = { "sh" },
              settings = {
                bashIde = {
                  shellcheckPath = "shellcheck", -- requires shellcheck installed
                  explainshellEndpoint = "",      -- set if you run explainshell locally
                  globPattern = "**/*@(.sh|.bash)",
                },
              },
            })
          end,
  
          -- C/C++
          ["clangd"] = function()
            local clang_caps = vim.deepcopy(caps)
            clang_caps.offsetEncoding = { "utf-16" } -- avoid encoding mismatch
            lspconfig.clangd.setup({
              capabilities = clang_caps,
              cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=never",
                "--", "-x", "c" -- Force C instead of C++ for .c files
              },
            })
          end,
        },
      })
    end,
  },

  { "neovim/nvim-lspconfig" },
}
