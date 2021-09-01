local present, bufferline = pcall(require, "bufferline")
if not present then
   return
end

bufferline.setup {
    options = {
       offsets = { { filetype = "NERDTree", text = "", padding = 1 } },
       max_name_length = 14,
       max_prefix_length = 13,
       tab_size = 20,
       show_tab_indicators = true,
       enforce_regular_tabs = false,
       view = "multiwindow",
       show_buffer_close_icons = true,
       separator_style = "thin",
       always_show_bufferline = true,
       diagnostics = false, -- "or nvim_lsp"
    }
}