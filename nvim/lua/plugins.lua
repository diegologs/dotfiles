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
  use {
    "folke/tokyonight.nvim",
    config = function()
      require "configs.tokyonight"
    end
  }

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

  -- Don't move vertically in buffer on windows event like opening buffer
  use {
    "luukvbaal/stabilize.nvim",
    config = function() require("stabilize").setup() end
  }

  -- Show open files as tabs
  use {
    "ap/vim-buftabline",
    config = function()
      require "configs.buftabline"
    end
  }

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

  -- Alternative to lightspeed
  -- use {
    --    "justinmk/vim-sneak",
    --    keys = {"S", "s"}
    -- }

    -- Classic file tree explorer
    use {
      "scrooloose/nerdtree",
      cmd = {"NERDTreeToggle", "NERDTreeFind"},
      config = function()
        require "configs.nerdtree"
      end
    }

    -- Smooth scroll pressing Control + F and Control + B
    use {"psliwka/vim-smoothie"}

    -- To change parents, brackets, in pairs
    use {"tpope/vim-surround"}

    -- Modal menu to search in the code and open files with fuzzy
    use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      requires = {
        {
          "nvim-lua/plenary.nvim"
        },
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make"
        },
        {
          "nvim-telescope/telescope-media-files.nvim"
        }
      },
      config = function()
        require "configs.telescope"
      end
    }
  end
  )

