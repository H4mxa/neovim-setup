require("mrGoblin.core")

require("mrGoblin.lazy")

-- Automatically detect and set poetry venv's python as host prog
local handle = io.popen("poetry env info --path 2>/dev/null")
if handle then
  local result = handle:read("*a")
  handle:close()
  local poetry_venv_path = result:gsub("%s+", "") -- remove newline
  if vim.fn.executable(poetry_venv_path .. "/bin/python") == 1 then
    vim.g.python3_host_prog = poetry_venv_path .. "/bin/python"
  end
end
