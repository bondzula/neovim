return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local function get_file_name()
        return vim.api.nvim_buf_get_name(0)
      end

      require('lint').linters.deadnix = {
        name = 'deadnix',
        cmd = 'deadnix',
        stdin = true,
        args = { '-o', 'json', get_file_name },
        ignore_exitcode = true,
        parser = function(output, bufnr)
          if output == '' then
            return {}
          end
          local decoded = vim.json.decode(output)
          if decoded == nil then
            return {}
          end
          local diagnostics = {}
          local current_file = vim.api.nvim_buf_get_name(bufnr)

          if current_file == decoded.file then
            for _, item in ipairs(decoded.results) do
              table.insert(diagnostics, {
                lnum = item.line - 1,
                end_lnum = item.line - 1,
                col = item.column - 1,
                end_col = item.endColumn,
                severity = vim.diagnostic.severity.WARN,
                source = 'deadnix',
                message = item.message,
              })
            end
          end

          return diagnostics
        end,
      }

      require('lint').linters.ltrs = {
        name = 'ltrs',
        cmd = 'ltrs',
        stdin = true,
        args = { 'check', '-m', '-r', get_file_name },
        ignore_exitcode = true,
        parser = function(output, bufnr)
          if output == '' then
            return {}
          end
          local decoded = vim.json.decode(output)
          if decoded == nil then
            return {}
          end
          local diagnostics = {}
          vim.notify(output)

          for _, item in ipairs(decoded.matches) do
            table.insert(diagnostics, {
              lnum = item.moreContext.line_number - 1,
              end_lnum = item.moreContext.line_number - 1,
              col = item.moreContext.line_offset,
              end_col = item.moreContext.line_offset + item.context.length,
              severity = vim.diagnostic.severity.WARN,
              source = 'ltrs',
              message = item.rule.description,
            })
          end

          return diagnostics
        end,
      }

      require('lint').linters_by_ft = {
        javascript = { "eslint_d", },
        json = { "jsonlint", },
        markdown = { 'ltrs', },
        go = { "cspell", },
        nix = { "statix", "deadnix", },
        php = { "phpstan", },
        tsx = { "eslintd", },
        typescript = { "eslint_d", },
        typescriptreact = { "eslint_d", },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })

      vim.api.nvim_create_autocmd({ "BufReadPost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  }
}
