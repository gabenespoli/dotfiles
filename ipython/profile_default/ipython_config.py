"""iPython config."""

import readline
import subprocess
from datetime import datetime

import IPython
import prompt_toolkit
from IPython.terminal.prompts import Prompts
from prompt_toolkit.styles.pygments import pygments_token_to_classname
from prompt_toolkit.styles.style import Style
from pygments.token import Comment
from pygments.token import Error
from pygments.token import Keyword
from pygments.token import Literal
from pygments.token import Name
from pygments.token import Number
from pygments.token import Operator
from pygments.token import Punctuation
from pygments.token import String
from pygments.token import Text
from pygments.token import Token

c = get_config()  # noqa: F821

c.InteractiveShell.autoindent = False
c.InteractiveShell.confirm_exit = False
c.InteractiveShell.editor = "nvim"
c.TerminalInteractiveShell.editing_mode = "emacs"
c.TerminalInteractiveShell.highlight_matching_brackets = True
c.TerminalInteractiveShell.true_color = True

# Fix C-w behaviour
# -----------------
# https://stackoverflow.com/questions/21532543/cpython-interactive-readline-better-backwards-deletion-of-words
readline.parse_and_bind('"\\C-w": backward-kill-word')
subprocess.call(["stty", "werase", "undef"])

# Colors
# ------
# With parts taken from petobens config
# https://github.com/petobens/dotfiles/blob/master/python/ipython_config.py


def my_style_from_pygments_dict(pygments_dict):
    """Monkey patch prompt toolkit style function to fix completion colors.

    Fix completion highlighting as per
    https://github.com/ipython/ipython/issues/11526

    """
    pygments_style = []
    for token, style in pygments_dict.items():
        if isinstance(token, str):
            pygments_style.append((token, style))
        else:
            pygments_style.append((pygments_token_to_classname(token), style))
    return Style(pygments_style)


prompt_toolkit.styles.pygments.style_from_pygments_dict = (
    my_style_from_pygments_dict
)
IPython.terminal.interactiveshell.style_from_pygments_dict = (
    my_style_from_pygments_dict
)


# Palette (snooker)
bg = "#121615"
fg = "#ADAD9B"

bg_light = "#2B302B"
fg_com = "#6A6A5B"
fg_light = "#CDC08B"
fg_bright = "#E5E5D2"

red = "#E52E1A"
green = "#1C9C20"
brown = "#B98036"
blue = "#0085BA"
purple = "#7A7CCF"
cyan = "#1DAE87"

orange = "#E5941A"
green_light = "#25C528"
yellow = "#EBBB2B"
blue_light = "#0094CF"
pink = "#DF7376"
cyan_light = "#21C296"

# See:
# https://github.com/prompt-toolkit/python-prompt-toolkit/blob/master/prompt_toolkit/styles/defaults.py # noqa
# https://pygments.org/docs/tokens/
c.TerminalInteractiveShell.highlighting_style_overrides = {
    Text: fg,
    Error: red,
    Comment: fg_com,
    Keyword: green,
    Keyword.Type: yellow,
    Keyword.Namespace: purple,
    Keyword.Constant: cyan,
    Keyword.Namespace: purple,
    Name: fg,
    Name.Attribute: blue,
    Name.Namespace: fg,
    Name.Builtin: blue,
    Name.Function: blue,
    Name.Class: yellow,
    Name.Decorator: purple,
    Name.Exception: green_light,
    Name.Variable.Magic: red,  # dunder methods
    Number: cyan,
    Operator: fg,
    Operator.Word: green_light,
    Literal: cyan,
    String: cyan,
    String.Affix: brown,
    String.Doc: cyan,
    String.Escape: orange,
    String.Interpol: cyan,
    Token.Prompt: green,
    Token.PromptNum: green,
    Token.OutPrompt: orange,
    Token.OutPromptNum: orange,
    Token.PromptTime: f"bg:{bg_light} {fg}",
    Token.PromptText: f"bg:{bg_light} {blue}",
    Token.PromptContinuation: blue,
    Token.PromptSpace: fg,
    Token.OutPromptTime: f"bg:{bg_light} {fg}",
    Token.OutPromptText: f"bg:{bg_light} {purple}",
    "matching-bracket.cursor": f"bg:{fg_light} {bg}",
    "matching-bracket.other": f"bg:{fg_com} {bg}",
    Punctuation: brown,
    "completion-menu": f"bg:{bg_light} {fg_bright}",
    "completion-menu.completion.current": f"bg:{blue_light} {bg}",
    "completion-menu.completion": f"bg:{bg_light} {fg_bright}",
    "completion-menu.meta.completion.current": f"bg:{blue_light} {bg}",
    "completion-menu.meta.completion": f"bg:{bg_light} {fg_bright}",
    "completion-menu.multi-column-meta": f"bg:{bg_light} {fg_bright}",
}


class MyPrompt(Prompts):  # noqa: D101
    # https://ipython.readthedocs.io/en/stable/config/details.html#custom-prompts
    def in_prompt_tokens(self, cli=None):  # noqa: D102
        return [
            (Token.PromptTime, datetime.now().strftime("%H:%M")),
            (Token.PromptText, " >>>"),
            (Token.PromptSpace, " "),
        ]

    def out_prompt_tokens(self, cli=None):  # noqa: D102
        return [
            (Token.OutPromptTime, datetime.now().strftime("%H:%M")),
            (Token.OutPromptText, " >>>"),
            (Token.PromptSpace, " "),
        ]

    def continuation_prompt_tokens(self, width=None):  # noqa: D102
        if width is None:
            width = self._width()
        return [
            (Token.PromptContinuation, (" " * (width - 5)) + " ..."),
            (Token.PromptSpace, " "),
        ]


c.TerminalInteractiveShell.prompts_class = MyPrompt
