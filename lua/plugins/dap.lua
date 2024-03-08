return {
	{
		"mfussenegger/nvim-dap",
        lazy =true,
		config = function()
			local dap = require("dap")
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<leader>c", dap.continue, {})
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
        lazy = true,
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
}
