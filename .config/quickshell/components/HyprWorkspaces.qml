pragma ComponentBehavior: Bound

import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

Repeater {
    id: root
    model: 10

    property var names: null
    property int animDuration: 250
    property int fontSize: 14
    property string fontFamily: "Symbols Nerd Font"
    property color colNormal: "#b0b4bc"
    property color colActive: "#cc0000"
    property color colInactive: "#aa4e4e4e"

    Text {
        required property int index
        property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

        text: root.names[index]
        color: isActive ? root.colActive : (ws ? root.colNormal : root.colInactive)
        leftPadding: 4
        rightPadding: 4
        font {
            family: root.fontFamily
            pixelSize: root.fontSize
            bold: true
        }

        Behavior on color {
            ColorAnimation {
                duration: root.animDuration
                easing.type: Easing.OutCubic
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: Hyprland.dispatch("workspace " + (parent.index + 1))
        }
    }
}
