return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "j-hui/fidget.nvim",
      tag = "legacy",
      event = "LspAttach",
      opts = {
        text = {
          spinner = "arc",
        },
      },
    },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = true

      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end
    end

    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = {
        "bashls",
        "yamlls",
        "lua_ls",
        "jedi_language_server",
      },
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        jedi_language_server = function()
          lspconfig.jedi_language_server.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            init_options = {
              diagnostics = {
                enable = false,
              },
              workspace = {
                extraPaths = {
                  ".venv/lib/python3.9/site-packages",
                  ".venv/lib/python3.10/site-packages",
                  ".venv/lib/python3.11/site-packages",
                  ".venv/lib/python3.12/site-packages",
                  ".venv/lib/python3.13/site-packages",
                },
              },
            },
          })
        end,
        lua_ls = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                  enable = false,
                },
              },
            },
          })
        end,
        yamlls = function()
          lspconfig.yamlls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              yaml = {
                customTags = {
                  "!env mapping",
                  "!client mapping",
                },
              },
            },
          })
        end,
      },
    })
  end,
}
