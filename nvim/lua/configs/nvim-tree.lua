local present, nvimtree = pcall(require, "nvim-tree")
if not present then
   return
end

require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = true,
        git = false,
      },
      glyphs = {
        folder = {
          arrow_closed = "›",
          arrow_open = "⌃",
        }
      }
    }
  }
})
