vim.g.mapleader = "\\"
vim.g.maplocalleader = " "

vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/ctrlpvim/ctrlp.vim',
  { src = 'https://github.com/knubie/vim-kitty-navigator' },
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/julialang/julia-vim',
})

-- vim-kitty-navigator post-install hook
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  if ev.data.spec.name == 'vim-kitty-navigator' and ev.data.kind == 'install' then
    vim.fn.system('cp ' .. ev.data.spec.path .. '/*.py ~/.config/kitty/')
  end
end })

require('mason').setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require('lualine').setup {
  options = { showtabline = 1 },
  tabline = {
    lualine_a = {'buffers'},
    lualine_z = {'tabs'}
  },
}

vim.opt.termguicolors = true
vim.cmd [[highlight Normal guibg=NONE ctermbg=NONE]]
vim.opt.hidden = true

vim.keymap.set("n", "<F20>", ":bnext<CR>", {desc = "Next buffer" })
vim.keymap.set("n", "<F19>", ":bprevious<CR>", {desc = "Previous buffer" })
vim.keymap.set("n", "<leader>q", ":bdelete<CR>", {desc = "Delete buffer" })
vim.keymap.set("v", "<leader>a", ":!column -t -s '|' -o '|'<CR>", {desc = "Align pipe-delimited table" })
vim.g.ctrlp_user_command = 'git ls-files %s --exclude-standard'
