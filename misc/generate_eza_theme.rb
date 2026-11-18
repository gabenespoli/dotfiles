#!/usr/bin/env ruby

require "json"
require "fileutils"
require "yaml"

icons_path, target_path = ARGV
abort "usage: generate_eza_theme.rb ICONS_JSON TARGET_THEME" unless icons_path && target_path

icons = JSON.parse(File.read(icons_path))
theme = YAML.load_file(target_path)

def icon_entry(icon)
  {
    "icon" => {
      "glyph" => icon.fetch("glyph"),
      "style" => { "foreground" => icon.fetch("color") },
    },
  }
end

def merge_icon_section(generated, local)
  merged = generated.dup
  local.each do |key, value|
    next unless value.is_a?(Hash)

    if merged[key]
      local_glyph = value.dig("icon", "glyph")
      merged[key]["icon"]["glyph"] = local_glyph if local_glyph
      value.each do |section, section_value|
        next if section == "icon"

        merged[key][section] = section_value
      end
    else
      merged[key] = value
    end
  end
  merged
end

generated_extensions = icons.fetch("extensions").transform_values { |icon| icon_entry(icon) }
generated_filenames = icons.fetch("filenames").transform_values { |icon| icon_entry(icon) }

theme["extensions"] = merge_icon_section(generated_extensions, theme.fetch("extensions", {}))
theme["filenames"] = merge_icon_section(generated_filenames, theme.fetch("filenames", {}))
theme["colourful"] = true

header = <<~TEXT
  # Icon glyphs and colours exported from the installed nvim-web-devicons plugin.
  # Local Snooker overrides are merged below.
TEXT

FileUtils.cp(target_path, "#{target_path}.bak")
File.write(target_path, header + YAML.dump(theme))
