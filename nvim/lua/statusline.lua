-- Statusline (lua rewrite)

local function git_statusline()
  local branch = vim.fn.FugitiveHead(12)
  if branch == '' then return '' end
  return '%#PmenuSel#  ' .. branch .. ' %*'
end

local function devicon()
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if not ok then return '' end
  local filename = vim.fn.expand('%:t')
  local ext = vim.fn.expand('%:e')
  local icon = devicons.get_icon(filename, ext)
  if icon then return icon .. ' ' end
  return ''
end

local function pywhere_statusline()
  if vim.bo.filetype ~= 'python' then return '' end
  local ok, loc = pcall(vim.fn['s:pythonsense_get_python_location'])
  if not ok or loc == '' or loc == nil then return '' end
  loc = loc:gsub('%(def:%)', ' ')
  loc = loc:gsub('%(class:%)', ' ')
  return '%#StatusPywhere# ' .. loc .. '() %*'
end

function _G.statusline()
  local parts = {}
  table.insert(parts, '%#PmenuSel#%h%w%*')
  table.insert(parts, '%#WarningMsg#%m%*')
  table.insert(parts, '%#ErrorMsg#%r%*')
  table.insert(parts, git_statusline())
  table.insert(parts, ' %#StatusFilename#' .. devicon() .. '%f%* %<')
  table.insert(parts, pywhere_statusline())
  table.insert(parts, '%=')
  table.insert(parts, '  ' .. vim.bo.filetype)
  table.insert(parts, '  %P')
  table.insert(parts, '  %l%L:%c ')
  return table.concat(parts)
end

vim.opt.statusline = '%!v:lua.statusline()'
