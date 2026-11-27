#!/usr/bin/env ruby
# Generate VS Code Snooker themes from vim/colors/snooker.vim.
# usage: generate_vscode_theme.rb [SNOOKER_VIM] [OUTPUT_DIR]

require "json"
require "fileutils"

dotfiles = File.expand_path("..", __dir__)
vim_path = ARGV[0] || File.join(dotfiles, "vim/colors/snooker.vim")
out_dir = ARGV[1] || File.join(dotfiles, "config/vscode/snooker-theme/themes")

def parse_palettes(source)
  palettes = { "light" => {}, "dark" => {} }
  current = nil
  source.each_line do |line|
    case line
    when /^if &background ==# 'light'/ then current = "light"
    when /^else/ then current = "dark" if current == "light"
    when /^endif/ then break if current == "dark"
    when /let s:(\w+)\s*=\s*\{ 'gui': '(#\h{6})', 'cterm': '([^']*)'/
      palettes[current][$1] = { "gui" => $2, "cterm" => $3 } if current
    end
  end
  palettes
end

def ansi(c)
  by_cterm = c.values.each_with_object({}) { |v, h| h[v["cterm"]] ||= v["gui"] }
  names = %w[Black Red Green Yellow Blue Magenta Cyan White]
  result = {}
  names.each_with_index do |name, i|
    result["terminal.ansi#{name}"] = by_cterm.fetch(i.to_s)
    result["terminal.ansiBright#{name}"] = by_cterm.fetch((i + 8).to_s)
  end
  result
end

