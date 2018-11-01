"""My ipython config (gabenespoli@gmail.com)"""
c = get_config()

#c.TerminalIPythonApp.display_banner = True
#c.InteractiveShellApp.log_level = 20
# c.InteractiveShellApp.extensions = [
    # 'autoreload'
# ]
# c.InteractiveShellApp.exec_lines = [
    # '%autoreload 2'
# ]
#c.InteractiveShellApp.exec_files = [
    #'mycode.py',
    #'fancy.ipy'
#]
c.InteractiveShell.autoindent = True
c.InteractiveShell.confirm_exit = False
# c.InteractiveShell.editor = 'vim'
# c.TerminalInteractiveShell.editing_mode = 'vi'
# c.InteractiveShell.xmode = 'Context'

#c.PrefilterManager.multi_line_specials = True

# c.AliasManager.user_aliases = [
#     ('ls', 'ls -hl'),
#     ('la', 'ls -hla'),
#     ('lsa', 'ls -hla'),
# ]

# Colours
c.InteractiveShell.colors = 'nocolor'
from pygments.token import Token as pToken
c.TerminalInteractiveShell.highlighting_style_overrides = {
    pToken.Text: '#ansiblue',
    pToken.Error: '#ansired',
    pToken.Comment: '#ansigreen',
    pToken.Keyword: '#ansidarkgreen',
    pToken.Keyword.Constant: '#ansiteal',
    pToken.Keyword.Namespace: '#ansiturquoise',
    pToken.Name.Builtin: '#ansidarkblue',
    pToken.Name.Function: '#ansidarkblue',
    pToken.Name.Class: '#ansidarkblue',
    pToken.Name.Decorator: '#ansired',
    pToken.Name.Exception: '#ansired',
    pToken.Name.Namespace: '#ansidarkblue',
    pToken.Number: '#ansiteal',
    pToken.String: '#ansiteal',
    pToken.Operator: 'noinherit',
    pToken.Operator.Word: '#ansigreen',
    pToken.Literal: '#ansiteal',
    pToken.Prompt: '#ansidarkblue',
    pToken.PromptNum: '#ansidarkblue',
    pToken.OutPrompt: '#ansiturquoise',
    pToken.OutPromptNum: '#ansiturquoise',
}
