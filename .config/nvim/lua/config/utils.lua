local M = {}

---@param repo string GitHub repository in `owner/name` form
---@return string
function M.gh(repo)
  return 'https://github.com/' .. repo
end

return M
