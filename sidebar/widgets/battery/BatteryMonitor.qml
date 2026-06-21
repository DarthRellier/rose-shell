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
        spacing: Theme.smallSpacing

        Text {
            text: `${getSymbol(Battery.battery.percentage, Battery.battery.state == 1)}`
            font.family: Theme.symbols
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
                    return Theme.text
                } else if (Math.round(chargePct * 10) * 10 < 30) {
                    return charging ? Theme.gold : Theme.love
                } else if (charging) {
                    return Theme.rose
                } else {
                    return Theme.text;
                }
            }
        }

        Text {
            id: batterytext
            text: Math.min(Math.round((Battery.battery.percentage * 100)), 99).toString().padStart(2, "0")
            font.family: Theme.font
            font.pointSize: 11
            color: Theme.rose
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
