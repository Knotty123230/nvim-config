-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`

-- Функція для зчитування теми з Omarchy
local function get_omarchy_theme()
  local theme_name_file = vim.fn.expand("~/.config/omarchy/current/theme.name")
  if vim.fn.filereadable(theme_name_file) == 1 then
    local theme = vim.fn.readfile(theme_name_file)[1]
    -- Очищаємо від зайвих пробілів
    theme = theme:gsub("%s+", "")
    return theme
  end
  return "catppuccin" -- за замовчуванням
end

local current_theme = "tokyonight-storm" -- get_omarchy_theme()
-- Виправлення для тем
if current_theme == "matte-black" then current_theme = "matteblack" end
if current_theme == "tokyo-night" then current_theme = "tokyonight" end

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = current_theme,
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {},
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
