import Quickshell
import qs
import qs.components.general
import qs.components.sidebar
import qs.services
import QtQuick

SidebarThemePill {
    Column {
        id: systemInfoColumn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.centerIn: parent
        spacing: 3

        // Memory
        Text {
            text: ""
            font.family: ThemeFonts.symbols
            font.pointSize: 12
            color: ThemeColors.text
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            text: `${Math.round(SystemInfo.memUsedPct * 100).toString().padStart(2, "0")}`
            font.family: ThemeFonts.font
            font.pointSize: 10
            color: ThemeColors.rose
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }

        HSeperator {
            seperatorWidth: ThemeMetrics.sidebarPillWidth
            seperatorHeight: 3
        }

        // Cpu
        Text {
            text: ""
            font.family: ThemeFonts.symbols
            font.pointSize: 12
            color: ThemeColors.text
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            text: `${Math.round(SystemInfo.cpuUsage * 100).toString().padStart(2, "0")}`
            font.family: ThemeFonts.font
            font.pointSize: 10
            color: ThemeColors.rose
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }

        HSeperator {
            seperatorWidth: ThemeMetrics.sidebarPillWidth
            seperatorHeight: 3
        }

        // Temp
        Text {
            text: `${getIcon(SystemInfo.tempC)}`
            font.family: ThemeFonts.symbols
            font.pointSize: 12
            color: SystemInfo.tempC >= 70 ? ThemeColors.love : ThemeColors.text
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
            font.family: ThemeFonts.font
            font.pointSize: 10
            color: ThemeColors.rose
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
