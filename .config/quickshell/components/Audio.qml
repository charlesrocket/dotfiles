import Quickshell.Services.OSS

import QtQuick
import QtQuick.Layouts

Item {
    id: root
    Layout.alignment: Qt.AlignVCenter

    property bool mic: false
    property int deviceId: -1
    property int slideDuration: 250
    property int barLen: 80
    property int iconSize: 16
    property var colNormal: "#b0b4bc"
    property var colMuted: "#4e4e4e"

    implicitWidth: iconText.width + (hoverDetector.containsMouse ? volumeSliderContainer.width + 8 : 0)
    implicitHeight: iconText.height

    Behavior on implicitWidth {
        NumberAnimation {
            duration: root.slideDuration
            easing.type: Easing.OutCubic
        }
    }

    readonly property var device: {
        if (!OSS.devices)
            return null;

        if (root.deviceId >= 0) {
            for (var i = 0; i < OSS.devices.length; i++) {
                if (OSS.devices[i].deviceId === root.deviceId) {
                    return OSS.devices[i];
                }
            }

            return null;
        }

        return OSS.defaultDevice;
    }

    property var control: {
        if (!device || !device.controls)
            return null;

        if (root.mic) {
            for (var i = 0; i < device.controls.length; i++) {
                var devCtl = device.controls[i];
                var trimmedName = devCtl.name.trim().toLowerCase();

                if (trimmedName === "rec")
                    return devCtl;
            }

            for (var i = 0; i < device.controls.length; i++) {
                var devCtl = device.controls[i];
                var trimmedName = devCtl.name.trim().toLowerCase();

                if (trimmedName === "mic")
                    return devCtl;
            }

            return null;
        }

        return device.master;
    }

    readonly property int volume: control ? control.left : 0
    readonly property bool muted: control ? control.muted : false

    function getVolumeIcon(vol, isMuted) {
        if (!mic) {
            if (isMuted || vol === 0)
                return "󰝟";

            return "󰕾";
        } else {
            if (isMuted || vol === 0)
                return "󰍭";

            return "󰍬";
        }
    }

    Item {
        id: iconContainer
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: iconText.width
        height: iconText.height

        Text {
            id: iconText
            anchors.centerIn: parent
            text: root.getVolumeIcon(root.volume, root.muted)
            color: root.muted ? root.colMuted : root.colNormal
            font.family: "Symbols Nerd Font"
            font.pixelSize: root.iconSize
            font.bold: true

            Behavior on color {
                ColorAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }

            Behavior on scale {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }

            onTextChanged: {
                scaleAnimation.restart();
            }

            SequentialAnimation {
                id: scaleAnimation
                NumberAnimation {
                    target: iconText
                    property: "scale"
                    to: 0.8
                    duration: 75
                    easing.type: Easing.InQuad
                }
                NumberAnimation {
                    target: iconText
                    property: "scale"
                    to: 1.0
                    duration: 75
                    easing.type: Easing.OutQuad
                }
            }
        }
    }

    Item {
        id: volumeSliderContainer
        anchors.left: iconContainer.right
        anchors.leftMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        width: root.barLen
        height: iconText.height
        opacity: hoverDetector.containsMouse ? 1 : 0
        scale: hoverDetector.containsMouse ? 1 : 0
        transformOrigin: Item.Left
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation {
                duration: root.slideDuration
                easing.type: Easing.OutCubic
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: root.slideDuration
                easing.type: Easing.OutCubic
            }
        }

        Rectangle {
            anchors.fill: parent
            color: "transparent"

            Rectangle {
                id: sliderTrack
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                height: 4
                radius: 6
                color: "#4e4e4e"

                Rectangle {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width * (root.volume / 100)
                    height: parent.height
                    radius: parent.radius
                    color: root.muted ? root.colMuted : root.colNormal

                    Behavior on width {
                        NumberAnimation {
                            duration: 50
                            easing.type: Easing.OutQuad
                        }
                    }
                }
            }

            Rectangle {
                id: sliderHandle
                anchors.verticalCenter: parent.verticalCenter
                x: (sliderTrack.width - width) * (root.volume / 100)
                width: 12
                height: 12
                radius: 6
                color: root.muted ? root.colMuted : root.colNormal
                border.width: 2
                border.color: root.colNormal

                Behavior on x {
                    NumberAnimation {
                        duration: 50
                        easing.type: Easing.OutQuad
                    }
                }
            }

            MouseArea {
                id: sliderMouseArea
                anchors.fill: parent
                hoverEnabled: true

                function updateVolume(mouseX) {
                    if (root.control) {
                        var newVolume = Math.max(0, Math.min(100, Math.round((mouseX / width) * 100)));

                        root.control.left = newVolume;
                        root.control.right = newVolume;
                    }
                }

                onPressed: function (mouse) {
                    updateVolume(mouse.x);
                }

                onPositionChanged: function (mouse) {
                    if (pressed)
                        updateVolume(mouse.x);
                }
            }
        }
    }

    MouseArea {
        id: hoverDetector
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true

        onPressed: function (mouse) {
            mouse.accepted = false;
        }
    }

    MouseArea {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: iconText.width
        hoverEnabled: false

        onClicked: {
            if (root.control) {
                root.control.muted = !root.control.muted;
            }
        }
    }

    Timer {
        interval: 200
        repeat: true
        running: hoverDetector.containsMouse
        onTriggered: OSS.refresh()
    }
}
