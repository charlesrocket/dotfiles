import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    property color colBg: "#aa000000"
    property color colFg: "#b0b4bc"
    property color colMuted: "#aa4e4e4e"
    property color colCyan: "#0db9d7"
    property color colRed: "#cc0000"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"
    property string fontFamily: "JetBrainsMono Nerd Font"
    property var screen: Quickshell.screens[0]
    property int cornerRadius: 8
    property int fontSize: 14
    property int barHeight: 28
    property int extraPadding: 16

    implicitWidth: screen.width - extraPadding
    implicitHeight: barHeight + extraPadding / 2

    anchors.top: true
    color: "transparent"

    Rectangle {
        id: bar
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        border.width: 1
        border.color: colMuted
        height: barHeight
        color: root.colBg
        radius: cornerRadius

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            spacing: 8

            // workspaces
            Repeater {
                model: 10
                Text {
                    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                    readonly property var workspaceNames: ["", "", "", "", "", "󰉕", "", "", "", ""]

                    text: workspaceNames[index]
                    color: isActive ? root.colRed : (ws ? root.colFg : root.colMuted)
                    leftPadding: 3
                    rightPadding: 3
                    font {
                        family: "Symbols Nerd Font"
                        pixelSize: root.fontSize
                        bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch("workspace " + (index + 1))
                    }
                }
            }

            Item {
                Layout.fillWidth: true
            }

            // clock
            Text {
                id: clock
                text: Qt.formatDateTime(new Date(), "HH:mm")
                color: root.colFg
                font {
                    family: "FiraCode Nerd Font"
                    pixelSize: root.fontSize
                    bold: true
                }

                Timer {
                    interval: 60000
                    running: true
                    repeat: true
                    onTriggered: clock.text = Qt.formatDateTime(new Date(), "HH:mm")
                }
            }
        }
    }
}
