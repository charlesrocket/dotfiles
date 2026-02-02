//@ pragma UseQApplication

import Quickshell
import QtQuick

import qs.topbar

ShellRoot {
    Component.onCompleted: {
        Quickshell.watchFiles = false;
    }

    TopBar {}
}
