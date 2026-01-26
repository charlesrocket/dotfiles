pragma ComponentBehavior: Bound

import QtQuick
import QtQml
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
    id: root

    property color colBg: null
    property color colMain: null
    property color colBorder: null
    property int slideDuration: 250
    property int fontSize: 14
    property string fontFamily: "FiraCode Nerd Font"
    property string icon: "󱣶"
    property real temperature: 0
    property string ip: "n/a"

    Process {
        id: weatherProcess
        command: ["weather-req"]
        running: true

        stdout: SplitParser {
            onRead: function (data) {
                if (!data)
                    return;

                try {
                    var jsonString = data.trim();
                    var start = jsonString.indexOf('{');
                    var end = jsonString.lastIndexOf('}');

                    if (start !== -1 && end !== -1) {
                        jsonString = jsonString.substring(start, end + 1);
                        var weatherData = JSON.parse(jsonString);

                        if (weatherData.conditions) {
                            root.icon = weatherData.conditions;
                        }

                        if (weatherData.temp) {
                            root.temperature = weatherData.temp;
                        }

                        if (weatherData.ip) {
                            root.ip = weatherData.ip;
                        }
                    }
                } catch (error) {
                    console.error("Failed to parse weather data:", error, "Raw data:", data);
                }
            }
        }

        Component.onCompleted: running = true
    }

    Timer {
        id: tmr
        interval: 1200
        running: true
        repeat: true
        onTriggered: {
            var randomValue = Math.floor(Math.random() * (680000 - 100000) + 100000);
            tmr.interval = 1000000 + randomValue;
            weatherProcess.running = false;
            weatherProcess.running = true;
        }
    }

    implicitWidth: (hoverDetector.containsMouse ? infoContainer.width + 8 : 0) + weatherText.width
    implicitHeight: weatherText.height

    Behavior on implicitWidth {
        NumberAnimation {
            duration: root.slideDuration
            easing.type: Easing.OutCubic
        }
    }

    Rectangle {
        id: infoContainer
        anchors.right: weatherContainer.left
        anchors.rightMargin: hoverDetector.containsMouse ? 8 : 0
        anchors.verticalCenter: parent.verticalCenter
        width: infoText.contentWidth + 4
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
            text: root.temperature + "󰔄"
            color: root.colMain
            font {
                family: root.fontFamily
                pixelSize: root.fontSize
                bold: true
            }
        }
    }

    Item {
        id: weatherContainer
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: weatherText.width
        height: weatherText.height

        Text {
            id: weatherText

            text: root.icon
            color: root.colMain
            font.bold: true

            font {
                family: "Symbols Nerd Font"
                pixelSize: root.fontSize
                bold: true
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
