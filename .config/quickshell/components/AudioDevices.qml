import Quickshell
import Quickshell.Services.OSS
import QtQuick
import QtQuick.Layouts

FloatingWindow {
    id: deviceSelector

    property color colBg: "#aa000000"
    property color colFg: "#b0b4bc"
    property color colMuted: "#4e4e4e"
    property color colCyan: "#0db9d7"
    property color colRed: "#cc0000"
    property color colGreen: "#9ece6a"
    property int cornerRadius: 8
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 14

    visible: false
    implicitWidth: 300
    implicitHeight: 360
    color: "transparent"

    mask: Region {
        item: background
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: deviceSelector.colBg
        radius: deviceSelector.cornerRadius
        border.width: 1
        border.color: deviceSelector.colMuted

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8

            Text {
                text: "Audio Devices"
                color: deviceSelector.colFg
                font.family: deviceSelector.fontFamily
                font.pixelSize: deviceSelector.fontSize + 2
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 1
                color: deviceSelector.colMuted
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                ListView {
                    id: deviceList
                    anchors.fill: parent
                    model: OSS.devices
                    spacing: 4

                    delegate: Rectangle {
                        required property var modelData

                        implicitWidth: deviceList.width
                        implicitHeight: 52
                        radius: 6
                        color: mouseArea.containsMouse ? "#11ffffff" : "transparent"
                        border.width: modelData.isDefault ? 2 : 0
                        border.color: deviceSelector.colRed

                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                                easing.type: Easing.OutCubic
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 10

                            Text {
                                text: {
                                    if (modelData.mode === 0x01)
                                        return "󰕾"; // playback
                                    if (modelData.mode === 0x02)
                                        return "󰍬"; // record
                                    return "󱡭"; // playback/record
                                }

                                horizontalAlignment: Text.AlignHCenter
                                Layout.preferredWidth: 24
                                color: deviceSelector.colFg
                                font.family: "Symbols Nerd Font"
                                font.pixelSize: deviceSelector.fontSize + 4
                                font.bold: true
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 2

                                Text {
                                    text: modelData.description || modelData.name
                                    color: deviceSelector.colFg
                                    font.family: deviceSelector.fontFamily
                                    font.pixelSize: deviceSelector.fontSize
                                    elide: Text.ElideRight
                                    Layout.fillWidth: true
                                    font.bold: true
                                }

                                Text {
                                    text: modelData.name
                                    color: deviceSelector.colFg
                                    font.family: deviceSelector.fontFamily
                                    font.pixelSize: deviceSelector.fontSize - 2
                                    visible: modelData.description && modelData.description !== modelData.name
                                }
                            }

                            Text {
                                text: "󰸞"
                                color: deviceSelector.colGreen
                                font.pixelSize: deviceSelector.fontSize + 2
                                font.bold: true
                                visible: modelData.isDefault
                                rightPadding: 16
                            }
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true

                            onClicked: {
                                OSS.setDefaultDevice(modelData.deviceId);
                                deviceSelector.visible = false;
                            }
                        }
                    }
                }
            }
        }
    }

    function toggle() {
        visible = !visible;
    }
}