def ui_colors(c)
  bg, fg, bgl = c["bg"], c["fg"], c["bg_light"]
  com, bright = c["fg_com"], c["fg_bright"]
  {
    "focusBorder" => c["blue"],
    "foreground" => fg,
    "descriptionForeground" => com,
    "errorForeground" => c["red"],
    "widget.border" => bgl,
    "selection.background" => com,
    "textLink.foreground" => c["blue"],
    "textLink.activeForeground" => c["blue_light"],

    "editor.background" => bg,
    "editor.foreground" => fg,
    "editorCursor.foreground" => c["fg_light"],
    "editor.lineHighlightBackground" => bgl,
    "editor.lineHighlightBorder" => bgl,
    "editor.selectionBackground" => com,
    "editor.selectionForeground" => bright,
    "editor.inactiveSelectionBackground" => "#{com}80",
    "editor.findMatchBackground" => c["pink"],
    "editor.findMatchForeground" => bg,
    "editor.findMatchHighlightBackground" => "#{c["pink"]}60",
    "editor.wordHighlightBackground" => "#{com}50",
    "editorBracketMatch.background" => "#{com}80",
    "editorBracketMatch.border" => com,
    "editorLineNumber.foreground" => com,
    "editorLineNumber.activeForeground" => fg,
    "editorWhitespace.foreground" => bgl,
    "editorIndentGuide.background1" => bgl,
    "editorIndentGuide.activeBackground1" => com,
    "editorRuler.foreground" => bgl,
    "editorGutter.background" => bg,
    "editorGutter.addedBackground" => c["green_light"],
    "editorGutter.modifiedBackground" => c["blue_light"],
    "editorGutter.deletedBackground" => c["red"],
    "editorError.foreground" => c["red"],
    "editorWarning.foreground" => c["orange"],
    "editorInfo.foreground" => c["blue"],
    "editorWidget.background" => bgl,
    "editorWidget.border" => com,
    "editorHoverWidget.background" => bgl,
    "editorHoverWidget.border" => com,
    "editorSuggestWidget.background" => bgl,
    "editorSuggestWidget.border" => com,
    "editorSuggestWidget.selectedBackground" => c["blue_light"],
    "editorSuggestWidget.selectedForeground" => bg,
    "editorSuggestWidget.highlightForeground" => c["pink"],
    "editorGroup.border" => bgl,
    "editorGroupHeader.tabsBackground" => bgl,
    "editorOverviewRuler.border" => bgl,

    "diffEditor.insertedTextBackground" => "#{c["green_bg"]}cc",
    "diffEditor.removedTextBackground" => "#{c["red_bg"]}cc",
    "diffEditor.insertedLineBackground" => c["green_bg"],
    "diffEditor.removedLineBackground" => c["red_bg"],

    "tab.activeBackground" => bg,
    "tab.activeForeground" => bright,
    "tab.inactiveBackground" => bgl,
    "tab.inactiveForeground" => com,
    "tab.border" => bgl,
    "tab.activeBorderTop" => c["green"],

    "statusBar.background" => bgl,
    "statusBar.foreground" => fg,
    "statusBar.border" => bgl,
    "statusBar.noFolderBackground" => bgl,
    "statusBar.debuggingBackground" => c["orange"],
    "statusBar.debuggingForeground" => bg,
    "statusBarItem.remoteBackground" => c["green"],
    "statusBarItem.remoteForeground" => bright,

    "titleBar.activeBackground" => bgl,
    "titleBar.activeForeground" => fg,
    "titleBar.inactiveBackground" => bgl,
    "titleBar.inactiveForeground" => com,

    "activityBar.background" => bg,
    "activityBar.foreground" => fg,
    "activityBar.inactiveForeground" => com,
    "activityBar.border" => bgl,
    "activityBar.activeBorder" => c["green"],
    "activityBarBadge.background" => c["green"],
    "activityBarBadge.foreground" => bright,

    "sideBar.background" => bg,
    "sideBar.foreground" => fg,
    "sideBar.border" => bgl,
    "sideBarTitle.foreground" => fg,
    "sideBarSectionHeader.background" => bgl,
    "sideBarSectionHeader.foreground" => fg,

    "list.activeSelectionBackground" => bgl,
    "list.activeSelectionForeground" => bright,
    "list.inactiveSelectionBackground" => bgl,
    "list.hoverBackground" => "#{bgl}aa",
    "list.focusOutline" => com,
    "list.highlightForeground" => c["pink"],
    "list.errorForeground" => c["red"],
    "list.warningForeground" => c["orange"],

    "gitDecoration.addedResourceForeground" => c["green_light"],
    "gitDecoration.modifiedResourceForeground" => c["blue_light"],
    "gitDecoration.deletedResourceForeground" => c["red"],
    "gitDecoration.untrackedResourceForeground" => c["cyan_light"],
    "gitDecoration.ignoredResourceForeground" => com,
    "gitDecoration.conflictingResourceForeground" => c["orange"],

    "input.background" => bgl,
    "input.foreground" => fg,
    "input.border" => bgl,
    "input.placeholderForeground" => com,
    "inputOption.activeBorder" => c["blue"],
    "dropdown.background" => bgl,
    "dropdown.foreground" => fg,
    "button.background" => c["green"],
    "button.foreground" => bright,
    "button.hoverBackground" => c["green_light"],
    "badge.background" => c["green"],
    "badge.foreground" => bright,
    "scrollbarSlider.background" => "#{com}50",
    "scrollbarSlider.hoverBackground" => "#{com}80",
    "scrollbarSlider.activeBackground" => com,
    "progressBar.background" => c["green"],

    "quickInput.background" => bgl,
    "quickInputList.focusBackground" => c["blue_light"],
    "quickInputList.focusForeground" => bg,
    "pickerGroup.foreground" => c["green"],
    "menu.background" => bgl,
    "menu.foreground" => fg,
    "menu.selectionBackground" => c["blue_light"],
    "menu.selectionForeground" => bg,

    "panel.background" => bg,
    "panel.border" => bgl,
    "panelTitle.activeForeground" => bright,
    "panelTitle.activeBorder" => c["green"],
    "panelTitle.inactiveForeground" => com,
    "terminal.background" => bg,
    "terminal.foreground" => fg,
    "terminalCursor.foreground" => c["fg_light"],
    "terminal.selectionBackground" => com,

    "peekView.border" => c["blue"],
    "peekViewEditor.background" => bgl,
    "peekViewResult.background" => bg,
    "peekViewTitle.background" => bgl,

    "notebook.cellBorderColor" => bgl,
    "notebook.cellEditorBackground" => bgl,
    "notebook.cellToolbarSeparator" => bgl,
    "notebook.focusedCellBorder" => c["green"],
    "notebook.focusedEditorBorder" => c["green"],
    "notebook.inactiveFocusedCellBorder" => com,
    "notebook.outputContainerBackgroundColor" => bg,
    "notebook.selectedCellBackground" => "#{bgl}80",
    "notebook.cellHoverBackground" => "#{bgl}50",
    "notebookStatusSuccessIcon.foreground" => c["green_light"],
    "notebookStatusErrorIcon.foreground" => c["red"],
    "notebookStatusRunningIcon.foreground" => c["yellow"],
    "interactive.activeCodeBorder" => c["green"],
    "interactive.inactiveCodeBorder" => bgl,
  }
