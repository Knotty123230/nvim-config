return {
  -- Molten: The gold standard for Jupyter in Neovim
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    lazy = false, -- Required for remote plugins to register commands
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true

      -- Keybindings
      vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })
      vim.keymap.set("n", "<leader>re", ":MoltenEvaluateOperator<CR>", { desc = "Evaluate operator", silent = true })
      vim.keymap.set("n", "<leader>rl", ":MoltenEvaluateLine<CR>", { desc = "Evaluate line", silent = true })
      vim.keymap.set("v", "<leader>re", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Evaluate visual selection", silent = true })
      vim.keymap.set("n", "<leader>rd", ":MoltenDelete<CR>", { desc = "Molten delete cell", silent = true })
      vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>", { desc = "Hide output", silent = true })
      vim.keymap.set("n", "<leader>os", ":MoltenShowOutput<CR>", { desc = "Show output", silent = true })
    end,
  },
  -- Jupytext: Proper Notebook -> Script conversion
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    config = true,
  },
  -- Image.nvim: High-quality graphics for Ghostty/Kitty
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
      integrations = {
        markdown = { enabled = true },
      },
      max_width = 100,
      max_height = 12,
      window_overlap_clear_enabled = true,
    },
  },
  -- Go
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    config = function() require("go").setup() end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
  },
}
