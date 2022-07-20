-- basic lsp-zero config
vim.opt.signcolumn = 'yes'
local lsp = require('lsp-zero')
lsp.preset('recommended')

-- remaps
local luasnip = require('luasnip')

local cmp = require('cmp')
local cmp_mappings = lsp.defaults.cmp_mappings()
cmp_mappings["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
	cmp.confirm()
        cmp.complete()
      elseif luasnip.jumpable(1) then
	      luasnip.jump(1)
      else
	fallback()
      end
    end, {'i', 's'})
cmp_mappings["<S-j>"] = cmp.mapping(function()
	if cmp.visible() then
		cmp.scroll_docs(5)
	end
    end, {'i', 's'})
cmp_mappings["<S-k>"] = cmp.mapping(function()
	if cmp.visible() then
		cmp.scroll_docs(-5)
	end
    end, {'i', 's'})
-- deactivate unused default mappings
cmp_mappings["<S-Tab>"] = nil
cmp_mappings["<C-b>"] = nil
cmp_mappings["<C-d>"] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

-- always finish lsp-zero config with this line
lsp.setup()
