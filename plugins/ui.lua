return {
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<leader>ut", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Toggle trouble" },
      { "<leader>fd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Toggle trouble for document" },
    },
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>", desc = "Toggle undotree" },
    },
  },
  {
    "j-hui/fidget.nvim",
    lazy = false,
    config = function() require("fidget").setup {} end,
  },
  {
    "anuvyklack/fold-preview.nvim",
    lazy = false,
    dependencies = "anuvyklack/keymap-amend.nvim",
    opts = {},
  },
  {
    "anuvyklack/pretty-fold.nvim",
    lazy = false,
    opts = {},
  },
  -- TODO: fix this plugin
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>sr",
        function() require("ssr").open() end,
        desc = "Structural search and replace",
        mode = { "n", "x" },
      },
    },
    opts = {},
  },
  {
    "LinArcX/telescope-command-palette.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>P", "<cmd>Telescope command_palette<CR>", desc = "Command palette" },
    },
    config = function() require("telescope").load_extension "command_palette" end,
  },
  {
    "rcarriga/nvim-notify",
    init = function() require("astronvim.utils").load_plugin_with_func("nvim-notify", vim, "notify") end,
    opts = {
      background_colour = "#000000",
      on_open = function(win) vim.api.nvim_win_set_config(win, { zindex = 1000 }) end,
    },
    config = function(_, opts)
      local notify = require "notify"
      notify.setup(opts)
      vim.notify = notify
    end,
  },
  {
    "folke/noice.nvim",
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        progress = { enabled = false },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = { enabled = false },
        hover = { enabled = false },
      },
      views = {
        cmdline_popup = {
          border = {
            style = "none",
            padding = { 1, 2 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
      presets = {
        -- bottom_search = false,     -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function(plugin, opts)
      if not opts.extensions then opts.extensions = {} end
      opts.extensions.command_palette = astronvim.user_opts("command_palette", {})
      require "plugins.configs.telescope"(plugin, opts)
    end,
  },
}
