return {
  { "folke/tokyonight.nvim" },
  { "rakr/vim-one" },
  { "catppuccin/nvim",      as = "catppuccin" },
  {
    "sainnhe/sonokai",
    init = function()
      vim.g.sonokai_style = "andromeda"
    end
  },
  { "kvrohit/mellow.nvim" },
  {
    "sainnhe/edge",
    init = function()
      vim.g.edge_style = "neon"
      vim.g.edge_dim_inactive_windows = 1
      vim.g.edge_diagnostic_virtual_text = "colored"
      vim.g.edge_diagnostic_line_highlight = "colored"
    end
  },
  { "projekt0n/github-nvim-theme", lazy = false }
}
