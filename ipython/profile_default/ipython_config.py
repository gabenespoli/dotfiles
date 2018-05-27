# sample ipython_config.py
c = get_config()

#c.TerminalIPythonApp.display_banner = True
#c.InteractiveShellApp.log_level = 20
#c.InteractiveShellApp.extensions = [
#    'myextension'
#]
c.InteractiveShellApp.exec_lines = [
    # 'import numpy as np',
    # 'import pandas as pd',
    # 'import matplotlib.pyplot as plt'
    # 'import scipy as sp'
]
#c.InteractiveShellApp.exec_files = [
    #'mycode.py',
    #'fancy.ipy'
#]
c.InteractiveShell.autoindent = True
#c.InteractiveShell.colors = 'LightBG'
c.InteractiveShell.confirm_exit = False
c.InteractiveShell.editor = 'vim'
#c.InteractiveShell.xmode = 'Context'

#c.PrefilterManager.multi_line_specials = True

c.AliasManager.user_aliases = [
    ('ls', 'ls -hl'),
    ('la', 'ls -hla'),
    ('lsa', 'ls -hla'),
]

c.TerminalInteractiveShell.editing_mode = 'vi'

## Colours
#from pygments.token import Token as pToken
#c.TerminalInteractiveShell.highlighting_style_overrides = {
#    pToken.Keyword: '#ansidarkgreen',
#    pToken.Number: '#ansiturquoise',
#    pToken.Operator: 'noinherit',
#    pToken.String: '#ansiturquoise',
#    pToken.Name.Function: '#ansidarkblue',
#    pToken.Name.Class: '#ansidarkblue',
#    pToken.Name.Namespace: '#ansidarkblue',
#    pToken.Prompt: '#ansidarkblue',
#    pToken.PromptNum: '#ansilightgray',
#    pToken.OutPrompt: '#ansidarkblue',
#    pToken.OutPromptNum: '#ansilightgray',
#}
#c.InteractiveShell.colors = 'Neutral'
#c.TerminalInteractiveShell.highlighting_style = 'solarized256'

from base16 import Base16Style, overrides
from IPython.terminal import interactiveshell
def get_style_by_name(name, original=interactiveshell.get_style_by_name):
    return Base16Style if name == 'base16' else original(name)
interactiveshell.get_style_by_name = get_style_by_name
c.TerminalInteractiveShell.highlighting_style = 'base16'
c.TerminalInteractiveShell.highlighting_style_overrides = overrides


## Prompt
# /usr/local/lib/python2.7/site-packages/IPython/terminal/prompts.py
from IPython.terminal.prompts import Prompts, Token
from prompt_toolkit.key_binding.vi_state import InputMode
import os

class MyPrompt(Prompts):
    def in_prompt_tokens(self, cli=None):
        # return [(Token.Prompt, '>>> ')]
        return [
                (Token.Prompt, '['),
                (Token.PromptNum, str(self.shell.execution_count)),
                (Token.Prompt, ']'),
                (Token.PromptPrompt, '>>> '),
                ]

    #def continuation_prompt_tokens(self, cli=None width=None):
        #if width is None:
            #width = self._width()
        #return[(Token.Prompt, (' ' * (width - 5)) + '... ')]
    def continuation_prompt_tokens(self, cli=None, width=None):
        if width is None:
            width = self._width()
        return [
            (Token.Prompt, (' ' * (width - 5)) + '... '),
        ]

    def out_prompt_tokens(self):
        # return [(Token.OutPrompt, '==> ')]
        return [
                (Token.OutPrompt, '['),
                (Token.OutPromptNum, str(self.shell.execution_count)),
                (Token.OutPrompt, ']'),
                (Token.PromptPrompt, '==> '),
                ]
    
c.TerminalInteractiveShell.prompts_class = MyPrompt

