local execute = vim.api.nvim_command
local fn = vim.fn

local packer_install_dir = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local plug_url_format = ""
plug_url_format = "https://github.com/%s"

local packer_repo = string.format(plug_url_format, "wbthomason/packer.nvim")
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

if fn.empty(fn.glob(packer_install_dir)) > 0 then
  vim.api.nvim_echo({{"Installing packer.nvim", "Type"}}, true, {})
  execute(install_cmd)
  execute "packadd packer.nvim"
end

vim.cmd [[packadd packer.nvim]]

local packer = require "packer"
return packer.startup(
function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Best colorscheme --
  -- use {
  --   "folke/tokyonight.nvim",
  --   config = function()
  --     require "configs.tokyonight"
  --   end
  -- }

  -- -- Best light colorscheme --
  -- use 'shaunsingh/solarized.nvim'

  -- Another theme
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
        vim.api.nvim_command "colorscheme catppuccin-mocha"
    end
}

  -- Needed in other plugins
  use "nvim-lua/plenary.nvim"

  -- Bottom status line
  use {
    "hoob3rt/lualine.nvim",
    config = function()
      require "configs.lualine"
    end
  }

  -- Don't move cursor when using >, <, =
  use({
    "gbprod/stay-in-place.nvim",
    config = function()
      require("stay-in-place").setup({
      })
    end
  })

  -- To comment things
  use({
    "terrortylor/nvim-comment",
    config = function()
      require('nvim_comment').setup({
    })
    end
  })

  -- Don't move vertically in buffer on windows event like opening buffer
  use {
    "luukvbaal/stabilize.nvim",
    config = function() require("stabilize").setup() end
  }

  -- Show open files as tabs
  -- use {
  --   "ap/vim-buftabline",
  --   config = function()
  --     require "configs.buftabline"
  --   end
  -- }

  -- Best syntax highlight
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require "configs.treesitter"
    end
  }

  -- LSP. Use :CocInstall to install language servers
  use {
    "neoclide/coc.nvim",
    branch = "release",
    event = "BufRead"
  }

  -- Use the "s" key to jump in the code
  use {
    "ggandor/lightspeed.nvim",
    config = function()
      require "configs.lightspeed"
    end
  }

  -- Maximize splitted windows
  use { "anuvyklack/windows.nvim",
   requires = {
      "anuvyklack/middleclass",
   },
   config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
   end
  }

    -- Command :Neogen to generate anotations in functions (JSDoc)
    use {
      "danymat/neogen",
      config = function()
        require('neogen').setup {}
      end,
      tag = "*"
    }

    -- Tree file explorer
    use {
      "kyazdani42/nvim-tree.lua",
      cmd = {"NvimTreeToggle", "NvimTreeFindFile"},
      config = function()
        require "configs.nvim-tree"
      end
    }

    -- Smooth scroll pressing Control + F and Control + B
  use({
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup()
    end
  })

    -- To change parents, brackets, in pairs
    use {"tpope/vim-surround"}

    use { 'junegunn/fzf', run = ":call fzf#install()" }
    use { 'junegunn/fzf.vim' }

    -- Modal menu to search in the code and open files with fuzzy
    -- use {
    --   "nvim-telescope/telescope.nvim",
    --   cmd = "Telescope",
    --   requires = {
    --     {
    --       "nvim-lua/plenary.nvim"
    --     },
    --     {
    --       "nvim-telescope/telescope-fzf-native.nvim",
    --       run = "make"
    --     },
    --     {
    --       "nvim-telescope/telescope-media-files.nvim"
    --     }
    --   },
    --   config = function()
    --     require "configs.telescope"
    --   end
    -- }
  end
  )

