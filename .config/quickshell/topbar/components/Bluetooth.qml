import Quickshell.Bluetooth

import QtQuick
import QtQuick.Layouts

Text {
    id: root

    property color colMain: "#b0b4bc"
    property string fontFamily: "Symbols Nerd Font"
    property int fontSize: 14

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
    color: root.colMain
    font {
        family: root.fontFamily
        pixelSize: root.fontSize
        bold: true
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            if (root.adapter) {
                root.adapter.powered = !root.adapter.powered;
            }
        }
    }
}
