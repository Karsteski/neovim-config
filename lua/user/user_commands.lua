local create_command = vim.api.nvim_create_user_command

local terminal = require("toggleterm.terminal").Terminal

create_command("MesonCompile", function()
	terminal
		:new({
			direction = "horizontal",
			auto_scroll = true,
			close_on_exit = false,
			cmd = "meson compile -C builddir",
		})
		:toggle()
end, { })

create_command("Lazygit", function()
	terminal
		:new({
			direction = "float",
			auto_scroll = true,
			close_on_exit = true,
			cmd = "lazygit",
		})
		:toggle()
end, { })
