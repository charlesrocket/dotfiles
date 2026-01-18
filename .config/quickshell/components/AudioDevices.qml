import Quickshell
import Quickshell.Services.OSS
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property color colBg: "#aa000000"
    property color colMain: "#b0b4bc"
    property color colDecor: "#4e4e4e"
    property color colActive: "#cc0000"
    property color colCheck: "#9ece6a"
    property color colWinBorder: "#4e4e4e"
    property color colButton: colMain
    property color colButtonHover: "#bf00ff"
    property int cornerRadius: 8
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 14

    implicitWidth: buttonText.implicitWidth
    implicitHeight: buttonText.implicitHeight

    function getActiveDeviceIcon() {
        for (var i = 0; i < OSS.devices.length; i++) {
            const device = OSS.devices[i];

            if (device.isDefault) {
                const mode = device.mode;

                if (mode === 1 || mode === 3)
                    return "󰓃";
                if (mode === 2)
                    return "󰍰";
            }
        }

        return "󰤽";
    }

    Text {
        id: buttonText
        text: OSS.headphonesConnected ? "󰋋" : root.getActiveDeviceIcon()
        color: root.colButton

        font {
            family: "Symbols Nerd Font"
            pixelSize: root.fontSize
            bold: true
        }

        Behavior on color {
            ColorAnimation {
                duration: 250
                easing.type: Easing.OutCubic
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                buttonText.color = root.colButtonHover;
            }

            onExited: {
                buttonText.color = root.colButton;
            }

            onClicked: {
                floatingWindow.toggle();
            }
        }
    }

    Connections {
        target: OSS
        function onHeadphonesChanged(state) {
            buttonText.text = state ? "󰋋" : root.getActiveDeviceIcon();
        }
    }

    Connections {
        target: OSS
        function onDevicesChanged() {
            buttonText.text = root.getActiveDeviceIcon();
        }
    }

    // Floating Window
    FloatingWindow {
        id: floatingWindow
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
            color: root.colBg
            radius: root.cornerRadius
            border.color: root.colWinBorder

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 8

                Text {
                    text: "Audio Devices"
                    color: root.colMain
                    font.family: root.fontFamily
                    font.pixelSize: root.fontSize + 2
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.bottomMargin: 8
                    implicitHeight: 1
                    color: root.colDecor
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
                            border.color: root.colActive

                            Behavior on color {
                                ColorAnimation {
                                    duration: 250
                                    easing.type: Easing.OutCubic
                                }
                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 10

                                Text {
                                    text: {
                                        if (modelData.mode === 1)
                                            return "";
                                        if (modelData.mode === 2)
                                            return "󰻃";

                                        return "󰤽";
                                    }

                                    horizontalAlignment: Text.AlignHCenter
                                    Layout.preferredWidth: 24
                                    color: root.colMain
                                    font.family: "Symbols Nerd Font"
                                    font.pixelSize: root.fontSize + 8
                                    font.bold: true
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 2

                                    Text {
                                        text: modelData.description || modelData.name
                                        color: root.colMain
                                        font.family: root.fontFamily
                                        font.pixelSize: root.fontSize
                                        elide: Text.ElideRight
                                        Layout.fillWidth: true
                                        font.bold: true
                                    }

                                    Text {
                                        text: modelData.name
                                        color: root.colMain
                                        font.family: root.fontFamily
                                        font.pixelSize: root.fontSize - 2
                                        visible: modelData.description && modelData.description !== modelData.name
                                    }
                                }

                                Text {
                                    text: "󰸞"
                                    color: root.colCheck
                                    font.pixelSize: root.fontSize + 2
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
                                    floatingWindow.visible = false;
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
}
