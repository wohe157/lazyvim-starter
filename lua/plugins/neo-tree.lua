return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    default_component_configs = {
      symlink_target = { enabled = false },
    },
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
    window = {
      position = "current",
    },
  },
}
