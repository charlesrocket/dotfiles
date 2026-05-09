pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property var general: QtObject {
        readonly property string locale: "en_US"
        readonly property string fontFamily: "Hack Nerd Font"
        readonly property int fontSize: 14
        readonly property int cornerRadius: 8
        readonly property int borderWidth: 1
        readonly property int animDuration: 250
        readonly property string wallpaper: "~/Pictures/hardcoding/zaki-aby-fisheye-top-0-064.jpg"
        readonly property bool blur: true
    }

    readonly property var colors: QtObject {
        readonly property color bg: "#aa000000"
        readonly property color bgl: "#80404040"
        readonly property color bge: "#151515"
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
        readonly property string eight: ""
        readonly property string nine: ""
        readonly property string ten: ""
    }

    readonly property var bar: QtObject {
        readonly property int height: 30
        readonly property int padding: 8

        readonly property var title: QtObject {
            readonly property int width: 400
            readonly property string empty: ""
        }
    }

    readonly property var desktop: QtObject {
        readonly property bool launcher: true
        readonly property bool osd: true
    }

    property var dashboard: QtObject {
        property var player: QtObject {
            property bool queueButtons: false
        }
    }

    property var notifications: QtObject {
        property bool enabled: true
        property int width: 300
    }

    readonly property var widgets: QtObject {
        readonly property bool workspaces: true
        readonly property bool title: true
        readonly property bool battery: true
        readonly property bool network: true
        readonly property bool bluetooth: true
        readonly property bool audio: true
        readonly property bool language: true
        readonly property bool weather: true
        readonly property bool clock: true
        readonly property bool stats: true
        readonly property bool tray: true
    }

    readonly property var lockscreen: QtObject {
        readonly property bool clock: true
        readonly property bool battery: true
        readonly property bool buttons: true
        readonly property string wallpaper: "~/Pictures/hardcoding/zaki-aby-general-shot.jpg"
        readonly property bool shadows: false
        readonly property bool username: true
        readonly property bool icon: true
    }

    readonly property var session: QtObject {
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
