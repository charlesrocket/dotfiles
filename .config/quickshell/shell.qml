//@ pragma UseQApplication

import Quickshell
import QtQuick

import qs.topbar

ShellRoot {
    TopBar {}
    Wallpaper {}

    Connections {
		target: Quickshell

		function onLastWindowClosed() {
			Qt.quit();
		}
	}

    Component.onCompleted: {
        Quickshell.watchFiles = false;
    }
}
