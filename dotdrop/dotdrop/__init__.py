"""
author: deadc0de6 (https://github.com/deadc0de6)
Copyright (c) 2017, deadc0de6
"""

import sys

__version__ = '0.17.1'


def main():
    import dotdrop.dotdrop
    if dotdrop.dotdrop.main():
        sys.exit(0)
    sys.exit(1)
