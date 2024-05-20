return {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
        local mappings = {
            { {'n'}, '<leader>/', function()  require("Comment.api").toggle.linewise.current() end },
            { {'v'}, '<leader>/',  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"},
        }
        local opts = { noremap = true, silent = true }
        for _, mapping in ipairs(mappings) do
            vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
        end
    end,
    lazy = false,
}