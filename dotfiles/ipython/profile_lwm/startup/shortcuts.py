from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import HasFocus, HasSelection
from prompt_toolkit.keys import Keys


def just_execute(event):
    """https://github.com/ipython/ipython/issues/10405"""
    cbuffer = event.current_buffer
    if cbuffer.complete_state:
        completion = cbuffer.complete_state.current_completion
        if completion:
            cbuffer.apply_completion(completion)
        else:
            cbuffer.cancel_completion()
        return
    cbuffer.accept_action.validate_and_handle(event.cli, cbuffer)


ip = get_ipython()
if getattr(ip, 'pt_cli'):
    registry = ip.pt_cli.application.key_bindings_registry
    binding = registry.add_binding(
        Keys.ControlJ,
        filter=(HasFocus(DEFAULT_BUFFER) & ~HasSelection())
    )
    binding(just_execute)
