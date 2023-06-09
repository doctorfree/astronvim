return {
  {
    "github/copilot.vim",
    lazy = false,
    keys = {
      {
        "<M-Tab>",
        'copilot#Accept("")',
        replace_keycodes = false,
        expr = true,
        desc = "Accept Copilot suggestion",
        mode = "i",
      },
      { "<M-\\>", "<M-S>", desc = "Force Copilot suggestion", mode = "i" },
    },
  },
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
  { "hrsh7th/cmp-nvim-lua" },
  {
    'David-Kunz/cmp-npm',
    ft = "json",
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.sources = cmp.config.sources({
        { name = "nvim_lua", priority = 1250 },
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750 },
        { name = "neorg",    priority = 700 },
        { name = 'npm',      priority = 600 },
        { name = "buffer",   priority = 500, keyword_length = 5, max_item_count = 5 },
        { name = "path",     priority = 250 },
      })
      opts.duplicates.npm = 1

      opts.mapping["<CR>"] = cmp.mapping.confirm({ select = true })
      opts.mapping["<C-m>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.close()
        else
          cmp.complete()
        end
      end, { "i" })

      opts.formatting.fields = { "kind", "abbr", "menu" }
      opts.formatting.format = function(entry, vim_item)
        local kind = require("lspkind").cmp_format(astronvim.lspkind)(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. (strings[1] or "")
        kind.menu = (strings[2] or "") .. " " .. kind.menu

        return kind
      end

      opts.window = {
        completion = {
          col_offset = -3,
          side_padding = 0,
        },
      }

      return opts
    end,
  }
}
