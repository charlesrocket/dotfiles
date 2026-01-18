import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

RowLayout {
    id: root
    spacing: 6

    property string fontFamily: "Hack Nerd Font"
    property int fontSize: 14
    property color colCpu: "#7aa2f7"
    property color colMem: "#9ece6a"
    property color colDisk: "#bf00ff"
    property color colWarning: "#ffd700"
    property color colCritical: "#cc0000"
    property color colBar: null
    property string mountPoint: "/"
    property int barWidth: 8
    property int barHeight: 16
    property int cpuCores: 1

    property real cpuLoad: 0.0
    property real cpuPercent: 0.0
    property int memPercent: 0
    property int diskPercent: 0

    Process {
        id: coreDetect
        command: ["sysctl", "-n", "hw.ncpu"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const cores = parseInt(data.trim());
                if (!isNaN(cores) && cores > 0) {
                    root.cpuCores = cores;
                }
            }
        }
    }

    Process {
        id: cpuProc
        command: ["sh", "-c", "sysctl -n vm.loadavg | awk '{print $2}'"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const load = parseFloat(data.trim());

                if (!isNaN(load)) {
                    root.cpuLoad = load;
                    root.cpuPercent = Math.min((load / root.cpuCores) * 100, 100);
                }
            }
        }
    }

    Process {
        id: memProc
        command: ["sh", "-c", "sysctl hw.physmem hw.usermem | awk '{if(NR==1) physmem=$2; if(NR==2) usermem=$2} END {print int((physmem-usermem)/physmem*100)}'"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const percent = parseInt(data.trim());
                if (!isNaN(percent)) {
                    root.memPercent = percent;
                }
            }
        }
    }

    Process {
        id: diskProc
        command: ["sh", "-c", `df -h ${root.mountPoint} | tail -1 | awk '{print $5}' | sed 's/%//'`]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const percent = parseInt(data.trim());
                if (!isNaN(percent)) {
                    root.diskPercent = percent;
                }
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true;
            memProc.running = true;
        }
    }

    Timer {
        interval: 150000
        running: true
        repeat: true
        onTriggered: diskProc.running = true
    }

    RowLayout {
        spacing: 6

        Text {
            text: ""
            color: root.colCpu
            font.family: "Symbols Nerd Font"
            font.pixelSize: root.fontSize
            font.bold: true
        }

        Rectangle {
            Layout.preferredWidth: root.barWidth
            Layout.preferredHeight: root.barHeight
            color: root.colBar
            border.width: 1
            border.color: Qt.darker(root.colCpu, 1.5)
            radius: 2

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 1
                height: (root.cpuPercent / 100.0) * (parent.height - 2)
                radius: 1
                color: {
                    if (root.cpuPercent > 90)
                        return root.colCritical;
                    if (root.cpuPercent > 75)
                        return root.colWarning;
                    return root.colCpu;
                }

                Behavior on height {
                    NumberAnimation {
                        duration: 250
                    }
                }
            }
        }
    }

    RowLayout {
        spacing: 6

        Text {
            text: "󰚗"
            color: root.colMem
            font.family: "Symbols Nerd Font"
            font.pixelSize: root.fontSize
            font.bold: true
        }

        Rectangle {
            Layout.preferredWidth: root.barWidth
            Layout.preferredHeight: root.barHeight
            color: root.colBar
            border.width: 1
            border.color: Qt.darker(root.colMem, 1.5)
            radius: 2

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 1
                height: (root.memPercent / 100.0) * (parent.height - 2)
                radius: 1
                color: {
                    if (root.memPercent > 90)
                        return root.colCritical;
                    if (root.memPercent > 75)
                        return root.colWarning;
                    return root.colMem;
                }

                Behavior on height {
                    NumberAnimation {
                        duration: 250
                    }
                }
            }
        }
    }

    RowLayout {
        spacing: 6

        Text {
            text: ""
            color: root.colDisk
            font.family: "Symbols Nerd Font"
            font.pixelSize: root.fontSize
            font.bold: true
        }

        Rectangle {
            Layout.preferredWidth: root.barWidth
            Layout.preferredHeight: root.barHeight
            color: root.colBar
            border.width: 1
            border.color: Qt.darker(root.colDisk, 1.5)
            radius: 2

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 1
                height: (root.diskPercent / 100.0) * (parent.height - 2)
                radius: 1
                color: {
                    if (root.diskPercent > 90)
                        return root.colCritical;
                    if (root.diskPercent > 80)
                        return root.colWarning;
                    return root.colDisk;
                }

                Behavior on height {
                    NumberAnimation {
                        duration: 250
                    }
                }
            }
        }
    }
}
