-- Lista de plugins usando paq-nvim
require "paq" {
  -- Paq manages itself
  "savq/paq-nvim",

  -- Best colorscheme
  'folke/tokyonight.nvim';

  -- Best light colorscheme
  -- 'shaunsingh/solarized.nvim';

  -- Another nice theme
  -- { "catppuccin/nvim", as = "catppuccin" },

  -- Needed in other plugins
  'nvim-lua/plenary.nvim',

  -- Bottom status line
  'hoob3rt/lualine.nvim',

  -- Don't move cursor when using >, <, =
  'gbprod/stay-in-place.nvim',

  -- To comment things
  'terrortylor/nvim-comment',

  -- Best syntax highlight
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},

  -- LSP. Use :CocInstall to install language servers
  {'neoclide/coc.nvim', branch = 'release'},

  -- Snippets
  'honza/vim-snippets',

  -- Use the "s" key to jump in the code
  'ggandor/lightspeed.nvim',

  -- Maximize splitted windows
  'anuvyklack/windows.nvim',

  -- Required by the previous plugin
  'anuvyklack/middleclass',

  -- Command :Neogen to generate annotations in functions (JSDoc)
  'danymat/neogen',

  -- Tree file explorer
  'kyazdani42/nvim-tree.lua',

  -- To change parents, brackets, in pairs
  'tpope/vim-surround',

  -- Fuzzy find to search files with Ctrl-P or Ctrl-T
  'junegunn/fzf',
  'junegunn/fzf.vim'
}

-- Configs of each plugin

require "configs.tokyonight"
require "configs.coc"
require "configs.lualine"
require "configs.treesitter"
require "configs.nvim-comment"
require "configs.lightspeed"
require "configs.nvim-tree"
