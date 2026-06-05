return {
  "GustavEikaas/easy-dotnet.nvim",
  ft = {
    "cs",
    "fs",
    "vb",
    "csproj",
    "fsproj",
    "sln",
    "slnx",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    "folke/snacks.nvim",
  },
  config = function()
    local dotnet = require("easy-dotnet")

    dotnet.setup({
      -- picker
      picker = "snacks",

      -- IMPORTANTÍSIMO: apagar trabajo en background
      background_scanning = false,

      -- apaga features que no necesitas al abrir
      csproj_mappings = false,
      fsproj_mappings = false,

      auto_bootstrap_namespace = {
        enabled = false,
      },

      lsp = {
        enabled = true,
        preload_roslyn = false, -- <- CLAVE
        roslynator_enabled = false, -- <- CLAVE
        easy_dotnet_analyzer_enabled = false, -- <- CLAVE
        auto_refresh_codelens = false, -- <- CLAVE
        analyzer_assemblies = {},
        config = {},
      },

      test_runner = {
        auto_start_testrunner = false, -- <- CLAVE
        viewmode = "float",
        hide_legend = true,
      },

      diagnostics = {
        default_severity = "error",
        setqflist = false,
      },

      terminal = function(path, action, args)
        local command = string.format("dotnet %s %s %s", action, path, args or "")
        vim.cmd("vsplit | term " .. command)
      end,
    })

    -- =========================
    -- MAPEOS LIGEROS / MANUALES
    -- =========================

    vim.keymap.set("n", "<leader>db", function()
      dotnet.build()
    end, { desc = "Dotnet build" })

    vim.keymap.set("n", "<leader>dr", function()
      dotnet.run()
    end, { desc = "Dotnet run" })

    vim.keymap.set("n", "<leader>dt", function()
      local ok, runner = pcall(require, "easy-dotnet.test-runner")
      if ok then
        runner.refresh()
      else
        vim.notify("Test runner no disponible", vim.log.levels.WARN)
      end
    end, { desc = "Dotnet test runner refresh" })

    -- Arrancar/parar LSP manualmente
    vim.keymap.set("n", "<leader>dl", function()
      dotnet.lsp_start()
    end, { desc = "Dotnet LSP start" })

    vim.keymap.set("n", "<leader>dL", function()
      dotnet.lsp_stop()
    end, { desc = "Dotnet LSP stop" })

    -- Seleccionar solución de forma explícita
    vim.keymap.set("n", "<leader>ds", function()
      vim.ui.input({
        prompt = "Path de la solución (.sln/.slnx): ",
        completion = "file",
      }, function(input)
        if input and input ~= "" then
          dotnet.solution_select(input)
          vim.notify("Solución fijada: " .. input, vim.log.levels.INFO)
        end
      end)
    end, { desc = "Dotnet solution select" })

    -- Reset si se queda cacheado algo raro
    vim.keymap.set("n", "<leader>dR", function()
      dotnet.reset()
      vim.notify("easy-dotnet cache reseteada", vim.log.levels.INFO)
    end, { desc = "Dotnet reset cache" })
  end,
}
