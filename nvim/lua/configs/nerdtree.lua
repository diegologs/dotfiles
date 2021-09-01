local present, nerdtree = pcall(require, "nerdtree")
if not present then
   return
end

vim.g.NERDTreeWinSize=40