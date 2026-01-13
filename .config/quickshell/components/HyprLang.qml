import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Rectangle {
    id: root

    property string currentLayout: ""
    property string fontFamily: "Fira Code Nerd Font"
    property color colMain: null
    property color colBorder: null
    property color colBackground: null

    width: layoutText.width + 6
    height: layoutText.height + 2
    color: colBackground
    border.color: colBorder
    radius: 2

    Text {
        id: layoutText
        anchors.centerIn: parent

        text: {
            if (!root.currentLayout)
                return "XX";

            if (root.currentLayout.includes('(') && root.currentLayout.includes(')')) {
                const match = root.currentLayout.match(/\(([^)]+)\)/);
                return match ? match[1] : root.currentLayout.substring(0, 2).toUpperCase();
            }

            const firstWord = root.currentLayout.split(' ')[0];
            return firstWord.length <= 3 ? firstWord : firstWord.substring(0, 2).toUpperCase();
        }

        font.pixelSize: 12
        font.bold: true
        font.family: root.fontFamily
        color: root.colMain
    }

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name === "activelayout") {
                const parts = event.data.split(',');

                if (parts.length >= 2) {
                    root.currentLayout = parts[1].trim();
                }
            }
        }
    }

    property string jsonBuffer: ""

    Process {
        id: initProc
        command: ["hyprctl", "-j", "devices"]

        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;

                root.jsonBuffer += data;
            }
        }

        onExited: {
            if (root.jsonBuffer) {
                try {
                    var devices = JSON.parse(root.jsonBuffer);

                    if (devices.keyboards && devices.keyboards.length > 0) {
                        for (var i = 0; i < devices.keyboards.length; i++) {
                            var kb = devices.keyboards[i];

                            if (kb.main === true) {
                                if (kb.active_keymap) {
                                    root.currentLayout = kb.active_keymap;
                                }

                                break;
                            }
                        }

                        if (!root.currentLayout && devices.keyboards[0].active_keymap) {
                            root.currentLayout = devices.keyboards[0].active_keymap;
                        }
                    }
                } catch (e) {
                    console.error("Failed to parse keyboard devices:", e);
                }

                root.jsonBuffer = "";
            }
        }

        Component.onCompleted: running = true
    }
}
