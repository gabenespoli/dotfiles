



    # ------------------------------------------------------------------------------
    # Reference for some palette items:
    #
    #  "namespace" : "import", "from", "using"
    #  "operator"  : "+", "-", "=" etc.
    #                NOTE: Does not include ".", which is assigned the type "source"
    #  "argument"  : Function arguments
    #  "builtin"   : "range", "dict", "set", "list", etc.
    #  "pseudo"    : "None", "True", "False"
    #                NOTE: Does not include "self", which is assigned the
    #                type "source"
    #  "dunder"    : Class method names of the form __<name>__ within
    #               a class definition
    #  "exception" : Exception names
    #  "keyword"   : All keywords except those specifically assigned to "keyword2"
    #                ("from", "and", "break", "is", "try", "pass", etc.)
    #  "keyword2"  : "class", "def", "exec", "lambda", "print"
    # ------------------------------------------------------------------------------

    # inheritance_map = (
    #     # Style       Inherits from
    #     # ----------  ----------
    #     ("namespace", "keyword"),
    #     ("operator",  "source"),
    #     ("argument",  "source"),
    #     ("builtin",   "source"),
    #     ("pseudo",    "source"),
    #     ("dunder",    "name"),
    #     ("exception", "source"),
    #     ("keyword2",  "keyword")
    # )

    palette_update({
        # The following styles are initialized to "None".  Themes
        # (including custom Themes) may set them as needed.
        # If they are not set by a theme, then they will
        # inherit from other styles in accordance with
        # the inheritance_map.

        # "namespace": None,
        # "operator":  None,
        # "argument":  None,
        # "builtin":   None,
        # "pseudo":    None,
        # "dunder":    None,
        # "exception": None,
        # "keyword2":  None,

        # {{{ ui
        "header": ("black", "light gray", "standout"),

        "selectable": ("black", "dark cyan"),
        "focused selectable": ("black", "dark green"),

        "button": (add_setting("white", "bold"), "dark blue"),
        "focused button": ("light cyan", "black"),

        "dialog title": (add_setting("white", "bold"), "dark cyan"),

        "background": ("black", "light gray"),
        "hotkey": (add_setting("black", "underline"), "light gray", "underline"),
        "focused sidebar": (add_setting("yellow", "bold"), "light gray", "standout"),

        "warning": (add_setting("white", "bold"), "dark red", "standout"),

        "label": ("black", "light gray"),
        "value": (add_setting("yellow", "bold"), "dark blue"),
        "fixed value": ("light gray", "dark blue"),
        "group head": (add_setting("dark blue", "bold"), "light gray"),

        "search box": ("black", "dark cyan"),
        "search not found": ("white", "dark red"),

        # }}}

        # {{{ shell

        "command line edit": (add_setting("yellow", "bold"), "dark blue"),
        "command line prompt": (add_setting("white", "bold"), "dark blue"),

        "command line output": ("light cyan", "dark blue"),
        "command line input": (add_setting("light cyan", "bold"), "dark blue"),
        "command line error": (add_setting("light red", "bold"), "dark blue"),

        "focused command line output": ("black", "dark green"),
        "focused command line input": (
                add_setting("light cyan", "bold"),
                "dark green"),
        "focused command line error": ("black", "dark green"),

        "command line clear button": (add_setting("white", "bold"), "dark blue"),
        "command line focused button": ("light cyan", "black"),

        # }}}

        # {{{ source

        "breakpoint": ("black", "dark cyan"),
        "disabled breakpoint": ("dark gray", "dark cyan"),
        "focused breakpoint": ("black", "dark green"),
        "focused disabled breakpoint": ("dark gray", "dark green"),
        "current breakpoint": (add_setting("white", "bold"), "dark cyan"),
        "disabled current breakpoint": (
                add_setting("dark gray", "bold"), "dark cyan"),
        "focused current breakpoint": (
                add_setting("white", "bold"), "dark green", "bold"),
        "focused disabled current breakpoint": (
                add_setting("dark gray", "bold"), "dark green", "bold"),

        "source": (add_setting("yellow", "bold"), "dark blue"),
        "focused source": ("black", "dark green"),
        "highlighted source": ("black", "dark magenta"),
        "current source": ("black", "dark cyan"),
        "current focused source": (add_setting("white", "bold"), "dark cyan"),
        "current highlighted source": ("white", "dark cyan"),

        # {{{ highlighting

        "line number": ("light gray", "dark blue"),
        "keyword": (add_setting("white", "bold"), "dark blue"),
        "name": ("light cyan", "dark blue"),
        "literal": ("light magenta, bold", "dark blue"),

        "string": (add_setting("light magenta", "bold"), "dark blue"),
        "doublestring": (add_setting("light magenta", "bold"), "dark blue"),
        "singlestring": (add_setting("light magenta", "bold"), "dark blue"),
        "docstring": (add_setting("light magenta", "bold"), "dark blue"),

        "punctuation": ("light gray", "dark blue"),
        "comment": ("light gray", "dark blue"),

        # }}}

        # }}}

        # {{{ breakpoints

        "breakpoint marker": ("dark red", "dark blue"),

        "breakpoint source": (add_setting("yellow", "bold"), "dark red"),
        "breakpoint focused source": ("black", "dark red"),
        "current breakpoint source": ("black", "dark red"),
        "current breakpoint focused source": ("white", "dark red"),

        # }}}

        # {{{ variables view

        "variables": ("black", "dark cyan"),
        "variable separator": ("dark cyan", "light gray"),

        "var label": ("dark blue", "dark cyan"),
        "var value": ("black", "dark cyan"),
        "focused var label": ("dark blue", "dark green"),
        "focused var value": ("black", "dark green"),

        "highlighted var label": ("white", "dark cyan"),
        "highlighted var value": ("black", "dark cyan"),
        "focused highlighted var label": ("white", "dark green"),
        "focused highlighted var value": ("black", "dark green"),

        "return label": ("white", "dark blue"),
        "return value": ("black", "dark cyan"),
        "focused return label": ("light gray", "dark blue"),
        "focused return value": ("black", "dark green"),

        # }}}

        # {{{ stack

        "stack": ("black", "dark cyan"),

        "frame name": ("black", "dark cyan"),
        "focused frame name": ("black", "dark green"),
        "frame class": ("dark blue", "dark cyan"),
        "focused frame class": ("dark blue", "dark green"),
        "frame location": ("light cyan", "dark cyan"),
        "focused frame location": ("light cyan", "dark green"),

        "current frame name": (add_setting("white", "bold"),
            "dark cyan"),
        "focused current frame name": (add_setting("white", "bold"),
            "dark green", "bold"),
        "current frame class": ("dark blue", "dark cyan"),
        "focused current frame class": ("dark blue", "dark green"),
        "current frame location": ("light cyan", "dark cyan"),
        "focused current frame location": ("light cyan", "dark green"),

        # }}}

    })

# vim: foldmethod=marker
