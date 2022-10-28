require('slowly').setup({
    disabled_builtins = {
        'netrw',
	'netrwPlugin',
	'netrwSettings',
	'netrwFileHandlers'
    },
    plugins = {
        {url = 'https://github.com/nvim-lua/plenary.nvim',    start = true},
	{url = 'https://github.com/elihunter173/dirbuf.nvim', start = true},
	{url = 'https://github.com/neovim/nvim-lspconfig',    start = true},
	{url = 'https://github.com/Mofiqul/vscode.nvim',      start = true}
    }
})

require('dirbuf').setup {
    show_hidden = false,
    sort_order  = 'directories_first',
    write_cmd   = 'DirbufSync -confirm'
}

local c = require('vscode.colors')
require('vscode').setup({
    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua
    color_overrides = {
        vscLineNumber = '#FFFFFF',
    },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
	-- use colors from this colorscheme by requiring vscode.colors!
	Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true }
    }
})
