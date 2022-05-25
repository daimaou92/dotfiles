local cmp = require("cmp")
local lspkind = require("lspkind")
-- lspkind.setup()
cmp.setup {
	mapping = {
		["<C-e>"]=cmp.mapping.close(),
		["<C-y>"]=cmp.mapping(
			cmp.mapping.confirm{
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			},
			{"i", "c"}
		),
		["tab"] = cmp.config.disable
	},
	sources = {
		{name = "gh_issues"},
		{name = "nvim_lsp"},
		{name = "path"},
		{name = "luasnip"},
		{name = "buffer", keyword_length = 5},
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end
	},
	formatting = {
		format = lspkind.cmp_format {
			with_text = true,
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				path = "[path]",
				luasnip = "[snip]",
				gh_issues = "[issues]",
				--tn = "[TabNine]",
			},
    		},
	},
	experimental = {
		native_menu = false,
	},
}