end

def token(scope, fg, style = nil)
  settings = { "foreground" => fg }
  settings["fontStyle"] = style if style
  { "scope" => scope, "settings" => settings }
end

def token_colors(c)
  [
    token(%w[comment punctuation.definition.comment string.comment], c["fg_com"], "italic"),
    token(%w[string string.quoted constant.character constant.numeric], c["cyan"]),
    token(%w[constant constant.language support.constant variable.other.constant], c["cyan_light"]),
    token(%w[entity.name.function support.function meta.function-call.generic variable.function], c["blue"]),
    token(%w[keyword keyword.control storage.type.function storage.type.class keyword.operator.logical keyword.operator.new], c["green"]),
    token(%w[keyword.control.exception keyword.control.trycatch], c["orange"]),
    token(%w[keyword.control.import keyword.control.from meta.preprocessor entity.name.function.decorator meta.decorator punctuation.definition.decorator variable.parameter], c["purple"]),
    token(%w[entity.name.type entity.name.class support.type support.class entity.other.inherited-class storage.type], c["yellow"]),
    token(%w[support.type.builtin support.function.builtin constant.character.escape string.regexp], c["brown"]),
    token(%w[punctuation.separator punctuation.terminator punctuation.section punctuation.definition.parameters punctuation.definition.arguments punctuation.parenthesis], c["fg_com"]),
    token(%w[keyword.operator variable variable.other entity.name.namespace], c["fg"]),
    token(%w[invalid invalid.illegal], c["red"]),
    token(%w[markup.heading entity.name.section], c["fg_bright"], "bold italic"),
    token(%w[markup.bold], c["fg_light"], "bold"),
    token(%w[markup.italic], c["fg_light"], "italic"),
    token(%w[markup.underline.link string.other.link], c["blue"], "italic"),
    token(%w[markup.inline.raw markup.fenced_code], c["cyan_light"]),
    token(%w[markup.inserted], c["green_light"]),
    token(%w[markup.deleted], c["red"]),
    token(%w[markup.changed], c["blue_light"]),
    token(%w[keyword.other.DML.sql keyword.other.sql keyword.other.alias.sql], c["green"]),
  ]
end

palettes = parse_palettes(File.read(vim_path))
FileUtils.mkdir_p(out_dir)

palettes.each do |variant, raw|
  abort "no #{variant} palette found in #{vim_path}" if raw.empty?
  c = raw.transform_values { |v| v["gui"] }
  colors = ui_colors(c).merge(ansi(raw))
  theme = {
    "name" => "Snooker #{variant.capitalize}",
    "type" => variant,
    "semanticHighlighting" => true,
    "colors" => colors,
    "tokenColors" => token_colors(c),
    "semanticTokenColors" => {
      "parameter" => c["purple"],
      "module" => c["fg"],
      "class" => c["yellow"],
      "class.builtin" => c["brown"],
      "function.builtin" => c["brown"],
      "variable.readonly.constant" => c["cyan_light"],
    },
  }
  path = File.join(out_dir, "snooker-#{variant}-color-theme.json")
  File.write(path, JSON.pretty_generate(theme) + "\n")
  puts "wrote #{path}"
end
