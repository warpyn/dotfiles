-- windows / splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window' })
vim.keymap.set('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below' })
vim.keymap.set('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right' })

-- buffer management
vim.keymap.set('n', '<leader>h', ':bprev<cr>', { desc = 'Prev Buffer', silent = true })
vim.keymap.set('n', '<leader>l', ':bnext<cr>', { desc = 'Next Buffer', silent = true })
vim.keymap.set('n', '<leader>bd', ':bdelete<cr>', { desc = 'Delete Buffer', silent = true })

-- movement
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Center cursor after moving up half-page', noremap = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Center cursor after moving down half-page', noremap = true })
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- text management
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>ch', ":s/\\[ \\]/[x]/<cr>", { desc = "Check box" })

-- lsp & diagnostics
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = 'Open diagnostic message in a floating window' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename document symbol' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Select a code action' })
vim.keymap.set('n', '<leader>bf', vim.lsp.buf.format, { desc = 'Format the current buffer' })

-- lazyvim
vim.keymap.set('n', '<leader>L', ':Lazy<cr>', { desc = 'Open lazyvim menu', silent = true })

