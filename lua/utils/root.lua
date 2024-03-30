local M = {}
function M.cwd()
  return M.realpath(vim.uv.cwd()) or ""
end

function M.realpath(path)
  if path == "" or path == nil then
    return nil
  end
  path = vim.uv.fs_realpath(path) or path
  return vim.fs.normalize(path)
end

return M
