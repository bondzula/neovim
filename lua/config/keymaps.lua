-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function new_scratch()
  --[[
    [Parameters:
    [{listed} Sets 'buflisted'
    [{scratch} Creates a "throwaway" scratch-buffer for temporary work (always
    ['nomodified'). Also sets 'nomodeline' on the buffer.
    ]]

  -- Create a buffer
  local buffer = vim.api.nvim_create_buf(true, true)

  -- Change to new buffer
  vim.api.nvim_set_current_buf(buffer)

  -- Set the buffer to be scratch
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buffer })
  vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buffer })
  vim.api.nvim_set_option_value("swapfile", false, { buf = buffer })

  -- Set the buffer name
  vim.api.nvim_buf_set_name(buffer, "Scratch")
end

vim.keymap.set("n", "<leader>fs", new_scratch, { desc = "Open a Scratch Buffer" })
