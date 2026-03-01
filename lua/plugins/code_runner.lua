return {
  "CRAG666/code_runner.nvim",
  cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<Leader>r", "<cmd>RunCode<CR>", desc = "Run Code", mode = "n" },
  },
  config = function()
    require("code_runner").setup({
      mode = "term",
      focus = true,
      startinsert = true,
      filetype = {
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt",
        },
        python = "python3 -u",
        typescript = "deno run",
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "$dir/$fileNameWithoutExt",
        },
        zig = "zig run",
        c = {
          "cd $dir &&",
          "gcc $fileName -o $fileNameWithoutExt &&",
          "$dir/$fileNameWithoutExt",
        },
        cpp = {
          "cd $dir &&",
          "g++ $fileName -o $fileNameWithoutExt &&",
          "$dir/$fileNameWithoutExt",
        },
        go = "go run",
        sh = "bash",
      },
    })
  end,
}
