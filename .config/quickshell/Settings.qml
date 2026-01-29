pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property var colors: QtObject {
        readonly property color bg: "#aa000000"
        readonly property color fg: "#b0b4bc"
        readonly property color muted: "#aa4e4e4e"
        readonly property color dark: Qt.darker(muted, 1.5)
        readonly property color cyan: "#0db9d7"
        readonly property color red: "#cc0000"
        readonly property color blue: "#7aa2f7"
        readonly property color yellow: "#ffd700"
        readonly property color green: "#9ece6a"
        readonly property color purple: "#bf00ff"
    }

    readonly property var workspaces: QtObject {
        readonly property string one: ""
        readonly property string two: ""
        readonly property string three: ""
        readonly property string four: ""
        readonly property string five: ""
        readonly property string six: "󰉕"
        readonly property string seven: ""
        readonly property string eight: ""
        readonly property string nine: ""
        readonly property string ten: ""
    }

    readonly property string font: "Hack Nerd Font"

    readonly property int fontSize: 14
    readonly property int radius: 8
    readonly property int duration: 250

    readonly property int barHeight: 30
    readonly property int barExtraPadding: 16

}
