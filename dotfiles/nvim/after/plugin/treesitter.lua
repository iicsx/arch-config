require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,

    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('nvim-treesitter.install').compilers = { "gcc" }
