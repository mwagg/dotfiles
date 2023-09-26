return {
  "ThePrimeagen/harpoon",
  keys = {
    {
      "<C-m>",
      function()
        require("harpoon.ui").nav_next()
      end,
      desc = "Navigate to next mark",
    },
    {
      "<leader>ma",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Mark file",
    },
    {
      "<leader>mm",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Togle harpoon menu",
    },
  },
}
