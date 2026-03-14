return {
  -- Ensuring Neotest and its dependencies are installed
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "lawrence-laz/neotest-zig",
    },
    config = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-zig" {
        zig_path = "zig",
      })
      require("neotest").setup(opts)
    end,
  },
  {
    "lawrence-laz/neotest-zig",
    ft = "zig",
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },
  {
    "folke/todo-comments.nvim",
    opts = {},
    event = "User AstroFile",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User AstroFile",
    opts = { mode = "cursor", max_lines = 3 },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {},
  },
  {
    "ziglang/zig.vim",
    ft = "zig",
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          -- Neotest mappings (USING <Leader>T to avoid conflict with <Leader>tf terminal)
          ["<Leader>Tt"] = { function() if pcall(require, "neotest") then require("neotest").run.run() end end, desc = "Test: Run nearest" },
          ["<Leader>Tr"] = { function() if pcall(require, "neotest") then require("neotest").run.run(vim.fn.expand "%") end end, desc = "Test: Run file" },
          ["<Leader>Ts"] = { function() if pcall(require, "neotest") then require("neotest").summary.toggle() end end, desc = "Test: Toggle summary" },
          ["<Leader>To"] = { function() if pcall(require, "neotest") then require("neotest").output.open { enter = true } end end, desc = "Test: Show output" },
          ["<Leader>Td"] = { function() if pcall(require, "neotest") then require("neotest").run.run { strategy = "dap" } end end, desc = "Test: Debug nearest" },
          -- Todo-comments
          ["[T"] = { function() if pcall(require, "todo-comments") then require("todo-comments").prev() end end, desc = "Previous TODO" },
          ["]T"] = { function() if pcall(require, "todo-comments") then require("todo-comments").next() end end, desc = "Next TODO" },
        },
      },
    },
  },
}
