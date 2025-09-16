-- Test Lua file to check LSP functionality
local function test_function()
  print("Hello, world!")
  
  -- This should trigger LSP diagnostics and completions
  local my_table = {
    key1 = "value1",
    key2 = "value2"
  }
  
  -- Test vim global (should be recognized by lua_ls)
  vim.cmd("echo 'Testing vim global'")
  
  return my_table
end

-- Call the function
test_function()
