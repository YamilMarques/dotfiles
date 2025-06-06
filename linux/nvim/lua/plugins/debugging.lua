return {
	--Debugger Adapter Protocol
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		require("dapui").setup()

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

		vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<Leader>dc", dap.continue, {})

		dap.adapters.lldb = {
			type = "executable",
			command = "/usr/bin/lldb-dap", -- adjust as needed, must be absolute path
			name = "lldb",
		}

		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}
		-- 	dap.adapters.gdb = {
		-- 		type = "executable",
		-- 		command = "gdb",
		-- 		args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
		-- 	}
		--
		-- 	dap.configurations.c = {
		-- 		{
		-- 			name = "Launch",
		-- 			type = "gdb",
		-- 			request = "launch",
		-- 			program = function()
		-- 				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- 			end,
		-- 			cwd = "${workspaceFolder}",
		-- 			stopAtBeginningOfMainSubprogram = false,
		-- 		},
		-- 		{
		-- 			name = "Select and attach to process",
		-- 			type = "gdb",
		-- 			request = "attach",
		-- 			program = function()
		-- 				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- 			end,
		-- 			pid = function()
		-- 				local name = vim.fn.input("Executable name (filter): ")
		-- 				return require("dap.utils").pick_process({ filter = name })
		-- 			end,
		-- 			cwd = "${workspaceFolder}",
		-- 		},
		-- 		{
		-- 			name = "Attach to gdbserver :1234",
		-- 			type = "gdb",
		-- 			request = "attach",
		-- 			target = "localhost:1234",
		-- 			program = function()
		-- 				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- 			end,
		-- 			cwd = "${workspaceFolder}",
		-- 		},
		-- 	}
	end,
}
