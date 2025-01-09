return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "none",
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<Tab>"] = { "accept", "select_and_accept", "fallback" },
    },
  },
}
