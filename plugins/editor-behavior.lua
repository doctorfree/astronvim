return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>ue", "<cmd>Neotree toggle action=show<cr>", desc = "Toggle Explorer" },
      { "<leader>ud", "<cmd>Neotree diagnostics toggle<cr>", desc = "Toggle Diagnostics" },
    },
    opts = {
      window = { width = 40 },
      tabs_layout = "focus",
      sort_case_insensitive = true,
      sources = { "filesystem", "buffers", "git_status", "diagnostics" },
      source_selector = {
        show_scrolled_off_parent_node = true,
        sources = {
          { source = "filesystem" },
          { source = "buffers" },
          { source = "git_status" },
        },
      },
      diagnostics = {
        auto_preview = { enabled = true },
        window = { position = "bottom", height = 12 },
      },
      filesystem = {
        components = {
          harpoon_index = function(config, node)
            local Marked = require("harpoon.mark")
            local path = node:get_id()
            local succuss, index = pcall(Marked.get_index_of, path)
            if succuss and index and index > 0 then
              return {
                text = string.format(" ⥤ %d", index),
                highlight = config.highlight or "NeoTreeDirectoryIcon",
              }
            else
              return {}
            end
          end
        },
        renderers = {
          directory = {
            { "indent" },
            { "icon" },
            { "current_filter" },
            {
              "container",
              content = {
                { "name",        zindex = 10 },
                { "clipboard",   zindex = 10 },
                { "diagnostics", zindex = 20, align = "right", hide_when_expanded = true },
                { "git_status",  zindex = 20, align = "right", hide_when_expanded = true },
              },
            },
          },
          file = {
            { "indent" },
            { "icon" },
            {
              "container",
              content = {
                { "name",          zindex = 10, use_git_status_colors = true },
                { "clipboard",     zindex = 10 },
                { "bufnr",         zindex = 10 },
                { "harpoon_index", zindex = 10 },
                { "modified",      zindex = 20, align = "right" },
                { "diagnostics",   zindex = 20, align = "right" },
                { "git_status",    zindex = 20, align = "right" },
              },
            },
          }
        }
      },
      event_handlers = {
        -- TODO: Hide cursor when entering neotree
        { event = "neo_tree_buffer_enter",       handler = function() vim.cmd 'highlight! Cursor blend=100' end },
        { event = "neo_tree_buffer_leave",       handler = function() vim.cmd 'highlight! Cursor guibg=#5f87af blend=0' end },
        { event = "neo_tree_window_after_open",  handler = function() vim.cmd("wincmd =") end },
        { event = "neo_tree_window_after_close", handler = function() vim.cmd("wincmd =") end }
      },
    }
  },
  {
    "mrbjarksen/neo-tree-diagnostics.nvim",
    dependencies = "nvim-neo-tree/neo-tree.nvim",
  },
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      require("neoscroll").setup({ post_hook = function() vim.fn.feedkeys("M") end })
    end
  },
  { "mg979/vim-visual-multi", lazy = false },
  {
    "pocco81/auto-save.nvim",
    lazy = false,
    keys = {
      { "<leader>fa", ":ASToggle<CR>", desc = "Toggle auto-save" },
    },
    opts = {
      debounce_delay = 1000,
      execution_message = { message = function() return "" end }
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    opts = {
      mode = "topline",
    },
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>hh", "<cmd>Telescope harpoon marks<CR>",                       desc = "Toggle Harpoon" },
      { "<leader>uh", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle Harpoon" },
      { "<leader>ha", function() require("harpoon.mark").add_file() end,        desc = "Add file to Harpoon" },
      { "[h",         function() require("harpoon.ui").nav_prev() end,          desc = "Previous Harpoon file" },
      { "]h",         function() require("harpoon.ui").nav_next() end,          desc = "Next Harpoon file" },
      { "<leader>h1", function() require("harpoon.ui").nav_file(1) end,         desc = "Go to Harpoon file 1" },
      { "<leader>h2", function() require("harpoon.ui").nav_file(2) end,         desc = "Go to Harpoon file 2" },
      { "<leader>h3", function() require("harpoon.ui").nav_file(3) end,         desc = "Go to Harpoon file 3" },
      { "<leader>h4", function() require("harpoon.ui").nav_file(4) end,         desc = "Go to Harpoon file 4" },
      { "<leader>h5", function() require("harpoon.ui").nav_file(5) end,         desc = "Go to Harpoon file 5" },
    },
    config = function()
      require("telescope").load_extension("harpoon")
    end
  },
  {
    "s1n7ax/nvim-window-picker",
    opts = {
      show_prompt = false,
    }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        keys = {
          { "<leader>fs", function() require("nvim-navbuddy").open() end, desc = "Breadcrumb search" },
        },
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
      }
    },
  },
  {
    "nvim-neorg/neorg",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    lazy = false,
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {
          config = {
            icon_preset = "diamond"
          }
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          }
        },
        ["core.integrations.nvim-cmp"] = {},
      },
    },
  },
  {
    "Wansmer/treesj",
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      {
        "<leader>m",
        function() require("treesj").toggle() end,
        desc = "Split/join block",
      },
      {
        "<leader>M",
        function() require('treesj').toggle({ split = { recursive = true } }) end,
        desc = "Split/join block recursively",
      },
    },
  }
}
