import Quickshell
import Quickshell.Services.UPower
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
    property color colYellow: "#ffd700"
    property color colGreen: "#9ece6a"
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
            spacing: 6

            // workspaces
            Repeater {
                model: 10
                Text {
                    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                    readonly property var workspaceNames: ["", "", "", "", "", "󰉕", "", "", "", ""]

                    text: workspaceNames[index]
                    color: isActive ? root.colRed : (ws ? root.colFg : root.colMuted)
                    leftPadding: 4
                    rightPadding: 4
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
                    pixelSize: root.fontSize - 1
                    bold: true
                }

                Timer {
                    interval: 60000
                    running: true
                    repeat: true
                    onTriggered: clock.text = Qt.formatDateTime(new Date(), "HH:mm")
                }
            }

            Text {
                id: batteryIndicator
                property var battery: UPower.displayDevice
                readonly property int batteryPercentage: battery?.ready ? Math.round(battery.percentage * 100) : 0
                readonly property bool isCharging: battery?.state === 1
                readonly property bool isDischarging: battery?.state === 2
                readonly property bool isFullyCharged: battery?.state === 4

                function getBatteryIcon(percentage) {
                    if (!battery?.ready)
                        return "󰂑";
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

                text: battery?.ready ? `${getBatteryIcon(batteryPercentage)}` : ""
                color: {
                    if (!battery?.ready)
                        return root.colMuted;
                    if (isCharging)
                        return root.colYellow;
                    if (batteryPercentage >= 80)
                        return root.colGreen;
                    if (batteryPercentage <= 30)
                        return root.colRed;
                    return root.colFg;
                }

                visible: UPower.onBattery || battery?.state === 1 || battery?.state === 4
                font {
                    family: "Symbols Nerd Font"
                    pixelSize: root.fontSize + 2
                    bold: true
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // TODO
                        console.log("Battery clicked:", batteryIndicator.battery);
                    }
                }
            }
        }
    }
}
