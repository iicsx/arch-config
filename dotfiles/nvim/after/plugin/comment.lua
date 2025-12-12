require("Comment").setup({
    toggler = {
        ---Line-comment toggle keymap
        line = '<leader>cl',
        ---Block-comment toggle keymap
        block = '<leader>cb',
    },
    extra = {
        ---Add comment at the end of line
        eol = '<C-g>',
    },
})
