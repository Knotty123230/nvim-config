return {
  {
    "dmtrKovalenko/fff.nvim",
    lazy = false,
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    keys = {
      { "<leader>ff", function() require("fff").find_files() end, desc = "Find files (fff)" },
      { "<leader>fg", function() require("fff").live_grep() end, desc = "Live grep (fff)" },
      { "<leader>fc", function() require("fff").live_grep({ query = vim.fn.expand("<cword>") }) end, desc = "Search current word (fff)" },
      { "<leader>fz", function() require("fff").live_grep({ grep = { modes = { 'fuzzy', 'plain' } } }) end, desc = "Live fuzzy grep (fff)" },
      -- fff.nvim has frecency built-in for find_files, so oldfiles can also be mapped to it
      { "<leader>fo", function() require("fff").find_files() end, desc = "Recent files (fff)" },
    },
    opts = {
      -- Here you can customize fff.nvim defaults
      debug = {
        enabled = false,
        show_scores = false,
      },
    },
  },
  -- Disable default telescope keys so they don't override fff.nvim
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff", false },
      { "<leader>fw", false },
      { "<leader>fg", false },
      { "<leader>fo", false },
      { "<leader>fc", false },
      { "<leader>fz", false },
    },
  },
}
