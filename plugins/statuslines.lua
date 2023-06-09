return {
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require("astronvim.utils.status")

      opts.statusline = {
        hl = { fg = "fg", bg = "bg" },
        status.component.mode({ mode_text = { padding = { left = 1, right = 1 } } }),
        status.component.git_branch(),
        status.component.file_info({ filetype = {}, filename = false, file_modified = false }),
        status.component.git_diff(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.diagnostics({ padding = { right = 0 }, surround = { separator = "none" } }),
        -- LSP
        status.component.builder(
          status.utils.setup_providers(
            {
              lsp_client_names = {
                str = " ",
                update = { "LspAttach", "LspDetach", "BufEnter" },
                icon = { kind = "ActiveLSP", padding = { right = 0 } },
              },
              hl = status.hl.get_attributes "lsp",
              surround = { separator = "right", color = "lsp_bg", condition = status.condition.lsp_attached },
              on_click = {
                name = "heirline_lsp",
                callback = function()
                  vim.defer_fn(function() vim.cmd.LspInfo() end, 100)
                end,
              },
            },
            { "lsp_client_names" },
            function(p_opts)
              return {
                flexible = 1,
                status.utils.build_provider(p_opts, status.provider.str(p_opts)),
              }
            end
          )
        ),
        status.component.treesitter(),
        status.component.nav(),
      }

      opts.winbar = {
        -- create custom winbar
        -- store the current buffer number
        init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
        fallthrough = false, -- pick the correct winbar based on condition
        -- inactive winbar
        {
          condition = function() return not status.condition.is_active() end,
          -- add the file name and icon
          status.component.file_info {
            file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
            file_modified = false,
            file_read_only = false,
            hl = status.hl.get_attributes("winbarnc", true),
            surround = false,
            update = "BufEnter",
          },
          -- show the breadcrumbs
          status.component.breadcrumbs {
            icon = { hl = true },
            hl = status.hl.get_attributes("winbar", true),
            prefix = true,
            padding = { left = 0 },
          },
        },
        -- active winbar
        {
          -- add the file name and icon
          status.component.file_info { -- add file_info to breadcrumbs
            file_icon = { hl = status.hl.filetype_color, padding = { left = 0 } },
            file_modified = false,
            file_read_only = false,
            hl = status.hl.get_attributes("winbar", true),
            surround = false,
            update = "BufEnter",
          },
          -- show the breadcrumbs
          status.component.breadcrumbs {
            icon = { hl = true },
            hl = status.hl.get_attributes("winbar", true),
            prefix = true,
            padding = { left = 0 },
          },
        },
      }

      return opts
    end
  }
}
