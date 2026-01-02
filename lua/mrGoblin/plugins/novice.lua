return {
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim", -- Required UI library
      "rcarriga/nvim-notify", -- Optional but recommended for notifications
    },
    config = function()
      -- Set up nvim-notify
      require("notify").setup({
        -- Customize options for nvim-notify
        background_colour = "#1e1e1e", -- Adjust for dark background
        stages = "fade_in_slide_out", -- You can test other stages like 'fade'
        timeout = 4000, -- Notification timeout (in milliseconds)
        render = "simple",
        max_width = 100, -- Adjust for better wrapping control
        fps = 60,
        merge_duplicates = true,
      })

      -- Set up noice.nvim
      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline_popup", -- Use 'cmdline' or 'cmdline_popup' for cmdline
        },
        messages = {
          enabled = false, -- Disable general message prettification to avoid interfering with LSP
        },
        popupmenu = {
          enabled = true, -- Enable popupmenu for LSP code actions and completions
        },
        routes = {
          {
            filter = { event = "msg_show", kind = "lsp" }, -- Allow LSP messages to pass through
            opts = { skip = false }, -- Don't skip LSP messages
          },
          {
            filter = { event = "msg_show" }, -- Skip regular messages
            opts = { skip = true },
          },
        },
        notify = {
          enabled = false, -- Disable to avoid conflict with nvim-notify
        },
      })
    end,
  },
}
