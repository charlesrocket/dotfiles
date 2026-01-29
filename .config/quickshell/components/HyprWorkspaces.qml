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
    property color colPassive: "#aa4e4e4e"
    property color colCyan: "#0db9d7"

    Text {
        id: button

        required property int index
        property bool isHovered: false
        property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

        text: root.names[index]
        color: isHovered ? root.colCyan : isActive ? root.colActive : (ws ? root.colNormal : root.colPassive)

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
            hoverEnabled: true

            onClicked: Hyprland.dispatch("workspace " + (parent.index + 1))
            onEntered: button.isHovered = true
            onExited: button.isHovered = false
        }
    }
}
