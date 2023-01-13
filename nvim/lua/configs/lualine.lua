local present, _ = pcall(require, "lualine")
if not present then
  return
end

require("lualine").setup {
  options = {
    -- theme = "tokyonight",
    theme = "embark"
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "filename" },
    lualine_c = { "g:coc_status" },
    lualine_x = { "branch" },
    lualine_y = { "encoding" },
    lualine_z = { "location" }
  }
}
