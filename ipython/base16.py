# -*- coding: utf-8 -*-
"""
Base16 Default Dark by Chris Kempson (http://chriskempson.com).
IPython Template by Carlos Pita (carlosjosepita@gmail.com).
Created with Base16 Builder by Chris Kempson.
This was edited by Gabe Nespoli for solarized (gabenespoli@gmail.com)
"""

from prompt_toolkit.terminal.vt100_output import _256_colors
from pygments.style import Style
from pygments.token import (Keyword, Name, Comment, String, Error, Text,
                            Number, Operator, Literal, Token)


# See http://chriskempson.com/projects/base16/ for a description of the role
# of the different colors in the base16 palette.

# from http://pygments.org/docs/styles/
# Colors specified using #ansi* are converted to a default set of RGB colors when used with formatters other than the terminal-256 formatter.
# By definition of ANSI, the following colors are considered “light” colors, and will be rendered by most terminals as bold:
# “darkgray”, “red”, “green”, “yellow”, “blue”, “fuchsia”, “turquoise”, “white”
# The following are considered “dark” colors and will be rendered as non-bold:
# “black”, “darkred”, “darkgreen”, “brown”, “darkblue”, “purple”, “teal”, “lightgray”
#Exact behavior might depends on the terminal emulator you are using, and its settings.

#   DARK                    LIGHT
#   black                   darkgray
#   darkred                 red
#   darkgreen               green
#   brown                   yellow
#   darkblue                blue
#   purple                  fuchsia
#   teal                    turquoise
#   lightgray               white

base03 = '#ansidarkgray'
base02 = '#ansiblack'
base01 = '#ansigreen'
base00 = '#ansiyellow'
base0 = '#ansiblue'
base1 = '#ansiturquoise'
base2 = '#ansilightgray'
base3 = '#ansiwhite'
red = '#ansidarkred'
orange = '#ansired'
yellow = '#ansibrown'
green = '#ansidarkgreen'
cyan = '#ansiteal'
blue = '#ansidarkblue'
magenta = '#ansipurple'
violet = '#ansifuchsia'

# See https://github.com/jonathanslenders/python-prompt-toolkit/issues/355
#colors = (globals()['base0' + d] for d in '08BADEC5379F1246')
#for i, color in enumerate(colors):
#    r, g, b = int(color[1:3], 16), int(color[3:5], 16), int(color[5:], 16)
#    _256_colors[r, g, b] = i + 6 if i > 8 else i


# See http://pygments.org/docs/tokens/ for a description of the different
# pygments tokens.

class Base16Style(Style):

    background_color = base03
    highlight_color = base02
    default_style = base0

    # this needs to be change to the ansi colors so it uses the terminal
    # values. it keeps throwing an error when I do, so for now I've 
    # hard coded the Sumach Dark values (2017-05-12 16:12:58)
    styles = {
        Text: '#808080', # base0 (light blue)
        Error: '#d70000', # red
        Comment: '#4e4e4e', # base01 (light green)
        Keyword: '#00875f', # green
        Keyword.Constant: '#008787', # cyan
        Keyword.Namespace: '#0087af', # blue
        Name.Builtin: '#0087af', # blue
        Name.Function: '#0087af', # blue
        Name.Class: '#0087af', # blue
        Name.Decorator: '#d70000', # blue
        Name.Exception: '#d70000', # blue
        Number: '#008787', # cyan
        Operator.Word: '#00875f', # green
        Literal: '#008787', # cyan
        String: '#008787', # cyan
    }


# See https://github.com/jonathanslenders/python-prompt-toolkit/blob/master/prompt_toolkit/styles/defaults.py
# for a description of prompt_toolkit related pseudo-tokens.

overrides = {
    Token.PromptViInp: yellow,
    Token.PromptViNav: green,
    Token.PromptEmacs: violet,
    Token.PromptWhoKnows: red,
    Token.PromptPath: blue,
    Token.PromptPrompt: base2,
    Token.Prompt: base01,
    Token.PromptNum: blue,
    Token.OutPrompt: base01,
    Token.OutPromptNum: magenta,
    Token.Menu.Completions.Completion: 'bg:%s %s' % (base02, base0),
    Token.Menu.Completions.Completion.Current: 'bg:%s %s' % (base0, base02),
    Token.MatchingBracket.Other: 'bg:%s %s' % (base01, base03)
}
