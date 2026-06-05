return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    workspaces = {
      {
        name = "projects",
        path = "~/.vaults/projects",
      },
      {
        name = "architecture",
        path = "~/.vaults/architecture",
      },
    },
  },
}
