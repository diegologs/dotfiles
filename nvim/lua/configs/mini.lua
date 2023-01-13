local M = {}

function M.config()
    require("mini.statusline").setup({})
    require("mini.tabline").setup({})
    require("mini.comment").setup({})
    require("mini.jump2d").setup({})

end

function M.setup() end

return M
