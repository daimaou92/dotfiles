-- Remaps
vim.keymap.set('n', '<C-f>', function() 
	require("telescope.builtin").current_buffer_fuzzy_find({
		sorting_startegy="ascending", layout_config={
			prompt_position="top"
		}
	})
end)

vim.keymap.set({'n'}, '<C-d>', function()
	require("telescope.builtin").find_files({follow=true})
end)
