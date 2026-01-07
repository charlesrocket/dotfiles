import QtQuick

Rectangle {
    color: "transparent"
    border.width: 1
    radius: 6
    opacity: 0
    z: -1

    property color frameColor: "white"
    property int animDuration: 250

    border.color: frameColor

    Behavior on opacity {
        NumberAnimation {
            duration: animDuration
            easing.type: Easing.InOutQuad
        }
    }
}
