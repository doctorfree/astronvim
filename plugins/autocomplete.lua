return {
  {
    "axelvc/template-string.nvim",
    lazy = false,
    opts = {
      jsx_brackets = true,
      remove_template_strings = true,
      restore_quotes = {
        normal = [["]],
        jsx = [["]],
      },
    },
  },
  { "marilari88/twoslash-queries.nvim" },
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require("plugins.configs.luasnip")(plugin, opts)
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "./lua/user/snippets" } }
    end,
  },
  {
    'David-Kunz/cmp-npm',
    ft = "json",
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
}
