return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
    }

    -- Configure pylint to use the Python from the activated virtual environment
    -- This ensures pylint uses the same environment as pyright
    lint.linters.pylint.cmd = function()
      -- Check if VIRTUAL_ENV is set (set by venv-selector when a venv is activated)
      local venv = vim.env.VIRTUAL_ENV
      if venv then
        -- Use python from the activated venv
        return venv .. "/bin/python"
      end
      -- Fallback to system python
      return "python"
    end

    -- Set pylint arguments to run as a module
    lint.linters.pylint.args = {
      "-m",
      "pylint",
      "-f",
      "json",
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
