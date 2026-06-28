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

vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        prefix = "■ ",
        source = "if_many",
    },
    severity_sort = true,
})

-- Something italics and bolds
local function update_hl(group, tbl)
    local old_hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    local new_hl = vim.tbl_extend('force', old_hl, tbl)
    vim.api.nvim_set_hl(0, group, new_hl)
end

update_hl("@lsp.type.namespace", { italic = true })
-- update_hl("@lsp.type.keyword", { bold = true })
-- update_hl("@keyword", { italic = true })
-- update_hl("@function.builtin", { bold = true })
-- update_hl("Keyword", { bold = true })
