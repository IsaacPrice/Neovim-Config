-- Include External Files
require("options")

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazyloading and stuff
require("lazy").setup({
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" } },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip" } },
})

-- Set color scheme
require("tokyonight").setup({ transparent = true })
vim.cmd.colorscheme("tokyonight-night")
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#111119" })

require("nvim-treesitter.configs").setup {
  ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query" },
  highlight = { enable = true },
}

require("lspconfig").clangd.setup{}

local cmp = require("cmp")
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert(),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  })
}

-- Configure File Searching
local actions = require("telescope.actions")
require("telescope").setup{
	defaults = {
		mappings = {
			i = {
        		["<esc>"] = actions.close,   
      		},
      		n = {
        		["<esc>"] = actions.close,   
        		["q"] = actions.close,  
      		},
		}
	},
  	extensions = {
    	file_browser = {
      		theme = "ivy",
      		hijack_netrw = true,
      		-- optional: add/override mappings
    	},
  	},
}
require("telescope").load_extension("file_browser")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<CR>")

