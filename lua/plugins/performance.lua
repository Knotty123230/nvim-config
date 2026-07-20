return {
  -- 1. blink.cmp (Максимальна швидкість автодоповнення)
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    opts = {
      keymap = { preset = "default" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },

  -- 2. Вимикаємо старий nvim-cmp, щоб він не споживав ресурси
  { "hrsh7th/nvim-cmp", enabled = false },
}
