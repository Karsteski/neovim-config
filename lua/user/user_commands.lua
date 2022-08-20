local create_command = vim.api.nvim_create_user_command

local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

local terminal = toggleterm.Terminal

create_command("MesonCompile", function()
	terminal
		:new({
			direction = "horizontal",
			auto_scroll = true,
			close_on_exit = false,
			cmd = "meson compile -C builddir",
		})
		:toggle()
end, {})

create_command("Lazygit", function()
	terminal
		:new({
			direction = "float",
			auto_scroll = true,
			close_on_exit = true,
			cmd = "lazygit",
		})
		:toggle()
end, {})
