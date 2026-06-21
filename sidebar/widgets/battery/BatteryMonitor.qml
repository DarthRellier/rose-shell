import Quickshell
import Quickshell.Widgets
import qs
import qs.services
import qs.components.sidebar
import QtQuick

SidebarThemePill {
    Column {
        id: batteryColumn
        anchors.centerIn: parent
        spacing: ThemeMetrics.smallSpacing

        Text {
            text: `${getSymbol(Battery.battery.percentage, Battery.battery.state == 1)}`
            font.family: ThemeFonts.symbols
            font.pointSize: 12
            horizontalAlignment: Text.AlignHCenter
            color: getColor(Battery.battery.percentage, Battery.battery.state == 1)
            anchors {
                left: parent.left
                right: parent.right
            }

            function getSymbol(chargePct, charging) {
                if (charging) {
                    switch (Math.round(chargePct * 10) * 10) {
                    case 0:
                        return "󰢟";
                    case 10:
                        return "󰢜";
                    case 20:
                        return "󰂆";
                    case 30:
                        return "󰂇";
                    case 40:
                        return "󰂈";
                    case 50:
                        return "󰢝";
                    case 60:
                        return "󰂉";
                    case 70:
                        return "󰢞";
                    case 80:
                        return "󰂊";
                    case 90:
                        return "󰂋";
                    case 100:
                        return "󰂅";
                    }
                } else {
                    switch (Math.round(chargePct * 10) * 10) {
                    case 0:
                        return "󰂎";
                    case 10:
                        return "󰁺";
                    case 20:
                        return "󰁻";
                    case 30:
                        return "󰁼";
                    case 40:
                        return "󰁽";
                    case 50:
                        return "󰁾";
                    case 60:
                        return "󰁿";
                    case 70:
                        return "󰂀";
                    case 80:
                        return "󰂁";
                    case 90:
                        return "󰂂";
                    case 100:
                        return "󰁹";
                    }
                }
            }

            function getColor(chargePct, charging) {
                if (Math.round(chargePct * 10) * 10 == 100) {
                    return ThemeColors.text
                } else if (Math.round(chargePct * 10) * 10 < 30) {
                    return charging ? ThemeColors.gold : ThemeColors.love
                } else if (charging) {
                    return ThemeColors.rose
                } else {
                    return ThemeColors.text;
                }
            }
        }

        Text {
            id: batterytext
            text: Math.min(Math.round((Battery.battery.percentage * 100)), 99).toString().padStart(2, "0")
            font.family: ThemeFonts.font
            font.pointSize: 11
            color: ThemeColors.rose
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
