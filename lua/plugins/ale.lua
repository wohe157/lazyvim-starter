return {
  "dense-analysis/ale",
  lazy = false,
  config = function()
    vim.filetype.add({
      filename = {
        ["CHANGELOG.md"] = "changelogmd",
      },
    })

    vim.filetype.add({
      filename = {
        ["README.md"] = "readmemd",
      },
    })

    vim.cmd([[
    function! OcdcFormat(buffer) abort
      return {'command': 'ocdc --path -'}
    endfunction
    ]])

    vim.cmd([[
    function! MdformatFix(buffer) abort
      return {'command': 'mdformat - --number --wrap=90'}
    endfunction
    ]])

    vim.fn["ale#fix#registry#Add"]("ocdc", "OcdcFormat", { "changelogmd" }, "ocdc")
    vim.fn["ale#fix#registry#Add"]("mdformat", "MdformatFix", { "readmemd" }, "mdformat")

    vim.g.ale_use_neovim_diagnostics_api = 1
    vim.g.ale_disable_lsp = 1
    vim.g.ale_fix_on_save = 1

    vim.g.ale_linters = {
      python = { "mypy", "flake8" },
      sh = {},
      yaml = {},
    }
    vim.g.ale_fixers = {
      python = { "isort", "black" },
      -- python = { "ruff" },
      html = { "prettier" },
      lua = { "stylua" },
      json = { "prettier" },
      sql = { "sqlfluff" },
      readmemd = { "mdformat" },
      changelogmd = { "ocdc" },
      ["*"] = { "remove_trailing_lines", "trim_whitespace" },
    }
    vim.g.ale_python_black_options = "--preview --enable-unstable-feature string_processing"
  end,
}
