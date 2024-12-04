local M = {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
        return
      end
    end
    
    local library = {}

    if vim.fn.stdpath('config') == require('util.root').cwd() then
      library = {
        vim.env.VIMRUNTIME,
        "${3rd}/luv/library",
        "${3rd}/busted/library",
        vim.fn.stdpath('data') .. '/lazy',
      }
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = library
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

return M
