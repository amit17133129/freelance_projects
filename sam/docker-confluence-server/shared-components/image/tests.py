import pytest

import entrypoint_helpers as eh

def test_str2bool():
    assert eh.str2bool('True')
    assert eh.str2bool('1')
    assert eh.str2bool(1)
    assert eh.str2bool('y')
    assert eh.str2bool('Y')

    assert eh.str2bool(None) == False

    assert not eh.str2bool(2)
    assert not eh.str2bool('false')
    assert not eh.str2bool('n')

    assert not eh.str2bool('something else')

def test_str2bool_or():
    assert eh.str2bool_or(None, False) == False

    assert eh.str2bool_or('True', False)
    assert eh.str2bool_or('1', False)
    assert eh.str2bool_or(1, False)
    assert eh.str2bool_or('y', False)
    assert eh.str2bool_or('Y', False)

    assert not eh.str2bool_or(2, True)
    assert not eh.str2bool_or('false', True)
    assert not eh.str2bool_or('n', True)
    assert not eh.str2bool_or('something else', True)
