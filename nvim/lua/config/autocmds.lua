-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_user_command("MermaidRenderRight", function()
  local input = vim.fn.expand("%:p")
  local output = vim.fn.expand("%:r") .. ".png"

  vim.cmd("write")

  local cmd = {
    "mmdc",
    "-i",
    input,
    "-o",
    output,
    "-t",
    "default",
    "-b",
    "default",
    "-w",
    "3200",
    "-H",
    "2200",
    "-s",
    "2",
  }

  local result = vim.fn.system(cmd)

  if vim.v.shell_error ~= 0 then
    vim.notify("mmdc ha fallado:\n\n" .. result, vim.log.levels.ERROR, { title = "MermaidRenderRight" })
    return
  end

  if vim.fn.filereadable(output) ~= 1 then
    vim.notify(
      "mmdc no ha generado el archivo esperado:\n" .. output .. "\n\nSalida:\n" .. result,
      vim.log.levels.ERROR,
      { title = "MermaidRenderRight" }
    )
    return
  end

  vim.cmd("vsplit " .. vim.fn.fnameescape(output))
end, {})
