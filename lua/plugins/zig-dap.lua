local last_args = ""

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.zig = {
        {
          name = "Debug Zig (Simple)",
          type = "codelldb",
          request = "launch",
          program = function()
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            local expected_path = vim.fn.getcwd() .. "/zig-out/bin/" .. project_name
            if vim.fn.executable(expected_path) == 1 then
              return expected_path
            else
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/zig-out/bin/", "file")
            end
          end,
          args = function()
            local input = vim.fn.input("Arguments: ", last_args)
            last_args = input
            return vim.fn.split(input, " +")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          -- Допомагає показувати складні типи Zig
          expressions = "native",
        },
      }

      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    end,
  },
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>dc"] = { function() require("dap").continue() end, desc = "Debug: Start/Continue" },
          ["<Leader>db"] = { function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
          ["<Leader>dn"] = { function() require("dap").step_over() end, desc = "Debug: Next" },
          ["<Leader>di"] = { function() require("dap").step_into() end, desc = "Debug: Into" },
          ["<Leader>dq"] = { function() 
            require("dap").terminate()
            require("dapui").close()
          end, desc = "Debug: Stop" },
          ["<Leader>dk"] = { function() require("dap.ui.widgets").hover() end, desc = "Debug: Hover" },
          ["<Leader>du"] = { function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
          -- Відкрити консоль дебаггера, щоб вручну написати: `?назва_змінної`
          ["<Leader>dr"] = { function() require("dap").repl.open() end, desc = "Debug: Open REPL" },
        },
      },
    },
  },
}
