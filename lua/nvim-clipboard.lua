M = {}
M.clipboard_history = {}

local vim = vim
local last_clipboard_content = "" -- Variable to store the last clipboard content

-- clear items of extra newline elements causing error
local function remove_newlines(str_table)
	local result = {}
	for i, str in ipairs(str_table) do
		result[i] = str:gsub("\n", "")
	end
	return result
end

function M.show_list(items)
	-- Create a new buffer
	local buf = vim.api.nvim_create_buf(false, true)

	-- Populate the buffer
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, remove_newlines(items))

	local current_win = vim.api.nvim_get_current_win()
	local win_width = vim.api.nvim_win_get_width(current_win)
	local win_height = vim.api.nvim_win_get_height(current_win)

	local new_win_width = 80 -- Adjust as needed
	local new_win_height = 20 -- Adjust as needed

	local row = math.floor(win_height / 2 - new_win_height / 2)
	local col = math.floor(win_width / 2 - new_win_width / 2)

	local options = {
		relative = "win",
		width = new_win_width,
		height = new_win_height,
		row = row,
		col = col,
		border = "single",
	}

	local win = vim.api.nvim_open_win(buf, true, options)

	-- Set up keymaps for navigation and selection
	vim.keymap.set("n", "<up>", function()
		vim.cmd("norm k")
	end, { buffer = buf })
	vim.keymap.set("n", "<down>", function()
		vim.cmd("norm j")
	end, { buffer = buf })
	vim.keymap.set("n", "<esc>", function()
		vim.cmd("close")
	end, { buffer = buf })

	vim.keymap.set("n", "<CR>", function()
		local selected_item = vim.api.nvim_buf_get_lines(
			buf,
			vim.api.nvim_win_get_cursor(win)[1] - 1,
			vim.api.nvim_win_get_cursor(win)[1] + 1,
			false
		)[1]
		-- move selected_item to + register
		vim.fn.setreg("+", selected_item)
		vim.fn.setreg("*", selected_item)
		vim.cmd("close")
	end, { buffer = buf })
end

local function write_to_file(text)
	local file = io.open("clipboard.txt", "a")
	if file ~= nil then
		file:write("\n" .. text)
		file:close()
	else
		print("File is nil")
	end
end

function M.read_from_file()
	local file = io.open("clipboard.txt", "r")
	if file ~= nil then
		for line in file:lines() do
			table.insert(M.clipboard_history, line)
		end
		file:close()
		return M.clipboard_history
	else
		print("File is nil")
	end
end

-- setup mapping for clipboard buffer to be opened
vim.keymap.set("n", "<leader>b", function()
	local list = M.read_from_file()
	require("nvim-clipboard").show_list(list)
	-- require("nvim-clipboard").show_list(M.clipboard_history)
end)
-- Define a function to monitor clipboard changes
M.monitor_clipboard = function()
	local clipboard_text = vim.fn.getreg("+") -- Get the content of the system clipboard
	if clipboard_text ~= last_clipboard_content then -- If the clipboard content has changed
		table.insert(M.clipboard_history, clipboard_text)
		write_to_file(clipboard_text)
		vim.api.nvim_out_write("Clipboard changed bero: " .. clipboard_text .. "\n") -- Log the change to the screen
		last_clipboard_content = clipboard_text -- Update the last clipboard content
	end
end
-- Set up a timer to periodically check the system clipboard
local timer = vim.loop.new_timer()
timer:start(1000, 1000, vim.schedule_wrap(M.monitor_clipboard)) -- Check every 1000 milliseconds (1 second)

vim.api.nvim_out_write("Clipboard monitoring plugin loaded.\n")

return M
