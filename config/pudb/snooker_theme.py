# Supported 16 color values:
#   'h0' (color number 0) through 'h15' (color number 15)
#    or
#   'default' (use the terminal's default foreground),
#   'black', 'dark red', 'dark green', 'brown', 'dark blue',
#   'dark magenta', 'dark cyan', 'light gray', 'dark gray',
#   'light red', 'light green', 'yellow', 'light blue',
#   'light magenta', 'light cyan', 'white'
#
# Supported 256 color values:
#   'h0' (color number 0) through 'h255' (color number 255)
#
# 256 color chart: http://en.wikipedia.org/wiki/File:Xterm_color_chart.png
#
# "setting_name": (foreground_color, background_color),

# See pudb/theme.py
# (https://github.com/inducer/pudb/blob/master/pudb/theme.py) to see what keys
# there are.

# Note, be sure to test your theme in both curses and raw mode (see the bottom
# of the preferences window). Curses mode will be used with screen or tmux.

# with solarized:
    # 0 are comments
    # default/light blue is fg
    # 7 is bright
    # dark gray is bg
    # light green is cursorline
    # maybe do a new one where 0 is still bg, 7 becomes comments, default is fg
    #   comments are more useful for tmux status bars etc. guess it depends if
    #   you want to dim things or cursorline them. the top right of tmux looks
    #   better with dimmed

palette.update({
    # "source": ("white", "default"),
    # "comment": ("dark gray", "default")

    # {{{ dark vim

    "header": ("black", "light gray", "standout"),

    # {{{ variables view
    "variables": ("dark blue", "black"),
    "variable separator": ("default", "black"),

    "var label": ("dark blue", "black"),
    "var value": ("default", "black"),
    "focused var label": ("dark blue", "light green"),
    "focused var value": ("default", "light green"),

    "highlighted var label": ("dark blue", "black"),
    "highlighted var value": ("default", "black"),
    "focused highlighted var label": ("dark blue", "light green"),
    "focused highlighted var value": ("default", "light green"),

    "return label": ("dark blue", "black"),
    "return value": ("default", "black"),
    "focused return label": ("dark blue", "light green"),
    "focused return value": ("default", "light green"),

    # }}}

    # {{{ stack view

    "stack": ("black", "black"),

    "frame name": ("default", "black"),
    "focused frame name": ("default", "light green"),
    "frame class": ("brown", "black"),
    "focused frame class": ("brown", "light green"),
    "frame location": ("dark magenta", "black"),
    "focused frame location": ("dark magenta", "light green"),

    # "current frame name": (add_setting("white", "bold"), "black"),
    # "focused current frame name": (add_setting("white", "bold"), "light green", "bold"),
    "current frame class": ("brown", "black"),
    "focused current frame class": ("brown", "dark green"),
    "current frame location": ("dark magenta", "black"),
    "focused current frame location": ("dark magenta", "light green"),

    # }}}

    # {{{ breakpoint view

    "breakpoint": ("light gray", "dark gray"),
    "disabled breakpoint": ("black", "dark gray"),
    "focused breakpoint": ("light gray", "light blue"),
    "focused disabled breakpoint": ("black", "light blue"),
    # "current breakpoint": (add_setting("white", "bold"), "dark gray"),
    "disabled current breakpoint": ("black", "dark gray"),
    # "focused current breakpoint": (add_setting("white", "bold"), "light blue"),
    "focused disabled current breakpoint":
        ("black", "light blue"),

    # }}}

    # {{{ ui widgets

    "selectable": ("light gray", "dark gray"),
    "focused selectable": ("white", "light blue"),

    "button": ("light gray", "dark gray"),
    "focused button": ("white", "light blue"),

    "background": ("default", "light green"),
    # "hotkey": (add_setting("black", "underline"), "light gray", "underline"),
    "focused sidebar": ("light blue", "light gray", "standout"),

    # "warning": (add_setting("white", "bold"), "dark red", "standout"),

    "label": ("black", "light gray"),
    "value": ("white", "dark gray"),
    "fixed value": ("light gray", "dark gray"),

    "search box": ("white", "dark gray"),
    "search not found": ("white", "dark red"),

    # "dialog title": (add_setting("white", "bold"), "dark gray"),

    # }}}

    # {{{ source view

    "breakpoint marker": ("dark red", "black"),

    "breakpoint source": ("light gray", "dark red"),
    "breakpoint focused source": ("black", "dark red"),
    "current breakpoint source": ("black", "dark red"),
    "current breakpoint focused source": ("white", "dark red"),

    # }}}

    # {{{ highlighting

    "source": ("default", "black"),
    "focused source": ("white", "light green"),
    "highlighted source": ("black", "dark magenta"),
    "current source": ("black", "light gray"),
    "current focused source": ("white", "dark cyan"),
    "current highlighted source": ("white", "dark cyan"),

    "line number": ("default", "light green"),
    "keyword": ("dark blue", "black"),

    "literal": ("dark cyan", "black"),
    "string": ("dark cyan", "black"),
    "doublestring": ("dark cyan", "black"),
    "singlestring": ("dark cyan", "black"),
    "docstring": ("dark cyan", "black"),

    "name": ("light cyan", "black"),
    "punctuation": ("dark red", "black"),
    "comment": ("dark green", "black"),

    # }}}

    # {{{ shell

    "command line edit": ("white", "black"),
    # "command line prompt": (add_setting("yellow", "bold"), "black"),

    # "command line output": (add_setting("yellow", "bold"), "black"),
    # "command line input": ("white", "black"),
    # "command line error": (add_setting("light red", "bold"), "black"),

    # "focused command line output": ("black", "light blue"),
    # "focused command line input": (add_setting("light cyan", "bold"), "light blue"),
    # "focused command line error": ("black", "light blue"),

    # }}}
    })

# }}}
