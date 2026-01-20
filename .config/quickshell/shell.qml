import Quickshell
import QtQuick

import "components"

ShellRoot {

    Component.onCompleted: {
        Quickshell.watchFiles = false;
    }

    TopBar {}
}
