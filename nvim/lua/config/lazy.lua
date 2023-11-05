local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
    print("please install lazy.nvim first!")
    return
    -- vim.fn.system({ "git", "clone", "--filter=blob:none", "git@github.com:folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
    spec = {},
    defaults = {
        lazy = false,
        version = false
    },
    git = {
        log = { "-8" },
        timeout = 120,
        url_format = "git@github.com:%s.git",
    },
    install = { colorscheme = { "tokyonight", "habamax" }},
    checker = { enabled = true }, -- automatically check for plugin updates
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})