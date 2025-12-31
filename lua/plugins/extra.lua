return {
    'wakatime/vim-wakatime',
    {
        'vyfor/cord.nvim',
        build = ':Cord update',
        opts = {
            display = {
                theme = "classic",
                flavor = "accent",
            },
            assets = {
                ['.qml'] = {
                    icon = "https://i.imgur.com/cXHATlK.png",
                    tooltip = "Qt Meta Language",
                    text = function(opts)
                        return string.format('Editing %s', opts.filename)
                    end,
                }
            },
        }
    }
}
