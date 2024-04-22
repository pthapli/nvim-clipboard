-- M = {}
-- local vim = vim

-- -- Define a function to monitor clipboard changes
-- M.monitor_clipboard = function()
-- 	local clipboard_text = vim.fn.getreg("*") -- Get the content of the system clipboard
-- 	vim.api.nvim_out_write("Clipboard changed: " .. clipboard_text .. "\n") -- Log the change to the screen

-- 	local clipboard_text_1 = vim.fn.getreg("+") -- Get the content of the system clipboard
-- 	vim.api.nvim_out_write("Clipboard changed 1: " .. clipboard_text_1 .. "\n") -- Log the change to the screen
-- end

-- -- Set up an autocmd to trigger the monitor_clipboard function when the clipboard changes
-- vim.cmd([[
--     augroup ClipboardMonitor
--         autocmd!
--         autocmd TextYankPost * lua require'nvim-clipboard'.monitor_clipboard()
--     augroup END
-- ]])

-- vim.api.nvim_out_write("Clipboard monitoring plugin loaded.\n")

-- M.Mister = function()
-- 	print("MISTER PT")
-- end

-- vim.api.nvim_out_write("Clipboard monitoring plugin loaded.\n")

-- return M

M = {}
local vim = vim
local last_clipboard_content = "" -- Variable to store the last clipboard content

-- Define a function to monitor clipboard changes
M.monitor_clipboard = function()
	local clipboard_text = vim.fn.getreg("+") -- Get the content of the system clipboard
	if clipboard_text ~= last_clipboard_content then -- If the clipboard content has changed
		vim.api.nvim_out_write("Clipboard changed: " .. clipboard_text .. "\n") -- Log the change to the screen
		last_clipboard_content = clipboard_text -- Update the last clipboard content
	end
end
-- Set up a timer to periodically check the system clipboard
local timer = vim.loop.new_timer()
timer:start(1000, 1000, vim.schedule_wrap(M.monitor_clipboard)) -- Check every 1000 milliseconds (1 second)

vim.api.nvim_out_write("Clipboard monitoring plugin loaded.\n")

return M
