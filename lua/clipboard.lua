M = {}

M.get_clipboard_content = function()
	local handle = io.popen("pbpaste")
	local result = handle:read("*a")
	print("Copied value is : ", result)
	handle:close()
	return result
end

return M
