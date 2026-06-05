return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  opts = {
    dashboard = {
      width = 60,
      row = nil,
      col = nil,
      pane_gap = 4,
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

      preset = {
        pick = nil,

        keys = {
          {
            icon = " ",
            key = "f",
            desc = "Find File",
            action = function()
              require("snacks").dashboard.pick("files")
            end,
          },
          {
            icon = " ",
            key = "n",
            desc = "New File",
            action = ":ene | startinsert",
          },
          {
            icon = " ",
            key = "g",
            desc = "Find Text",
            action = function()
              require("snacks").dashboard.pick("live_grep")
            end,
          },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = function()
              require("snacks").dashboard.pick("oldfiles")
            end,
          },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = function()
              require("snacks").dashboard.pick("files", {
                cwd = vim.fn.stdpath("config"),
              })
            end,
          },
          {
            icon = " ",
            key = "s",
            desc = "Restore Session",
            section = "session",
          },
          {
            icon = "󰒲 ",
            key = "L",
            desc = "Lazy",
            action = ":Lazy",
            enabled = package.loaded.lazy ~= nil,
          },
          {
            icon = " ",
            key = "q",
            desc = "Quit",
            action = ":qa",
          },
        },

        header = [[
 ██████╗ ███████╗██████╗ ██╗███████╗ █████╗ ██████╗ ███████╗████████╗
██╔════╝ ██╔════╝██╔══██╗██║██╔════╝██╔══██╗██╔══██╗██╔════╝╚══██╔══╝
██║  ███╗█████╗  ██████╔╝██║███████╗███████║██████╔╝█████╗     ██║   
██║   ██║██╔══╝  ██╔══██╗██║╚════██║██╔══██║██╔══██╗██╔══╝     ██║   
╚██████╔╝███████╗██║  ██║██║███████║██║  ██║██████╔╝███████╗   ██║   
 ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝   ╚═╝  
]],
      },

      formats = {
        icon = function(item)
          if item.file and (item.icon == "file" or item.icon == "directory") then
            return require("snacks").dashboard.icon(item.file, item.icon)
          end
          return { item.icon, width = 2, hl = "icon" }
        end,

        footer = { "%s", align = "center" },
        header = { "%s", align = "center" },

        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ":~")
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname

          if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ":h")
            local file = vim.fn.fnamemodify(fname, ":t")
            if dir and file then
              file = file:sub(-(ctx.width - #dir - 2))
              fname = dir .. "/…" .. file
            end
          end

          local dir, file = fname:match("^(.*)/(.+)$")
          return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
        end,
      },

      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },

  config = function(_, opts)
    local Snacks = require("snacks")
    Snacks.setup(opts)

    -- ✅ aquí SÍ existe Snacks
    vim.ui.input = Snacks.input
    vim.ui.select = Snacks.picker.select
  end,
}
