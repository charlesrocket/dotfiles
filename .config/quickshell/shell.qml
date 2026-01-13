pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Services.OSS
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import "components"

PanelWindow {
    id: root

    property color colBg: "#aa000000"
    property color colFg: "#b0b4bc"
    property color colMuted: "#aa4e4e4e"
    property color colCyan: "#0db9d7"
    property color colRed: "#cc0000"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#ffd700"
    property color colGreen: "#9ece6a"
    property color colPurple: "#bf00ff"

    property string ws01: ""
    property string ws02: ""
    property string ws03: ""
    property string ws04: ""
    property string ws05: ""
    property string ws06: "󰉕"
    property string ws07: ""
    property string ws08: ""
    property string ws09: ""
    property string ws10: ""

    property string fontFamily: "JetBrainsMono Nerd Font"

    property int fontSize: 14
    property var screen: Quickshell.screens[0]
    property int cornerRadius: 8
    property int barHeight: 28
    property int extraPadding: 16
    property int animDuration: 250

    implicitWidth: screen.width - extraPadding
    implicitHeight: barHeight + extraPadding / 2

    anchors.top: true
    color: "transparent"

    AudioDevices {
        id: audioDeviceSelector
    }

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
            anchors.leftMargin: 13
            anchors.rightMargin: 12

            // left section
            RowLayout {
                Layout.preferredWidth: parent.width / 3
                //Layout.alignment: Qt.AlignLeft
                spacing: 6

                // workspaces
                HyprWorkspaces {
                    names: [root.ws01, root.ws02, root.ws03, root.ws04, root.ws05, root.ws06, root.ws07, root.ws08, root.ws09, root.ws10]
                    fontSize: root.fontSize
                    fontFamily: "Symbols Nerd Font"
                }

                Item {
                    Layout.fillWidth: true
                }
            }

            // center section
            RowLayout {
                Layout.preferredWidth: parent.width / 3
                //Layout.alignment: Qt.AlignHCenter

                Item {
                    Layout.fillWidth: true
                }

                // active window title
                WindowTitle {
                    emptyTitle: ""
                    colBg: root.colBg
                    colFg: root.colFg
                    colMuted: root.colMuted
                    fontFamily: "Hack Nerd Font"
                }

                Item {
                    Layout.fillWidth: true
                }
            }

            // right section
            RowLayout {
                Layout.preferredWidth: parent.width / 3
                //Layout.alignment: Qt.AlignRight
                spacing: 6

                Item {
                    Layout.fillWidth: true
                }

                BarSeparator {}

                // audio
                RowLayout {
                    spacing: 8

                    Text {
                        id: audioDeviceButton
                        text: "󱡭"
                        color: root.colFg
                        font {
                            family: "Symbols Nerd Font"
                            pixelSize: root.fontSize
                            bold: true
                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                                easing.type: Easing.OutCubic
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true

                            onEntered: {
                                audioDeviceButton.color = root.colPurple;
                            }

                            onExited: {
                                audioDeviceButton.color = root.colFg;
                            }

                            onClicked: {
                                audioDeviceSelector.toggle();
                            }
                        }
                    }

                    // mic
                    Audio {
                        mic: true
                        slideDuration: root.animDuration
                    }

                    // speaker
                    Audio {
                        slideDuration: root.animDuration
                    }
                }

                BarSeparator {}

                // bluetooth
                Bluetooth {
                    colMain: root.colFg
                    fontSize: root.fontSize
                }

                BarSeparator {}

                // time
                Clock {
                    slideDuration: root.animDuration
                    fontFamily: "FiraCode Nerd Font"
                    fontSize: root.fontSize
                    color: root.colFg
                }

                // battery
                Battery {
                    fontSize: root.fontSize + 2
                    colMain: root.colFg
                    colGood: root.colGreen
                    colBad: root.colRed
                    colCharging: root.colYellow
                }
            }
        }
    }
}
