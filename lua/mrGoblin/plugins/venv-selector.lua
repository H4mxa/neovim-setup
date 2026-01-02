return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    ft = "python",
    branch = "regexp",
    keys = {
      { ",v", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
    opts = {
      settings = {
        search = {
          -- Search for .venv in current directory and parents
          cwd = {
            command = "fd -H -t d '^.venv$' -d 1 .",
          },
          -- Also search for other common patterns
          workspace = {
            command = "fd -H -t d '^.venv$' -d 3 .",
          },
        },
        options = {
          notify_user_on_venv_activation = true,
          auto_refresh = true,
          on_venv_activate_callback = function()
            -- Force pyright to restart with workspace diagnostics
            vim.cmd("LspRestart pyright")
            -- Also trigger linting so pylint uses the new venv
            vim.defer_fn(function()
              require("lint").try_lint()
            end, 100)
          end,
        },
      },
    },
  },
}
