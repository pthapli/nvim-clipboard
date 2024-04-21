print("Hello from nvim-clipboard.lua")

function open_list()
	-- Create a new empty buffer
	local buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_buf_set_name(buf, "clipboard")

	-- Add some lines to the buffer
	vim.api.nvim_buf_set_lines(
		buf,
		0,
		-1,
		false,
		{ "Item 1 from clipboard", "Item 2 from clipboard", "Item 3 from clipboard" }
	)

	-- Open the buffer in a new window
	vim.api.nvim_open_win(buf, true, { relative = "editor", width = 30, height = 10, col = 10, row = 10 })
end

vim.api.nvim_set_keymap("n", "<leader>b", ":lua open_list()<CR>", { noremap = true, silent = true })
