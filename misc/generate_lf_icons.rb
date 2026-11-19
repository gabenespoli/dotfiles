#!/usr/bin/env ruby

require "json"

icons_path, target_path = ARGV
abort "usage: generate_lf_icons.rb ICONS_JSON TARGET_ICONS" unless icons_path && target_path

icons = JSON.parse(File.read(icons_path))
existing = File.read(target_path)
header = existing.lines.take_while { |line| !line.start_with?("# file extensions") }.join.rstrip

def ansi_style(hex)
  red, green, blue = hex.delete_prefix("#").scan(/../).map { |component| component.to_i(16) }
  "00;38;2;#{red};#{green};#{blue}"
end

def icon_line(pattern, icon)
  "%-24s %-4s %s" % [pattern, icon.fetch("glyph"), ansi_style(icon.fetch("color"))]
end

extension_lines = icons.fetch("extensions").sort.map do |extension, icon|
  icon_line("*.#{extension}", icon)
end

filename_lines = icons.fetch("filenames").sort.map do |filename, icon|
  icon_line("*#{filename}", icon)
end

content = [
  header,
  "",
  "# file extensions (nvim-web-devicons)",
  *extension_lines,
  "",
  "# file names (nvim-web-devicons; case-sensitive matching)",
  *filename_lines,
  "",
].join("\n")

File.write(target_path, content)
