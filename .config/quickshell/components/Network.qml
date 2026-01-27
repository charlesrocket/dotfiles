import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Networking

Item {
    id: root

    property int fontSize: 14
    property color colFg: "#ffffff"
    property color colYellow: "#ffd700"
    property color colCyan: "#0db9d7"
    property color colOffline: "#cc0000"
    property color colOnline: root.isOnline ? root.colFg : root.colOffline
    property bool isOnline: false

    readonly property var devicesList: Networking.devices.values
    readonly property string uplinkIcon: hasActiveVpn ? "" : ""

    readonly property bool hasActiveVpn: {
        var devices = devicesList;
        for (var i = 0; i < devices.length; i++) {
            var dev = devices[i];

            if (dev && dev.connected && dev.name) {
                var name = dev.name.toLowerCase();
                if (name.startsWith("tun") || name.startsWith("tap") || name.startsWith("wg") || name.startsWith("ppp")) {
                    return true;
                }
            }
        }

        return false;
    }

    readonly property var primaryDevice: {
        var devices = devicesList;
        if (devices.length === 0)
            return null;

        var connectedDev = null;
        var firstDev = null;

        for (var i = 0; i < devices.length; i++) {
            var dev = devices[i];
            if (!dev)
                continue;

            if (!firstDev)
                firstDev = dev;

            if (dev.state === DeviceConnectionState.Connected) {
                connectedDev = dev;
                return dev;
            }
        }

        return connectedDev || firstDev;
    }

    readonly property bool isPrimaryWifi: {
        if (!primaryDevice)
            return false;

        return primaryDevice.type === DeviceType.Wifi;
    }

    readonly property string ifIcon: {
        if (isPrimaryWifi)
            return "󰖩";
        else
            return "󰈀";
    }

    implicitWidth: section.implicitWidth
    implicitHeight: section.implicitHeight

    Process {
        id: netifRestart
        command: ["netif-restart"]
        Component.onCompleted: running = false
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    Process {
        id: onlineCheck
        command: ["host", "-W", "5", "8.8.8.8"]
        running: true

        onExited: (exitCode, exitStatus) => {
            var randomValue = Math.floor(Math.random() * (1000 - 5000) + 5000);
            tmr.interval = 3000 + randomValue;
            root.isOnline = (exitCode === 0);
            tmr.start();
        }
    }

    Timer {
        id: tmr
        interval: 2000
        onTriggered: {
            onlineCheck.running = true;
        }
    }

    RowLayout {
        id: section
        anchors.fill: parent
        spacing: 6

        Text {
            id: ifIcon
            text: root.uplinkIcon
            color: root.isOnline ? root.colFg : root.colOffline
            font.family: "Symbols Nerd Font"
            font.pixelSize: root.fontSize

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
                    ifIcon.color = root.colCyan;
                }

                onExited: {
                    ifIcon.color = root.colOnline;
                }

                onClicked: {
                    netifRestart.running = true;
                }
            }
        }

        Text {
            text: root.ifIcon
            color: root.colFg
            font.family: "Symbols Nerd Font"
            font.pixelSize: root.fontSize
        }
    }
}
