vim.keymap.set({ 'n', 'v' }, ' ', '<nop>', { silent = true })

local keymap = {
    -- Disable mouse and arrow movement
    { 'n', '<left>', '<cmd>echo "Use h to move!!"<CR>' },
    { 'n', '<right>', '<cmd>echo "Use l to move!!"<CR>' },
    { 'n', '<up>', '<cmd>echo "Use k to move!!"<CR>' },
    { 'n', '<down>', '<cmd>echo "Use j to move!!"<CR>' },

    -- Remove highlight after search
    { 'n', '<Esc>', '<cmd>nohlsearch<CR>' },

    -- Keep screen centered when moving around
    { 'n', '*', '*zzzv' },
    { 'n', '#', '#zzzv' },
    { 'n', ',', ',zzzv' },
    { 'n', ';', ';zzzv' },
    { 'n', 'n', 'nzzzv' },
    { 'n', 'N', 'Nzzzv' },

    -- Keep selected after moving with < and >
    { 'v', '<', '<gv' },
    { 'v', '>', '>gv' },

    -- Yank without replace register
    { 'x', '<M-p>', [["_dP]] },

    -- Seemlessly naviagate between split windows
    { 'n', '<C-h>', ':wincmd h<cr>', { desc = 'Move focus to the left window', silent = true } },
    { 'n', '<C-l>', ':wincmd l<cr>', { desc = 'Move focus to the right window', silent = true } },
    { 'n', '<C-j>', ':wincmd j<cr>', { desc = 'Move focus to the lower window', silent = true } },
    { 'n', '<C-k>', ':wincmd k<cr>', { desc = 'Move focus to the upper window', silent = true } },

    -- Better vertical movement with word wrap
    { 'n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
    { 'n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },

    -- Windows size adjustment
    { 'n', '<C-Left>', ':vertical resize +10<CR>', { silent = true } },
    { 'n', '<C-Right>', ':vertical resize -10<CR>', { silent = true } },
    { 'n', '<C-Up>', ':resize +10<CR>', { silent = true } },
    { 'n', '<C-Down>', ':resize -10<CR>', { silent = true } },

    -- Windows splits
    { 'n', '<C-w>"', '<cmd>split<cr>', { noremap = true, desc = 'Split window horizontally', silent = true } },
    { 'n', '<C-w>%', '<cmd>vsplit<cr>', { noremap = true, desc = 'Split window vertically', silent = true } },

    -- Search words under cursor
    {
        'n',
        '<leader>sw',
        [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
        { desc = 'Search word under cursor' },
    },

    -- Navigate in quickfix & location list
    { 'n', '<M-k>', '<cmd>cnext<cr>zz', { silent = true } },
    { 'n', '<M-j>', '<cmd>cprev<cr>zz', { silent = true } },
    { 'n', '<M-l>', '<cmd>lnext<cr>zz', { silent = true } },
    { 'n', '<M-h>', '<cmd>lprev<cr>zz', { silent = true } },

    -- Open a terminal at the bottom of the screen with a fixed height
    {
        'n',
        '<leader>st',
        function()
            vim.cmd.new()
            vim.cmd.wincmd 'J'
            vim.api.nvim_win_set_height(0, 12)
            vim.wo.winfixheight = true
            vim.cmd.term()
        end,
        { desc = 'Open integrated terminal' },
    },
}

local disable = {}

for _, v in ipairs(keymap) do
    vim.keymap.set(v[1], v[2], v[3], v[4] or {})
end
