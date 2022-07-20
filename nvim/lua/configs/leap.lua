local present, leap = pcall(require, "leap")
if not present then
   return
end

leap.set_default_keymaps()
