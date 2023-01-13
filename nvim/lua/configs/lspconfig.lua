vim.g.coq_settings = {
    ["keymap.recommended"] = false,
    ["keymap.pre_select"] = true,
    ["keymap.jump_to_mark"] = "<c-u>",
    ["auto_start"] = "shut-up"
}

local lspconfig = require 'lspconfig'
local coq = require 'coq'

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- JavaScript
lspconfig.tsserver.setup(coq.lsp_ensure_capabilities {
    filetypes = {
        'javascript', 'javascriptreact', 'javascript.jsx', 'typescript',
        'typescriptreact', 'typescript.tsx', 'astro'
    }
})

-- HTML
lspconfig.html.setup(coq.lsp_ensure_capabilities { capabilities = capabilities })

-- CSS
lspconfig.cssls.setup(coq.lsp_ensure_capabilities { capabilities = capabilities })

-- Svelte
lspconfig.svelte.setup(coq.lsp_ensure_capabilities { capabilities = capabilities })
