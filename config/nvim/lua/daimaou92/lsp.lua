-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true, buffer=0 }

-- general lsp keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<leader>dl', '<CMD>Telescope diagnostics<CR>', opts)
	vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, opts)
end


local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

-- Golang
lspconfig.gopls.setup({
    cmd = {"gopls", "serve"},
    filetypes = {"go", "gomod"},
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
    on_attach = on_attach,
    capabilities = capabilities
})
-- organize go imports on save
function OrgImports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
end
local goGrp = vim.api.nvim_create_augroup("GoAutoGrp", { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern={"*.go"},
	group = goGrp,
	callback = function() 
		-- vim.lsp.buf.formatting()
		OrgImports(1000)
	end
})

----------------------------------------------------
-- Rust
require("rust-tools").setup({
	tools = { 
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    server = {
        on_attach = on_attach,
	capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
})


-------------------------------------------------------------
-- Formatting
local fmtGrp = vim.api.nvim_create_augroup("FormattingAutoGrp", { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = {"*.go", "*.rs"},
	group = fmtGrp,
	callback = function()
		vim.lsp.buf.formatting()
	end
})
