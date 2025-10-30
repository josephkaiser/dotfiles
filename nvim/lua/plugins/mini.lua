-- Mini modules
return {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.indentscope").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.trailspace").setup()
      require("mini.move").setup()
      require("mini.statusline").setup()
      require("mini.icons").setup()
      require("mini.animate").setup()
      -- require("mini.clue").setup()
      -- require("mini.comment").setup()
    end
}
