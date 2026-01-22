local dotnet_root = vim.fn.expand("~/.dotnet")
vim.env.DOTNET_ROOT = dotnet_root
vim.env.PATH = vim.env.PATH .. ":" .. dotnet_root .. ":" .. dotnet_root .. "/tools"

return {
  -- 1. TEMA
  { "rebelot/kanagawa.nvim" },
  { "LazyVim/LazyVim", opts = { colorscheme = "kanagawa-dragon" } },

  -- 2. TREESITTER
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "csharp", "lua" })
    end,
  },

  -- 3. LUALINE (Versión segura)
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local ok, dotnet = pcall(require, "easy-dotnet")
      if ok then
        table.insert(opts.sections.lualine_x, {
          function()
            return "󰓚 .NET"
          end,
          cond = function()
            local status, resolved = pcall(dotnet.is_resolved)
            return status and resolved
          end,
          color = { fg = "#512bd4" },
        })
      end
    end,
  },

  -- 4. EASY-DOTNET (Corregido y verificado)
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local dotnet = require("easy-dotnet")

      dotnet.setup({
        terminal = function(path, action, args)
          local command = string.format("dotnet %s %s %s", action, path, args or "")
          vim.cmd("vsplit | term " .. command)
        end,
      })

      -- MAPEOS SEGUROS (Evitan el error 'got nil')
      -- Build
      vim.keymap.set("n", "<leader>db", function()
        dotnet.build()
      end, { desc = "Build Project" })

      -- Run
      vim.keymap.set("n", "<leader>dr", function()
        dotnet.run()
      end, { desc = "Run Project" })

      -- Test Runner (Corregido: cargando el módulo de UI)
      vim.keymap.set("n", "<leader>dt", function()
        local ok, runner = pcall(require, "easy-dotnet.test-runner")
        if ok then
          runner.refresh()
        else
          print("Test runner no disponible")
        end
      end, { desc = "Test Runner" })
    end,
  },

  -- 5. MASON (Nombre de repo actualizado)
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "stylua" } },
  },

  -- 6. DAP (Sin llamar a .setup)
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- Aquí no ponemos NADA de setup, dejamos que easy-dotnet inyecte las configs
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
}
