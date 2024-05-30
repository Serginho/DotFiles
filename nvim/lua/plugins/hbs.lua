return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "html" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      -- Use HTML parser for .hbs files
      matchup = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- Associate .hbs files with HTML syntax highlighting
      vim.filetype.add({
        extension = {
          hbs = "html",
        },
      })
    end,
  },
}
