local create_command = vim.api.nvim_create_user_command

local terminal = require("toggleterm.terminal").Terminal
create_command("MesonCompile", function()
	terminal
		:new({
			cmd = "meson compile -C builddir",
            direction = "horizontal",
            close_on_exit = false,
            auto_scroll = true
		})
		:toggle()
end, { nargs = "*" })
