import Quickshell
import qs
import qs.components
import qs.services
import QtQuick

Rectangle {
    implicitWidth: 27.5
    implicitHeight: systemInfoColumn.height + 20
    radius: width / 2
    color: Theme.overlay
    
    Column {
        id: systemInfoColumn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.centerIn: parent
        spacing: 3

        // Memory
        Text {
            text: ""
            font.family: Theme.symbols
            font.pointSize: 12
            color: Theme.text
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            text: `${Math.round(SystemInfo.memUsedPct * 100).toString().padStart(2, "0")}`
            font.family: Theme.winky
            font.pointSize: 10
            color: Theme.rose
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }

        HSeperator {
            seperatorWidth: 27.5
            seperatorHeight: 3
        }

        // Cpu
        Text {
            text: ""
            font.family: Theme.symbols
            font.pointSize: 12
            color: Theme.text
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            text: `${Math.round(SystemInfo.cpuUsage * 100).toString().padStart(2, "0")}`
            font.family: Theme.winky
            font.pointSize: 10
            color: Theme.rose
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }

        HSeperator {
            seperatorWidth: 27.5
            seperatorHeight: 3
        }

        // Temp
        Text {
            text: `${getIcon(SystemInfo.tempC)}`
            font.family: Theme.symbols
            font.pointSize: 12
            color: SystemInfo.tempC >= 70 ? Theme.love : Theme.text
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter

            function getIcon(temp) {
                if (temp < 30) {
                    return "";
                } else if (temp < 45) {
                    return "";
                } else if (temp < 60) {
                    return "";
                } else if (temp < 70) {
                    return "";
                } else {
                    return "";
                }
            }
        }

        Text {
            text: `${Math.round(SystemInfo.tempC)}`
            font.family: Theme.winky
            font.pointSize: 10
            color: Theme.rose
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
