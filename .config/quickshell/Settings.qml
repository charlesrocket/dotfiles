pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property var colors: QtObject {
        readonly property color bg: "#aa000000"
        readonly property color bgE: "#151515"
        readonly property color fg: "#b0b4bc"
        readonly property color border: "#aa4e4e4e"
        readonly property color passive: "#4e4e4e"
        readonly property color dark: Qt.darker(passive, 1.5)
        readonly property color action: "#0db9d7"
        readonly property color accent: red
        readonly property color red: "#cc0000"
        readonly property color yellow: "#ffd700"
        readonly property color purple: "#bf00ff"
        readonly property color green: "#9ece6a"
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
    readonly property int barExtraPadding: 8

    readonly property bool systemTray: true
    readonly property bool systemStats: true

    readonly property string emptyWindowTitle: ""
    readonly property string wallpaper: "~/Pictures/hardcoding/zaki-aby-fisheye-top-0-064.jpg"

    readonly property var logout: QtObject {
        readonly property color background: "#aa202020"
        readonly property var commands: QtObject {
            readonly property string lock: "quickshell ipc call topbar lock"
            readonly property string logout: "hyprctl dispatch exit | pkill mango"
            readonly property string suspend: "zzz"
            readonly property string hibernate: "acpiconf -s 4"
            readonly property string shutdown: "shutdown -p now"
            readonly property string reboot: "shutdown -r now"
        }
    }
}
