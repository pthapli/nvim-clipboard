local clipboard = require("clipboard")
print("Hello from nvim-clipboard.lua")

function open_list()
	-- Create a new empty buffer
	local buf = vim.api.nvim_create_buf(false, true)

	-- vim.api.nvim_buf_set_name(buf, "clipboard")

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
	clipboard.get_clipboard_content()
end

vim.api.nvim_set_keymap("n", "<leader>b", ":lua open_list()<CR>", { noremap = true, silent = true })

-- local vim = vim
-- local last_clipboard_value = nil
--
-- local function check_clipboard()
-- 	local current_clipboard_value = vim.fn.getreg("+")
-- 	print("current_clipboard_value: ", current_clipboard_value)
--
-- 	if current_clipboard_value ~= last_clipboard_value then
-- 		print("Clipboard value has changed.")
-- 		last_clipboard_value = current_clipboard_value
-- 		print("last_clipboard_value: ", last_clipboard_value)
-- 	end
-- end
--
-- local timer = vim.loop.new_timer()
-- timer:start(5000, 5000, vim.schedule_wrap(check_clipboard))

local vim = vim

-- Define a function to monitor clipboard changes
-- local function monitor_clipboard()
-- 	local clipboard_text = vim.fn.getreg("*") -- Get the content of the system clipboard
-- 	local clipboard_text_1 = vim.fn.getreg("+") -- Get the content of the system clipboard
-- 	-- vim.api.nvim_out_write("Clipboard changed 1: " .. clipboard_text .. "\n") -- Log the change to the screen
-- 	vim.api.nvim_out_write("Clipboard changed 2: " .. clipboard_text_1 .. "\n") -- Log the change to the screen
-- end

function Monitor_clipboard()
	local clipboard_text = vim.fn.getreg("*") -- Get the content of the system clipboard
	local clipboard_text_1 = vim.fn.getreg("+") -- Get the content of the system clipboard

	if clipboard_text ~= nil then
		vim.api.nvim_out_write("Clipboard changed 1: " .. clipboard_text .. "\n")
	end

	if clipboard_text_1 ~= nil then
		vim.api.nvim_out_write("Clipboard changed 2: " .. clipboard_text_1 .. "\n")
	end
	-- vim.api.nvim_out_write("Clipboard changed 1: " .. clipboard_text .. "\n") -- Log the change to the screen
	-- vim.api.nvim_out_write("Clipboard changed 2: " .. clipboard_text_1 .. "\n") -- Log the change to the screen
end

-- Set up an autocmd to trigger the monitor_clipboard function when the clipboard changes
-- vim.cmd([[
--     augroup ClipboardMonitor
--         autocmd!
--         autocmd TextYankPost * lua monitor_clipboard()
--     augroup END
-- ]])

vim.cmd([[
    augroup ClipboardMonitor
        autocmd!
        autocmd TextYankPost * lua Monitor_clipboard()
    augroup END
]])

-- Provide a command to manually trigger the clipboard monitoring
vim.cmd("command! MonitorClipboard lua monitor_clipboard()")

vim.api.nvim_out_write("Clipboard monitoring plugin loaded.\n")
