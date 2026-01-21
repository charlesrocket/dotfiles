import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking

RowLayout {
    id: root
    spacing: 6

    property int fontSize: 14
    property color colFg: "#ffffff"

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

    Text {
        text: root.uplinkIcon
        color: root.colFg
        font.family: "Symbols Nerd Font"
        font.pixelSize: root.fontSize
    }

    Text {
        text: isPrimaryWifi ? "" : "󰈀"
        color: root.colFg
        font.family: "Symbols Nerd Font"
        font.pixelSize: root.fontSize
    }
}
