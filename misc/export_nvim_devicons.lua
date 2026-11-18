local plugin_path = vim.fn.stdpath("data") .. "/lazy/nvim-web-devicons"
vim.opt.rtp:prepend(plugin_path)
vim.opt.rtp:prepend(vim.fn.stdpath("config"))

local devicons = require("nvim-web-devicons")
require("devicons").setup()

local function export_icons(icons)
  local exported = {}
  for key, icon in pairs(icons) do
    exported[key] = {
      glyph = icon.icon,
      color = icon.color,
    }
  end
  return exported
end

io.write(vim.json.encode({
  extensions = export_icons(devicons.get_icons_by_extension()),
  filenames = export_icons(devicons.get_icons_by_filename()),
}))
