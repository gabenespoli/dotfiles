local M = {}

M.override_by_extension = {
  txt = {
    icon = "󰈙",
    color = "#89e051",
    cterm_color = "113",
    name = "Txt",
  },
}

M.override_by_filename = {
  ghostty = {
    icon = "󰊠",
    color = "#DDDDDD",
    cterm_color = "15",
    name = "Ghostty",
  },
  vimrc = {
    icon = "",
    color = "#019833",
    cterm_color = "2",
    name = "Vimrc",
  },
}

function M.setup()
  require("nvim-web-devicons").setup({
    override_by_extension = M.override_by_extension,
    override_by_filename = M.override_by_filename,
  })
end

return M
