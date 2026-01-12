import QtQuick
import QtQuick.Layouts

Item {
    id: root
    Layout.alignment: Qt.AlignVCenter

    property int slideDuration: 250
    property var color: "#b0b4bc"
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

    Item {
        id: dateContainer
        anchors.right: clockContainer.left
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        width: dateText.width
        height: dateText.height
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

        Text {
            id: dateText
            anchors.centerIn: parent
            text: ""
            color: root.color
            font {
                family: root.fontFamily
                pixelSize: root.fontSize - 1
                bold: true
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
            text: Qt.formatDateTime(new Date(), "HH:mm")
            color: root.color
            font {
                family: root.fontFamily
                pixelSize: root.fontSize - 1
                bold: true
            }

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    clockText.text = Qt.formatDateTime(new Date(), "HH:mm");
                }
            }
        }
    }

    Connections {
        target: hoverDetector

        function onContainsMouseChanged() {
            if (hoverDetector.containsMouse) {
                dateText.text = Qt.formatDateTime(new Date(), "ddd dd MMMM yyyy");
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
