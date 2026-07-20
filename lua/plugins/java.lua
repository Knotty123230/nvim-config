---@type LazySpec
return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      local utils = require "astrocore"

      -- Detect installed Java runtimes (e.g. from SDKMAN)
      local runtimes = {}
      local sdkman_java_dir = vim.fn.expand "~/.sdkman/candidates/java"
      if vim.fn.isdirectory(sdkman_java_dir) == 1 then
        for _, name in ipairs(vim.fn.readdir(sdkman_java_dir)) do
          if name ~= "current" and not name:match "^%." then
            local path = sdkman_java_dir .. "/" .. name
            table.insert(runtimes, {
              name = "JavaSE-" .. (name:match "^(%d+)" or name),
              path = path,
              default = (name:match "^21" ~= nil),
            })
          end
        end
      end

      -- Extend settings with best practice Java LSP defaults
      opts.settings = utils.extend_tbl(opts.settings or {}, {
        java = {
          eclipse = { downloadSources = true },
          maven = { downloadSources = true },
          implementationsCodeLens = { enabled = true },
          referencesCodeLens = { enabled = true },
          inlayHints = { parameterNames = { enabled = "none" } },
          signatureHelp = { enabled = true },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "org.assertj.core.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
            filteredTypes = {
              "com.sun.*",
              "java.awt.*",
              "jdk.*",
              "sun.*",
            },
            importOrder = {
              "java",
              "javax",
              "com",
              "org",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          configuration = {
            updateBuildConfiguration = "interactive",
            runtimes = #runtimes > 0 and runtimes or nil,
          },
        },
      })

      -- Attach custom keymaps when JDTLS attaches to a Java buffer
      local old_on_attach = opts.on_attach
      opts.on_attach = function(client, bufnr)
        if client then client.server_capabilities.inlayHintProvider = false end
        if old_on_attach then old_on_attach(client, bufnr) end

        local jdtls = require "jdtls"
        local wk_avail, which_key = pcall(require, "which-key")
        if wk_avail then
          which_key.add {
            { "<leader>j", group = "Java", icon = "☕" },
          }
        end

        vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, { buffer = bufnr, desc = "Organize Imports" })
        vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, { buffer = bufnr, desc = "Extract Variable" })
        vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, { buffer = bufnr, desc = "Extract Constant" })
        vim.keymap.set(
          "v",
          "<leader>jv",
          function() jdtls.extract_variable(true) end,
          { buffer = bufnr, desc = "Extract Variable" }
        )
        vim.keymap.set(
          "v",
          "<leader>jm",
          function() jdtls.extract_method(true) end,
          { buffer = bufnr, desc = "Extract Method" }
        )
        vim.keymap.set("n", "<leader>jt", jdtls.test_nearest_method, { buffer = bufnr, desc = "Test Nearest Method" })
        vim.keymap.set("n", "<leader>jT", jdtls.test_class, { buffer = bufnr, desc = "Test Class" })
        vim.keymap.set("n", "<leader>ju", jdtls.update_project_config, { buffer = bufnr, desc = "Update Project Config" })
      end

      return opts
    end,
  },
}
