vim.g.tmux_navigator_no_mappings = 1

-- Define key mappings for navigating between tmux panes and vim splits
vim.api.nvim_set_keymap('n', '<C-h>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true })

