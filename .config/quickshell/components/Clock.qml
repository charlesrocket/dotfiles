import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts

Item {
    id: root
    Layout.alignment: Qt.AlignVCenter

    property int slideDuration: 250
    property color colMain: "#b0b4bc"
    property color colBtn: "#cc0000"
    property string fontFamily: "FiraCode Nerd Font"
    property int fontSize: 14

    implicitWidth: (hoverDetector.containsMouse ? dateContainer.width + 8 : 0) + clockText.width
    implicitHeight: clockText.height

    Behavior on implicitWidth {
        NumberAnimation {
            duration: root.slideDuration
            easing.type: Easing.OutCubic
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Process {
        id: wlogoutProc
        command: ["wlogout"]
        Component.onCompleted: running = false
    }

    RowLayout {
        id: dateContainer
        anchors.right: clockContainer.left
        anchors.rightMargin: hoverDetector.containsMouse ? 8 : 0
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10

        opacity: hoverDetector.containsMouse ? 1 : 0
        scale: hoverDetector.containsMouse ? 1 : 0
        transformOrigin: Item.Right
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

        Behavior on anchors.rightMargin {
            NumberAnimation {
                duration: root.slideDuration
                easing.type: Easing.OutCubic
            }
        }

        Text {
            id: dateText
            text: ""
            color: root.colMain
            font {
                family: root.fontFamily
                pixelSize: root.fontSize - 1
                bold: true
            }
        }

        Text {
            id: powerBtn
            text: ""
            color: root.colBtn
            Layout.bottomMargin: 2
            font {
                family: "Symbols Nerd Font"
                pixelSize: root.fontSize + 1
                bold: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    wlogoutProc.running = true;
                }
            }
        }
    }

    Item {
        id: clockContainer
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: clockText.width
        height: clockText.height

        Text {
            id: clockText
            anchors.centerIn: parent
            text: Qt.formatDateTime(clock.date, "HH:mm")
            color: root.colMain
            font {
                family: root.fontFamily
                pixelSize: root.fontSize - 1
                bold: true
            }
        }
    }

    Connections {
        target: hoverDetector
        function onContainsMouseChanged() {
            if (hoverDetector.containsMouse) {
                dateText.text = Qt.formatDateTime(clock.date, "ddd dd MMMM yyyy");
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
}
