pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import Quickshell.Bluetooth
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

    property string fontFamily: "JetBrainsMono Nerd Font"
    property string emptyTitle: ""
    property int animDuration: 250

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
            anchors.leftMargin: 13
            anchors.rightMargin: 12
            spacing: 0

            // left section
            RowLayout {
                Layout.preferredWidth: parent.width / 3
                //Layout.alignment: Qt.AlignLeft
                spacing: 6

                // workspaces
                Repeater {
                    model: 10
                    Text {
                        required property int index
                        property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                        readonly property var workspaceNames: [root.ws01, root.ws02, root.ws03, root.ws04, root.ws05, root.ws06, root.ws07, root.ws08, root.ws09, root.ws10]

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
                            onClicked: Hyprland.dispatch("workspace " + (parent.index + 1))
                        }
                    }
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

                // window title
                Text {
                    id: activeWindowTitle
                    Layout.maximumWidth: Math.min(400, parent.parent.width * 0.3)
                    Layout.fillWidth: true

                    property string fullTitle: {
                        var win = Hyprland.activeToplevel;
                        if (!win || !win.title || win.title.trim() === "") {
                            return root.emptyTitle;
                        }

                        // check if the workspace has any windows
                        var focusedWorkspace = Hyprland.focusedWorkspace;
                        if (focusedWorkspace) {
                            var currentWorkspace = Hyprland.workspaces.values.find(w => w.id === focusedWorkspace.id);
                            if (currentWorkspace && currentWorkspace.toplevels && currentWorkspace.toplevels.values) {
                                var windowCount = currentWorkspace.toplevels.values.length;
                                if (windowCount === 0) {
                                    return root.emptyTitle;
                                }
                            }
                        }

                        return win.title.trim();
                    }

                    text: fullTitle === root.emptyTitle ? fullTitle : (fullTitle.length > 60 ? fullTitle.substring(0, 57) + "..." : fullTitle)

                    color: root.colFg
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    font {
                        family: "Hack Nerd Font"
                        pixelSize: root.fontSize
                        bold: true
                    }

                    HoverFrame {
                        id: hoverActiveWindow
                        anchors.fill: parent
                        frameColor: root.colMuted
                        animDuration: animDuration
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true

                        onEntered: hoverActiveWindow.opacity = 1
                        onExited: hoverActiveWindow.opacity = 0
                    }
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

                // bluetooth
                Text {
                    id: bluetoothWidget

                    readonly property bool hasAdapter: Bluetooth && Bluetooth.adapters && Bluetooth.adapters.length > 0
                    readonly property var adapter: hasAdapter ? Bluetooth.adapters[0] : null

                    readonly property bool powered: adapter ? adapter.powered : false
                    readonly property bool connected: adapter && adapter.connectedDevices && adapter.connectedDevices.length > 0

                    readonly property string connectedDeviceName: {
                        if (connected && adapter && adapter.connectedDevices && adapter.connectedDevices.length > 0) {
                            var device = adapter.connectedDevices[0];
                            return device && device.name ? device.name : "Connected Device";
                        }
                        return "";
                    }

                    text: {
                        if (!powered)
                            return "󰂲";
                        if (connected)
                            return "";
                        return "";
                    }

                    //visible: hasAdapter
                    color: root.colFg
                    font {
                        family: "Symbols Nerd Font"
                        pixelSize: root.fontSize
                        bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            if (bluetoothWidget.adapter) {
                                bluetoothWidget.adapter.powered = !bluetoothWidget.adapter.powered;
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.preferredHeight: parent.height - 6
                    Layout.preferredWidth: 2
                    Layout.alignment: Qt.AlignVCenter
                    color: root.colMuted
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
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: clock.text = Qt.formatDateTime(new Date(), "HH:mm")
                    }
                }

                // battery
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

                    visible: UPower.onBattery || battery?.state === 1 || battery?.state === 4
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
}
