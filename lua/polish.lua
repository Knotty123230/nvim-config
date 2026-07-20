-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Додаємо venv у PATH, щоб Neovim бачив jupytext та інші утиліти
local venv_path = vim.fn.expand("~/.config/nvim/venv/bin")
vim.env.PATH = venv_path .. ":" .. vim.env.PATH
