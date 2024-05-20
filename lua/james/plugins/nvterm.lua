return {
    "NvChad/nvterm",
    opts = {
    },
    config = function(_, opts)
        require("nvterm").setup(opts)
        local terminal = require("nvterm.terminal")
        local toggle_modes = { 'n', 't' }
        local mappings = {
            { toggle_modes, '<leader>t', function() terminal.toggle('horizontal') end },
            { toggle_modes, '<leader>tf', function() terminal.toggle('float') end },
        }
        local opts = { noremap = true, silent = true }
        for _, mapping in ipairs(mappings) do
            vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
        end
    end,

}
