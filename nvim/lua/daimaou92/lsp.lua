local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
}
local lspkind = require("lspkind")
-- require('lspkind').init({
--     with_text = true,
-- })

cmp.setup({
	snippet = {
		expand = function(args)
			-- For `vsnip` user.
			-- vim.fn["vsnip#anonymous"](args.body)

			-- For `luasnip` user.
			require("luasnip").lsp_expand(args.body)

			-- For `ultisnips` user.
			-- vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
    	},
	},

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == 'cmp_tabnine' then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. ' ' .. menu
                end
                vim_item.kind = ''
            end
            vim_item.menu = menu
            return vim_item
        end
    },

	sources = {
		{ name = "nvim_lsp" },

		-- For vsnip user.
		-- { name = 'vsnip' },

		-- For luasnip user.
		{ name = "luasnip" },

		-- For ultisnips user.
		-- { name = 'ultisnips' },

		{ name = "buffer" },
	},
})

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}, _config or {})
end

-- lsp-installer setups
-- local lsp_installer = require("nvim-lsp-installer")
-- lsp_installer.on_server_ready(function(server)
--     local opts = {}
--
--     if server.name == "gopls" then
--         opts.settings = {
-- 			gopls = {
-- 				analyses = {
-- 					unusedparams = true,
-- 				},
-- 				staticcheck = true,
-- 			},
-- 		}
-- 		opts.cmd = {"gopls", "serve"}
--     end
--
-- 	if server.name == "rust_analyzer" then
-- 		opts.cmd = {"rustup", "run", "nightly", "rust-analyzer"}
-- 	end
--
-- 	server:setup(opts)
-- end)

------------------------------
---- server setups -----------
------------------------------

-- Bash
require'lspconfig'.bashls.setup{}

-- CSS
require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

-- CSS Modules
require'lspconfig'.cssmodules_ls.setup{}

-- Docker LS
require'lspconfig'.dockerls.setup{}

-- Go (gopls)
require'lspconfig'.gopls.setup{
	cmd = {
		"gopls", "serve",
	},
	settings = {
 		gopls = {
 			analyses = {
 				unusedparams = true,
 			},
 			staticcheck = true,
		},
	},
}

-- HTML
require'lspconfig'.html.setup {
  capabilities = capabilities,
}

-- JSON
require'lspconfig'.jsonls.setup {
  capabilities = capabilities,
}

-- Rust Analyzer
-- require'lspconfig'.rust_analyzer.setup{}
require('rust-tools').setup {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

-- SQLS
require'lspconfig'.sqls.setup{}

-- Svelte
require'lspconfig'.svelte.setup{}

-- TailwindCSS
require'lspconfig'.tailwindcss.setup{}

-- Taplo (TOML toolkit)
require'lspconfig'.taplo.setup{}

-- Typescript
require'lspconfig'.tsserver.setup{}

-- VimLS
require'lspconfig'.vimls.setup{}

-- zk (Markdown)
require'lspconfig'.zk.setup{
	root_dir = function(fname)
    	return vim.fn.getcwd()
	end
}

local opts = {
	-- whether to highlight the currently hovered symbol
	-- disable if your cpu usage is higher than you want it
	-- or you just hate the highlight
	-- default: true
	highlight_hovered_item = true,

	-- whether to show outline guides
	-- default: true
	show_guides = true,
}

require("symbols-outline").setup(opts)

local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.vim/plugged/"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})
