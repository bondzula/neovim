local M = {}

local map = vim.keymap.set

-- On Attach function
M.on_attach = function(_, bufferNum)
  map("n", "gd", vim.lsp.buf.definition, { buffer = bufferNum, desc = "Go to Definition" })
  map("n", "gD", vim.lsp.buf.declaration, { buffer = bufferNum, desc = "Go to Declaration" })
  map("n", "gT", vim.lsp.buf.type_definition, { buffer = bufferNum, desc = "Go to Type Definition" })
  map("n", "gi", vim.lsp.buf.implementation, { buffer = bufferNum, desc = "Go to Implementation" })

  map("n", "<leader>cf", vim.lsp.buf.format, { buffer = bufferNum, desc = "Format Document" })

  -- Rename
  map("n", "gr", "<cmd>Lspsaga rename<cr>", { buffer = bufferNum, desc = "Rename" })
  map("n", "gR", "<cmd>Lspsaga rename ++project<cr>", { buffer = bufferNum, desc = "Rename in Project" })

  -- Help
  map("n", "K", "<cmd>Lspsaga hover_doc<cr>", { buffer = bufferNum, desc = "Show Help" })

  -- Diagnostics
  map("n", "ga", "<cmd>Lspsaga code_action<cr>", { buffer = bufferNum, desc = "Show Code Actions" })
  map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { buffer = bufferNum, desc = "Go to Next Error" })
  map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { buffer = bufferNum, desc = "Go to Prev Error" })

  -- Code
  map("n", "<leader>cp", "<cmd>Lspsaga peek_definition<cr>", { buffer = bufferNum, desc = "Peek Definition" })
  map("n", "<leader>co", "<cmd>Lspsaga outline<cr>", { buffer = bufferNum, desc = "Open Outline" })
  map("n", "<leader>cF", "<cmd>Lspsaga lsp_finder<CR>", { buffer = bufferNum, desc = "LSP Finder" })
  map("n", "<leader>cr", "<cmd>Telescope lsp_references<cr>", { buffer = bufferNum, desc = "Show References" })
  map("n", "<leader>cs", "<cmd>Telescope lsp_document_symbols<cr>", { buffer = bufferNum, desc = "Show Document Symbols" })
  map("n", "<leader>cS", "<cmd>Telescope lsp_workspace_symbols<cr>", { buffer = bufferNum, desc = "Show Workspace Symbols" })

  -- Trouble
  map("n", "<leader>cd", "<cmd>Trouble document_diagnostics<cr>", { buffer = bufferNum, desc = "Open Document Diagnostics" })
  map("n", "<leader>cD", "<cmd>Trouble workspace_diagnostics<cr>", { buffer = bufferNum, desc = "Open Workspace Diagnostics" })

  -- General tools
  map("n", "<leader>cm", "<cmd>Mason<cr>", { buffer = bufferNum, desc = "Mason" })
  map("n", "<leader>cl", "<cmd>LspInfo<cr>", { buffer = bufferNum, desc = "Lsp Info" })
end

-- Setup server capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Try to load cmp
local cmp_status, cmp = pcall(require, "cmp_nvim_lsp")

-- if we have cmp, set capabilities to cmp capabilities
if cmp_status then
  capabilities = cmp.default_capabilities(capabilities)
end

-- pretty fold with UFO plugin
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

-- Enable snippets
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = capabilities
return M
