return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard", -- Встановлює "hard" контраст для темного фону
    })
    vim.o.background = "dark" -- Переконуємось, що обрано темний фон
  end,
}
