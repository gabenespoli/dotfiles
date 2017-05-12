# full list of keybindings:
# https://github.com/jonathanslenders/python-prompt-toolkit/blob/4aa0404ad7e770763b85764fd42c8dbce94f9c62/prompt_toolkit/key_binding/bindings/vi.py

# take from: http://stackoverflow.com/questions/38443907/how-does-one-set-specific-vim-bindings-in-ipython-5-0-0
from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import HasFocus, ViInsertMode
from prompt_toolkit.key_binding.vi_state import InputMode

ip = get_ipython()

def switch_to_navigation_mode(event):
    vi_state = event.cli.vi_state
    vi_state.reset(InputMode.NAVIGATION)

if getattr(ip, 'pt_cli'):
    registry = ip.pt_cli.application.key_bindings_registry
    registry.add_binding(u'j',u'k',
                         filter=(HasFocus(DEFAULT_BUFFER)
                                 & ViInsertMode()))(switch_to_navigation_mode)

