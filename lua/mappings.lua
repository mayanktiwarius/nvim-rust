require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
	"n",
	"<Leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })

-- Terminal bindings
map("n", "<leader>i", function()
  -- Create new tab with terminal
  vim.cmd('tabnew | terminal')
  -- Enter insert mode
  vim.cmd('startinsert')
end, { desc = "New terminal in tab" })

-- Terminal mode mappings
map("t", "<C-h>", [[<C-\><C-n><C-W>h]], { desc = "Terminal window left" })
map("t", "<C-j>", [[<C-\><C-n><C-W>j]], { desc = "Terminal window down" })
map("t", "<C-k>", [[<C-\><C-n><C-W>k]], { desc = "Terminal window up" })
map("t", "<C-l>", [[<C-\><C-n><C-W>l]], { desc = "Terminal window right" })
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Terminal normal mode" })

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })

-- Git
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>")
map("n", "<leader>gb", "<cmd>Git blame<cr>")
map("n", "<leader>gl", "<cmd>Git log --oneline --graph --decorate --all<cr>")
map("n", "gfd", "<cmd>Gitsigns diffthis<CR>", { desc = "Git: diff current file" })

-- yank/paste to clipboard
map({ "n", "v" }, "<leader>y", [["+y]])
map({ "n", "v" }, "<leader>p", [["+p]])

-- ufo
local ufo = require("ufo")
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)

-- -- bufferline
-- vim.keymap.set("n", "<leader>bs", "<Cmd>BufferLinePick<CR>", { silent = true })
-- vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
-- vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineMovePrev<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>br", "<Cmd>BufferLineMoveNext<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>bx", "<Cmd>BufferLinePickClose<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>bxa", "<Cmd>BufferLineCloseOthers<CR>", { silent = true })
