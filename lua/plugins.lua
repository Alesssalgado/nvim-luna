--install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- setting plugin
require("lazy").setup({
  -- Plugins de UI
  { "nvim-lualine/lualine.nvim" },
  { "akinsho/bufferline.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  -- add new plug and colour
 {
   "craftzdog/solarized-osaka.nvim",
   lazy = false,
   priority = 1000,
   config = function()
     require("solarized-osaka").setup({
       transparent = true,
       terminal_colors = true,
       styles = {
         comments = { italic = true },
         keywords = { italic = true },
         functions = {},
         variables = {},
         sidebars = "dark",
         floats = "dark",
       },
       sidebars = { "qf", "help" },
       day_brightness = 0.3,
       hide_inactive_statusline = false,
       dim_inactive = false,
       lualine_bold = false,
     })
     vim.cmd([[colorscheme solarized-osaka]])
   end,
 },


--[[ 
  -- TokyoNight Theme (COMENTADO)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "moon", -- Estilos disponibles: storm, night, moon, day
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help", "terminal", "packer" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
      })
      -- vim.cmd.colorscheme "tokyonight"
    end,
  },
  --]]
--[[
{
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- mocha = black total
      background = { -- :h background
     	light = "latte",
     	dark = "mocha",
     	},
      transparent_background = false, -- put true if you want transplant
      integrations = {
        treesitter = true,
        cmp = true,
        gitsigns = true,
        telescope = true,
        nvimtree = true,
        mason = true,
        lsp_trouble = true,
      },
    })

    -- apply theme
    vim.cmd.colorscheme "catppuccin"
  end,
},
--]]

{
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    -- Colour personally indentation and scope
    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3B4252" }) -- grys (Nord)
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#88C0D0" })  -- blue (Nord)

    require("ibl").setup({
      indent = {
        char = "▏",
        highlight = { "IblIndent" },
      },
      scope = {
        enabled = true,
        show_start = false,
        highlight = { "IblScope" },
      },
    })
  end,
 },

{
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto', -- can use 'catppuccin' or 'tokyonight'
        icons_enabled = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
      },
    }
  end
},
	-- autocomplete tag for example ""	
	{
  	"windwp/nvim-autopairs",
  	event = "InsertEnter",
  	config = function()
    	require("nvim-autopairs").setup()
  	end,
	},


  -- Funcion key
  { "nvim-neo-tree/neo-tree.nvim", branch = "v2.x", dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" } },
  { "windwp/nvim-ts-autotag" },
  { "numToStr/Comment.nvim" },
  { "lewis6991/gitsigns.nvim" },

  -- LSP and autocomplete
  { "neovim/nvim-lspconfig", version = "^0.2.0" }, -- require for ts_ls
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim", tag = "v2.0.0" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
},
{
  performance = {
    rtp = {
      disabled_plugins = {
        "tohtml",
        "gzip",
        "matchit",
        "zipPlugin",
        "tarPlugin",
      },
    },
  },
})

-- =============================================
-- setting invdividual plugin
-- =============================================

-- setting of neo-tree
require("neo-tree").setup({
  close_if_last_window = true,
  window = { width = 30 },
  filesystem = {
    follow_current_file = true,
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = { "node_modules" },
      never_show = { ".DS_Store", "thumbs.db" },
    },
  },
})

-- nvim-ts-autotag
require("nvim-ts-autotag").setup({
  filetypes = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue" },
})

-- Comment.nvim
require("Comment").setup()

-- =============================================
-- seetin LSP and autocomplete update
-- =============================================

-- setting Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",       -- Lua
    "ts_ls",        -- TypeScript (nombre moderno)
    "html",         -- HTML
    "cssls",        -- CSS
  },
  automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")

-- Lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

-- TypeScript setting
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Habilita inlay hints (opcional)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(bufnr, true)
    end
  end,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
      },
    },
  },
})

-- HTML
lspconfig.html.setup({
  capabilities = capabilities,
  filetypes = { "html", "htmldjango" },
})

-- CSS
lspconfig.cssls.setup({
  capabilities = capabilities,
})

-- =============================================
-- setting nvim-cmp
-- =============================================

local cmp = require("cmp")
local luasnip = require("luasnip")

-- Snippets adicionales (opcional)
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
})


cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  },
})

-- command Vim (:)
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  }),
})
