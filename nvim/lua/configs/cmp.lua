-- Configuración de nvim-cmp
local cmp = require('cmp')
local lspconfig = require('lspconfig')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- Necesario para snippets
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true }) -- Seleccionar la primera opción
      else
        fallback() -- Si no hay menú, seguir con Tab
      end
    end, { 'i', 's' }),

    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(), -- Desplazamiento con flecha abajo
    ['<Up>'] = cmp.mapping.select_prev_item(),   -- Desplazamiento con flecha arriba
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
  -- Mostrar un popup con la documentación de la opción seleccionada
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  experimental = {
    ghost_text = false, -- Deshabilitar texto fantasma para evitar distracciones
  },
  window = {
    documentation = {
      border = "rounded", -- Borde redondeado para el popup
    },
  },
})

-- Configuración de servidores LSP
local servers = {'jsonls', 'html', 'ts_ls', 'cssls', 'emmet_ls', 'angularls'}
for _, server in ipairs(servers) do
  lspconfig[server].setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, bufnr)
      -- Keybindings para LSP
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', '<leader>e', function()
        vim.diagnostic.open_float(nil, { focusable = true })
      end, bufopts) -- Muestra diagnóstico al presionar <leader>e
    end
  }
end

-- Mostrar siempre el signcolumn para diagnósticos
vim.o.signcolumn = 'yes'

-- Subrayar errores y warnings pero sin texto al final de la línea
vim.diagnostic.config({
  virtual_text = false, -- Desactiva el texto virtual al final de la línea
  underline = true, -- Activa el subrayado para errores y warnings
})

-- Diagnósticos flotantes al mantener el cursor
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

-- Configuración para resaltar referencias
vim.cmd [[
  augroup lsp_document_highlight
    autocmd!
    autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved * lua vim.lsp.buf.clear_references()
  augroup END
]]

