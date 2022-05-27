if not pcall(require, "colorbuddy") then
  return
end

vim.opt.termguicolors = true

require("colorbuddy").colorscheme("gruvbuddy")
-- require("colorizer").setup()
