return {
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp' },
  cmd = { "clangd", "--offset-encoding=utf-16" },
}
