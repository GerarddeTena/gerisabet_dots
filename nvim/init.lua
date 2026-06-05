-- bootstrap lazy.nvim, LazyVim and your plugins
vim.opt.shell = "/bin/bash"
vim.opt.shellcmdflag = "-lc"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""
require("config.lazy")
