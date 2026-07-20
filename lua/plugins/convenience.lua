return {
  -- Oil.nvim
  {
    "stevearc/oil.nvim",
    opts = {},
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open Oil (File System Editor)" },
    },
  },
  -- Telescope Undo
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("undo")
    end,
    keys = {
      { "<leader>u", "<CMD>Telescope undo<CR>", desc = "Undo Tree History" },
    },
  },
  -- Tmux Title
  {
    "astrocore",
    opts = {
      autocmds = {
        tmux_title = {
          {
            event = { "BufEnter", "BufWinEnter" },
            callback = function()
              local file = vim.fn.expand("%:t")
              if file == "" then file = "[No Name]" end
              vim.fn.system({ "tmux", "rename-window", "nvim: " .. file })
            end,
          },
          {
            event = { "VimLeave" },
            callback = function()
              vim.fn.system({ "tmux", "set-window-option", "automatic-rename", "on" })
            end,
          },
        },
      },
    },
  },
}
