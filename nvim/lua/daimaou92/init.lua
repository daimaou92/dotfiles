require("daimaou92.telescope")
require("daimaou92.lsp")

-- tabline
require('tabline').setup({
    show_index = true,
    show_modify = true,
    modify_indicator = '[+]',
    no_name = 'Untitled',
})

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end
