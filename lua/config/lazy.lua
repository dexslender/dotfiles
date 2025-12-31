-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
-- vim.opt.laststatus = 3

-- vim.cmd("colorscheme slate")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.list = true
vim.opt.listchars = {
    -- eol = '·',
    tab = '▏ ',
    trail = '×',
    nbsp = '␣',
}

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "slate" } },
    -- automatically check for plugin updates
    -- checker = { enabled = true },
})

-- Something italics and bolds
local function update_hl(group, tbl)
    local old_hl = vim.api.nvim_get_hl_by_name(group, true)
    local new_hl = vim.tbl_extend('force', old_hl, tbl)
    vim.api.nvim_set_hl(0, group, new_hl)
end

update_hl("@lsp.type.namespace", { italic = true })
-- update_hl("@lsp.type.keyword", { bold = true })
-- update_hl("@keyword", { italic = true })
-- update_hl("@function.builtin", { bold = true })
-- update_hl("Keyword", { bold = true })
