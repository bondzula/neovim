return {
	-- measure startuptime
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},

	-- session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't Save Current Session",
			},
		},
	},

	-- library used by other plugins
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},

	-- makes some plugins dot-repeatable like leap
	{
		"tpope/vim-repeat",
		event = "VeryLazy",
	},

	-- Tmux integration
	{
		"numToStr/Navigator.nvim",
		keys = {
			{ "<C-h>", "<cmd>NavigatorLeft<cr>" },
			{ "<C-l>", "<cmd>NavigatorRight<cr>" },
			{ "<C-k>", "<cmd>NavigatorUp<cr>" },
			{ "<C-j>", "<cmd>NavigatorDown<cr>" },
		},
		config = function()
			require("Navigator").setup({})
		end,
	},

	-- Task runner
	{
		"stevearc/overseer.nvim",
		keys = {
			{ "<leader>tt", "<cmd>OverseerToggle[!] right<cr>", desc = "Toggle Task View" },
			{ "<leader>tr", "<cmd>OverseerRun<cr>", desc = "Run a task" },
			{ "<leader>tR", "<cmd>OverseerRunCmd<cr>", desc = "Run a custom task" },
			{ "<leader>ta", "<cmd>OverseerTaskAction<cr>", desc = "Task Actions" },
		},
		config = function()
			require("overseer").setup()

			-- TODO: move into a utility file
			require("overseer").register_template({
				name = "Laravel Artisan Serve",
				params = {},
				condition = {
					callback = function()
						return not vim.tbl_isempty(vim.fs.find("artisan"))
					end,
				},
				builder = function()
					return {
						cmd = { "php" },
						args = { "artisan", "serve" },
					}
				end,
			})
		end,
	},

	-- Snippet runner
	{
		"michaelb/sniprun",
		build = "bash install.sh",
		cmd = "Sniprun",
		config = function()
			require("sniprun").setup({
				selected_interpreters = { "JS_TS_deno" },
				repl_enable = { "JS_TS_deno" },
			})
		end,
	},
}
