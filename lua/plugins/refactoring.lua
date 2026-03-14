---@type LazySpec
return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          -- Рефакторинг (нормальний режим)
          ["<Leader>lR"] = { function() require('refactoring').select_refactor() end, desc = "Refactor Menu" },
          ["<Leader>lx"] = { desc = "Refactor/Extract" }, -- Створюємо заголовок для групи
          ["<Leader>lxe"] = { function() require('refactoring').refactor('Extract Function') end, desc = "Extract Function" },
          ["<Leader>lxf"] = { function() require('refactoring').refactor('Extract Function To File') end, desc = "Extract Function To File" },
          ["<Leader>lxv"] = { function() require('refactoring').refactor('Extract Variable') end, desc = "Extract Variable" },
          ["<Leader>lxi"] = { function() require('refactoring').refactor('Inline Variable') end, desc = "Inline Variable" },
        },
        v = {
          -- Рефакторинг (візуальний режим - тут він найкорисніший)
          ["<Leader>lR"] = { function() require('refactoring').select_refactor() end, desc = "Refactor Menu" },
          ["<Leader>lx"] = { desc = "Refactor/Extract" },
          ["<Leader>lxe"] = { function() require('refactoring').refactor('Extract Function') end, desc = "Extract Function" },
          ["<Leader>lxf"] = { function() require('refactoring').refactor('Extract Function To File') end, desc = "Extract Function To File" },
          ["<Leader>lxv"] = { function() require('refactoring').refactor('Extract Variable') end, desc = "Extract Variable" },
        },
      },
    },
  },
}
