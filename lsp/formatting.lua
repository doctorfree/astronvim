return {
  format_on_save = false,
  filter = function(client)
    if client.name == "lua_ls" then
      return true
    end
    return client.name == "null-ls"
  end
}
