from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import HasFocus, HasSelection
from prompt_toolkit.keys import Keys


def just_execute(event):
    """https://github.com/ipython/ipython/issues/10405"""
    cbuffer = event.current_buffer
    doc = cbuffer.document
    if cbuffer.complete_state:
        if cbuffer.complete_state.current_completion:
            cbuffer.apply_completion(cc)
        else:
            cbuffer.cancel_completion()
        return
    cbuffer.accept_action.validate_and_handle(event.cli, cbuffer)

ip = get_ipython()
if getattr(ip, 'pt_cli'):
    registry = ip.pt_cli.application.key_bindings_registry
    filters = (HasFocus(DEFAULT_BUFFER) & ~HasSelection())
    binding = registry.add_binding(Keys.ControlJ, filter=filters))
    binding(just_execute)
