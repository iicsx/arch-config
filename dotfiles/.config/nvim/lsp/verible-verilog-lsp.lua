return {
  cmd = { "verible-verilog-ls", "--rules_config_search" },
  filetypes = { "systemverilog", "verilog" },
  root_markers = {
    ".git",
    ".rules.verible_lint",
    "verilator.f",
  }
}
