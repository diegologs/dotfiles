local execute = vim.api.nvim_command
local fn = vim.fn

local packer_install_dir = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local plug_url_format = ''
plug_url_format = 'https://hub.fastgit.org/%s'

local packer_repo = string.format(plug_url_format, 'wbthomason/packer.nvim')
local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo, packer_install_dir)

if fn.empty(fn.glob(packer_install_dir)) > 0 then
	vim.api.nvim_echo({{'Installing packer.nvim', 'Type'}}, true, {})
	execute(install_cmd)
	execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

local packer = require'packer'
return packer.startup(function()

	use {
		'folke/tokyonight.nvim',
		config = function()
			require "configs.tokyonight"
		end,
	}

	use {
		'hoob3rt/lualine.nvim',
		config = function()
			require "configs.lualine"
		end,
	}

	use {
		"akinsho/bufferline.nvim",
		config = function()
			require "configs.bufferline"
		end,
	}


	use {
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		config = function()
			require "configs.treesitter"
		end,
	}

	use {
		"neoclide/coc.nvim",
		branch = "release",
		event = "BufRead",
	}

	use {
		"sbdchd/neoformat",
		cmd = "Neoformat",
	}

	use {
		"justinmk/vim-sneak",
		keys = { 'S', 's' }
	}

	--   use "alvan/vim-closetag" -- for html autoclosing tag
	use {
		"terrortylor/nvim-comment",
		cmd = "CommentToggle",
		config = function()
			require "configs.nvim-comment"
		end
	}

	use {
		"scrooloose/nerdtree",
		cmd = { "NERDTreeToggle", "NERDTreeFind" },
		config = function()
			require "configs.nerdtree"
		end
	}

	use {
		"honza/vim-snippets",
		event = "InsertEnter *"
	}

	use {
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		requires = {
			{
				"nvim-lua/plenary.nvim",
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
			{
				"nvim-telescope/telescope-media-files.nvim",
			},
		},
		config = function()
			require "configs.telescope"
		end,
	}

end)
