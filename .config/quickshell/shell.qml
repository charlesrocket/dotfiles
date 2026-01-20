import Quickshell
import QtQuick

ShellRoot {

    Component.onCompleted: {
        Quickshell.watchFiles = false;
    }

    TopBar {}
}
