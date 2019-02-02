"""My ipython config (gabenespoli@gmail.com)"""
c = get_config()

c.InteractiveShell.autoindent = False
c.InteractiveShell.confirm_exit = False
c.InteractiveShell.editor = 'nvim'
c.TerminalInteractiveShell.editing_mode = 'emacs'
c.TerminalInteractiveShell.highlight_matching_brackets = False

# Colours
c.InteractiveShell.colors = 'nocolor'

# base16 color maps
bg = '#ansiblack'          # 0
bg_light = '#ansigreen'    # 10
bg_sel = '#ansiyellow'     # 11
fg_com = '#ansidarkgray'   # 8
fg_dark = '#ansiblue'      # 12
fg = '#ansilightgray'      # 7
fg_light = '#ansifuchsia'  # 13
fg_bright = '#ansiwhite'   # 15
red = '#ansidarkred'       # 1
orange = '#ansired'        # 9
yellow = '#ansibrown'      # 3
green = '#ansidarkgreen'   # 2
cyan = '#ansiteal'         # 6
blue = '#ansidarkblue'     # 4
purple = '#ansipurple'     # 5
pink = '#ansiturquoise'    # 14

from pygments.style import Style
from pygments.token import Keyword, Name, Comment, String, Error, Text, \
     Number, Operator, Generic, Whitespace, Punctuation, Other, Literal

class base16_sumach(Style):

    default_style = ''

    background_color = bg
    highlight_color = bg_sel

    styles = {
        # No corresponding class for the following:
        # Text:                      fg,

        Comment:                   fg_com,      # class: 'c'
        Error:                     red,

        Keyword:                   blue,
        Keyword.Type:              yellow,
        Keyword.Namespace:         purple,

        Operator:                  fg,        # class: 'o'

        # Punctuation:               fg,          # class: 'p'

        Name:                      fg,          # class: 'n'
        Name.Attribute:            blue,        # class: 'na' - to be revised
        # Name.Builtin:              "",          # class: 'nb'
        # Name.Builtin.Pseudo:       "",          # class: 'bp'
        Name.Class:                yellow,      # class: 'nc' - to be revised
        # Name.Constant:             cyan,         # class: 'no' - to be revised
        # Name.Decorator:            cyan,        # class: 'nd' - to be revised
        # Name.Entity:               "",          # class: 'ni'
        # Name.Exception:            red,         # class: 'ne'
        Name.Function:             green,        # class: 'nf'
        # Name.Property:             "",          # class: 'py'
        # Name.Label:                "",          # class: 'nl'
        # Name.Namespace:            yellow,      # class: 'nn' - to be revised
        # Name.Other:                blue,        # class: 'nx'
        # Name.Tag:                  cyan,        # class: 'nt' - like a keyword
        # Name.Variable:             red,         # class: 'nv' - to be revised
        # Name.Variable.Class:       "",          # class: 'vc' - to be revised
        # Name.Variable.Global:      "",          # class: 'vg' - to be revised
        # Name.Variable.Instance:    "",          # class: 'vi' - to be revised

        Number:                    cyan,

        # Literal:                   orange,    # class: 'l'
        # Literal.Date:              green,     # class: 'ld'

        String:                    cyan,       # class: 's'
        # String.Backtick:           "",          # class: 'sb'
        # String.Char:               fg,  # class: 'sc'
        # String.Doc:                fg_com,     # class: 'sd' - like a comment
        # String.Double:             "",          # class: 's2'
        String.Escape:             orange,      # class: 'se'
        # String.Heredoc:            "",          # class: 'sh'
        # String.Interpol:           orange,      # class: 'si'
        # String.Other:              "",          # class: 'sx'
        # String.Regex:              "",          # class: 'sr'
        # String.Single:             "",          # class: 's1'
        # String.Symbol:             "",          # class: 'ss'

        # Generic:                   "",                    # class: 'g'
        # Generic.Deleted:           red,                   # class: 'gd',
        # Generic.Emph:              "italic",              # class: 'ge'
        # Generic.Error:             "",                    # class: 'gr'
        # Generic.Heading:           "bold " + fg,  # class: 'gh'
        # Generic.Inserted:          green,                 # class: 'gi'
        # Generic.Output:            "",                    # class: 'go'
        # Generic.Prompt:            blue,     # class: 'gp'
        # Generic.Strong:            "bold",                # class: 'gs'
        # Generic.Subheading:        "bold " + cyan,        # class: 'gu'
        # Generic.Traceback:         "",                    # class: 'gt'


    }

c.TerminalInteractiveShell.highlighting_style = base16_sumach

from pygments.token import Token
c.TerminalInteractiveShell.highlighting_style_overrides = {
    Token.Prompt: blue,
    Token.PromptNum: blue,
    Token.OutPrompt: pink,
    Token.OutPromptNum: pink,
}

# remove vi mode from prompt
# had to manually edit ipython package per this commit:
# https://github.com/ipython/ipython/pull/11492/commits/77a6963866763e1cca0b1091b1b4d50d1e11e524
c.TerminalInteractiveShell.prompt_includes_vi_mode = False
