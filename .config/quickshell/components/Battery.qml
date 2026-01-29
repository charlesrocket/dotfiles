import Quickshell.Services.UPower

import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property color colMain: "#b0b4bc"
    property color colCharging: "#ffd700"
    property color colGood: "#9ece6a"
    property color colBad: "#cc0000"
    property color colBg: "#aa4e4e4e"
    property int slideDuration: 250
    property int fontSize: 14
    property var fontFamily: "Hack Nerd Font"

    readonly property var battery: UPower.displayDevice
    readonly property int batteryPercentage: battery?.ready ? Math.round(battery.percentage * 100) : 0
    readonly property bool isCharging: battery?.state === 1
    readonly property bool isDischarging: battery?.state === 2
    readonly property bool isEmpty: battery?.state === 3
    readonly property bool isFullyCharged: battery?.state === 4

    visible: battery

    function getBatteryIcon(percentage) {
        if (isCharging || isFullyCharged) {
            if (percentage == 100)
                return "󰂅";
            if (percentage >= 90)
                return "󰂋";
            if (percentage >= 80)
                return "󰂊";
            if (percentage >= 70)
                return "󰢞";
            if (percentage >= 60)
                return "󰂉";
            if (percentage >= 50)
                return "󰢝";
            if (percentage >= 40)
                return "󰂈";
            if (percentage >= 30)
                return "󰂇";
            if (percentage >= 20)
                return "󰂆";
            return "󰢜";
        } else {
            if (percentage == 100)
                return "󰁹";
            if (percentage >= 90)
                return "󰂂";
            if (percentage >= 80)
                return "󰂁";
            if (percentage >= 70)
                return "󰂀";
            if (percentage >= 60)
                return "󰁿";
            if (percentage >= 50)
                return "󰁾";
            if (percentage >= 40)
                return "󰁽";
            if (percentage >= 30)
                return "󰁼";
            if (percentage >= 20)
                return "󰁻";
            return "󰁺";
        }
    }

    function secondsToHhMm(seconds) {
        var date = new Date(0, 0, 0, 0, 0, seconds);
        return Qt.formatTime(date, "hh:mm");
    }

    function batteryInfo(batt) {
        if (isDischarging)
            return "󱐋 " + batteryPercentage + "% " + secondsToHhMm(batt.timeToEmpty);
        if (isCharging)
            return "󱐋 " + batteryPercentage + "% " + secondsToHhMm(batt.timeToFull);
        if (isFullyCharged || isEmpty)
            return "󱐋 " + batteryPercentage + "% " + Math.round(batt.energyCapacity) + " Wh";
    }

    implicitWidth: (hoverDetector.containsMouse ? infoContainer.width + 8 : 0) + battText.width
    implicitHeight: battText.height

    Behavior on implicitWidth {
        NumberAnimation {
            duration: root.slideDuration
            easing.type: Easing.OutCubic
        }
    }

    Rectangle {
        id: infoContainer
        anchors.right: battContainer.left
        anchors.rightMargin: hoverDetector.containsMouse ? 8 : 0
        width: infoText.contentWidth + 10
        height: infoText.contentHeight
        color: root.colBg
        radius: 6
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
            id: infoText
            anchors.centerIn: parent
            text: ""
            color: root.colMain
            font {
                family: root.fontFamily
                pixelSize: root.fontSize - 2
                bold: true
            }
        }
    }

    Item {
        id: battContainer
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: battText.width
        height: battText.height

        Text {
            id: battText

            visible: UPower.onBattery || root.isCharging || root.isDischarging || root.isEmpty || root.isFullyCharged
            text: root.battery?.ready ? `${root.getBatteryIcon(root.batteryPercentage)}` : ""
            color: {
                if (root.isCharging)
                    return root.colCharging;
                if (root.batteryPercentage >= 90)
                    return root.colGood;
                if (root.batteryPercentage <= 34 || root.isEmpty)
                    return root.colBad;
                return root.colMain;
            }

            font {
                family: "Symbols Nerd Font"
                pixelSize: root.fontSize
                bold: true
            }

            Behavior on color {
                ColorAnimation {
                    duration: 2000
                    easing.type: Easing.InOutExpo
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // TODO
                    console.log("Battery clicked:", root.battery);
                }
            }
        }
    }

    Connections {
        target: hoverDetector
        function onContainsMouseChanged() {
            if (hoverDetector.containsMouse) {
                infoText.text = `${root.batteryInfo(root.battery)}`;
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
