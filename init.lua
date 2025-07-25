-- Prepend NvChad custom paths for diagnostics
local config_path = vim.fn.stdpath("config")
package.path = config_path .. "/lua/custom/?.lua;" .. package.path
package.path = config_path .. "/lua/custom/?/init.lua;" .. package.path
package.path = config_path .. "/lua/?.lua;" .. package.path
package.path = config_path .. "/lua/?/init.lua;" .. package.path

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "custom.plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.keymap.set("n", '<leader>k',
  function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filter = { bufnr = bufnr }
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
end)

require('neogit').setup {
  integrations = {
    diffview = true --Enables split diff view
  }
}

-- require('lspconfig').gopls.setup({
--   cmd = { "gopls" },
--   filetypes = { "go", "gomod", "gowork", "gotmpl" },
--   root_dir = require('lspconfig/util').root_pattern("go.work", "go.mod", ".git"),
-- })
--
--
-- require("go").setup({
--   lsp_cfg = {
--     cmd = {"gopls"},
--     filetypes = {"go", "gomod"},
--     root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
--     settings = {
--       gopls = {
--         analyses = {
--           unusedparams = true,
--         },
--         staticcheck = true,
--       },
--     },
--   },
-- })
-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = {
--     "go", "gomod", "gowork", "lua", "json", "bash", -- add others as needed
--   },
--   highlight = {
--     enable = true,
--   },
-- }
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "go", "lua", "query", "json", "bash"
  },
  highlight = {
    enable = false,
  },
}

-- require('telescope.builtin').lsp_definitions()
-- require('telescope.builtin').lsp_references()
-- require('telescope.builtin').lsp_document_symbols()

