require("config.options")

if vim.g.neovide then
    require 'config.neovide'
end

require("config.lazy")

require("config.commands")
