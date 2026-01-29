-- colur of terminal
vim.o.termguicolors = true  -- Sopport to 24-bit colour

--show list number
vim.opt.number = true              -- show number of linea
vim.opt.relativenumber = true 

-- Font setting
--vim.o.guifont = "JetBrains Mono:h5"  -- Font family and size

-- configuration wrap
vim.opt.wrap = true          -- Enable soft wrapping
vim.opt.linebreak = true     -- Wrap at word boundaries (not mid-word)
vim.opt.showbreak = '↪ '     -- Prefix for wrapped lines (optional)
vim.opt.breakindent = true   -- Maintain indentation in wrapped lines

vim.opt.textwidth = 80       -- Hard wrap limit (see next section)

-- Base option (equal a vim.opt, vim.wo)
vim.opt.title = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.list = false


