# sample ipython_config.py
c = get_config()

#c.TerminalIPythonApp.display_banner = True
#c.InteractiveShellApp.log_level = 20
#c.InteractiveShellApp.extensions = [
#    'myextension'
#]
c.InteractiveShellApp.exec_lines = [
    'import numpy as np',
    'import scipy as sp',
    'import pandas as pd'
]
#c.InteractiveShellApp.exec_files = [
    #'mycode.py',
    #'fancy.ipy'
#]
c.InteractiveShell.autoindent = True
#c.InteractiveShell.colors = 'LightBG'
#c.InteractiveShell.confirm_exit = False
c.InteractiveShell.editor = 'vim'
#c.InteractiveShell.xmode = 'Context'

#c.PrefilterManager.multi_line_specials = True

#c.AliasManager.user_aliases = [
# ('la', 'ls -al')
#]



c.TerminalInteractiveShell.editing_mode = 'vi'
#c.InteractiveShell.colors = 'Neutral'
#c.TerminalInteractiveShell.highlighting_style = 'solarized256'

from pygments.token import Token

c.TerminalInteractiveShell.highlighting_style_overrides = {
    Token.Keyword: '#ansidarkgreen',
    Token.Number: '#ansiturquoise',
    Token.Operator: 'noinherit',
    Token.String: '#ansiturquoise',
    Token.Name.Function: '#ansidarkblue',
    Token.Name.Class: '#ansidarkblue',
    Token.Name.Namespace: '#ansidarkblue',
    Token.Prompt: '#ansidarkblue',
    Token.PromptNum: '#ansilightgray',
    Token.OutPrompt: '#ansidarkblue',
    Token.OutPromptNum: '#ansilightgray',
}
