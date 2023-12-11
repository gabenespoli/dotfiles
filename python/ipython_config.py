"""iPython config."""

import os
import readline
import shutil
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
bg = "#0f111b"
fg = "#ADAD9B"

bg_light = "#2B302B"
fg_com = "#6A6A5B"
fg_light = "#CDC08B"
fg_bright = "#E5E5D2"

red = "#E52E1A"
green = "#1C9C20"
brown = "#B98036"
blue = "#0094CF"
purple = "#7A7CCF"
cyan = "#1DAE87"

orange = "#E5941A"
green_light = "#25C528"
yellow = "#EBBB2B"
blue_light = "#00a3cc"
pink = "#DF7376"
cyan_light = "#5ccc96"

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
    Token.Prompt: blue,
    Token.PromptNum: bg_light,
    Token.OutPrompt: orange,
    Token.OutPromptNum: orange,
    Token.PromptTime: cyan,
    Token.PromptText: green,
    Token.PromptContinuation: fg_com,
    Token.PromptSpace: fg,
    # Token.OutPromptTime: f"bg:{bg_light} {fg}",
    Token.OutPromptText: yellow,
    "matching-bracket.cursor": f"bg:{fg_com} {bg}",
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
    def prompt_setup(self, update_time: bool = True):
        homedir = os.path.expanduser("~")
        self.cwd = os.getcwd().replace(homedir, "~")

        if hasattr(self, "current_time"):
            self.execution_time = datetime.now() - self.current_time
        else:
            self.execution_time = ""

        if update_time:
            self.current_time = datetime.now()
            self.timestr = datetime.now().strftime("%H:%M:%S")

        self.terminal_width = shutil.get_terminal_size().columns
        self.line_width = (
            self.terminal_width - self.cwd.__len__() - self.timestr.__len__() - 5 - 14
        )

    def in_prompt_tokens(self):
        self.prompt_setup()
        return [
            (Token.OutPromptText, "󰌠 "),
            (Token.Prompt, self.cwd),
            (Token.PromptSpace, " "),
            (Token.PromptNum, "─" * self.line_width),
            (Token.PromptSpace, " "),
            (Punctuation, f"{self.execution_time}"),
            (Token.PromptSpace, " "),
            (Token.PromptTime, self.timestr),
            (Token.PromptSpace, " \n"),
            (Token.PromptText, "❯❯❯"),
            (Token.PromptSpace, " "),
        ]

    def out_prompt_tokens(self):
        self.prompt_setup(update_time=False)
        return []

    def continuation_prompt_tokens(self, width=None):  # noqa: D102
        if width is None:
            width = self._width()
        return [
            (Token.PromptContinuation, (" " * (width - 5)) + "..."),
            (Token.PromptSpace, " "),
        ]


c.TerminalInteractiveShell.prompts_class = MyPrompt
