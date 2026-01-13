import Quickshell.Services.UPower

import QtQuick
import QtQuick.Layouts

Text {
    id: root

    property color colMain: "#b0b4bc"
    property color colCharging: "#ffd700"
    property color colGood: "#9ece6a"
    property color colBad: "#cc0000"
    property int fontSize: 14
    property var fontFamily: "Symbols Nerd Font"

    readonly property var battery: UPower.displayDevice
    readonly property int batteryPercentage: battery?.ready ? Math.round(battery.percentage * 100) : 0
    readonly property bool isCharging: battery?.state === 1
    readonly property bool isDischarging: battery?.state === 2
    readonly property bool isEmpty: battery?.state === 3
    readonly property bool isFullyCharged: battery?.state === 4

    function getBatteryIcon(percentage) {
        if (!battery?.ready)
            return "󱉞";
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

    visible: UPower.onBattery || isCharging || isDischarging || isEmpty || isFullyCharged
    text: battery?.ready ? `${getBatteryIcon(batteryPercentage)}` : ""
    color: {
        if (isCharging)
            return root.colCharging;
        if (batteryPercentage >= 90)
            return root.colGood;
        if (batteryPercentage <= 34 || isEmpty)
            return root.colBad;
        return root.colMain;
    }

    font {
        family: root.fontFamily
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
