return {
  "3rd/diagram.nvim",
  dependencies = {
    {
      "3rd/image.nvim",
      opts = {
        backend = "sixel",
        max_width_window_percentage = 100,
        max_height_window_percentage = 90,
        integrations = {
          markdown = {
            enabled = true,
          },
        },
      },
    },
  },
  opts = {
    events = {
      render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
      clear_buffer = { "BufLeave" },
    },
    renderer_options = {
      mermaid = {
        background = nil,
        theme = "dark",
        scale = 2,
        width = 2400,
        height = 1600,
      },
    },
  },
}
