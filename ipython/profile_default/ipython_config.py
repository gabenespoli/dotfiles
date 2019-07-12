"""My ipython config (gabenespoli@gmail.com)"""
c = get_config()

c.InteractiveShell.autoindent = False
c.InteractiveShell.confirm_exit = False
c.InteractiveShell.editor = 'nvim'
c.TerminalInteractiveShell.editing_mode = 'emacs'
c.TerminalInteractiveShell.highlight_matching_brackets = False

# Colours
c.InteractiveShell.colors = 'nocolor'

# # base16 color maps
# bg = '#ansiblack'          # 0
# bg_light = '#ansigreen'    # 10
# bg_sel = '#ansiyellow'     # 11
# fg_com = '#ansidarkgray'   # 8
# fg_dark = '#ansiblue'      # 12
# fg = '#ansilightgray'      # 7
# fg_light = '#ansifuchsia'  # 13
# fg_bright = '#ansiwhite'   # 15
# red = '#ansidarkred'       # 1
# orange = '#ansired'        # 9
# yellow = '#ansibrown'      # 3
# green = '#ansidarkgreen'   # 2
# cyan = '#ansiteal'         # 6
# blue = '#ansidarkblue'     # 4
# pink = '#ansipurple'       # 5
# table = '#ansiturquoise'   # 14

# snooker base16 color maps
# because the above breaks on new versions of ipython
bg = '#1B1F1E'          # 0
bg_light = '#2B302B'    # 10
bg_sel = '#3C4137'     # 11
fg_com = '#6A6A5B'   # 8
fg_dark = '#5F785C'      # 12
fg = '#ADAD9B'      # 7
fg_light = '#CDC08B'  # 13
fg_bright = '#CCCCCC'   # 15
red = '#E52E1A'       # 1
orange = '#B98036'        # 9
yellow = '#EBBB2B'      # 3
green = '#25C528'   # 2
cyan = '#21C296'         # 6
blue = '#0094CF'     # 4
pink = '#DF7376'       # 5
table = '#5D4124'   # 14

from pygments.style import Style
from pygments.token import Keyword, Name, Comment, String, Error, Text, \
     Number, Operator, Generic, Whitespace, Punctuation, Other, Literal

class base16_snooker(Style):

    default_style = ''

    background_color = bg
    highlight_color = bg_sel

    styles = {
        # No corresponding class for the following:
        Text:                      fg,

        Comment:                   fg_com,      # class: 'c'
        Error:                     red,

        Keyword:                   green,
        Keyword.Type:              yellow,
        Keyword.Namespace:         pink,

        Operator:                  red,        # class: 'o'

        # Punctuation:               fg,          # class: 'p'

        Name:                      fg,          # class: 'n'
        Name.Attribute:            blue,        # class: 'na' - to be revised
        # Name.Builtin:              "",          # class: 'nb'
        # Name.Builtin.Pseudo:       "",          # class: 'bp'
        Name.Class:                blue,      # class: 'nc' - to be revised
        # Name.Constant:             cyan,         # class: 'no' - to be revised
        # Name.Decorator:            cyan,        # class: 'nd' - to be revised
        # Name.Entity:               "",          # class: 'ni'
        # Name.Exception:            red,         # class: 'ne'
        Name.Function:             blue,        # class: 'nf'
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

c.TerminalInteractiveShell.highlighting_style = base16_snooker

from pygments.token import Token
c.TerminalInteractiveShell.highlighting_style_overrides = {
    Token.Prompt: green,
    Token.PromptNum: green,
    Token.OutPrompt: pink,
    Token.OutPromptNum: pink,
}
