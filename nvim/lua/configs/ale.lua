vim.cmd([[
  let g:ale_fix_on_save = 1
  let g:ale_linters = {
  \   'javascript': ['prettier'],
  \   'html': ['prettier'],
  \   'liquid': ['prettier'],
  \   'css': ['prettier'],
  \   'svelte': ['eslint', 'stylelint', 'prettier'],
  \   'vue': ['eslint', 'stylelint', 'vls'],
  \   'vuejs': ['eslint', 'stylelint', 'vls'],
  \}
  let g:ale_fixers = {
  \   'javascript': ['prettier'],
  \   'html': ['prettier'],
  \   'liquid': ['prettier'],
  \   'css': ['prettier'],
  \   'svelte': ['prettier'],
  \   'vue': ['prettier'],
  \   'vuejs': ['prettier'],
  \}
]])
