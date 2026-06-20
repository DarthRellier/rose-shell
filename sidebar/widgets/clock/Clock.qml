import Quickshell
import qs
import qs.services
import qs.components.sidebar
import QtQuick
import QtQuick.Layouts

SidebarThemePill {
    Column {
        id: timeCol
        anchors.centerIn: parent

        spacing: 2
        Text {
            text: Time.clock.hours != 0 && Time.clock.hours != 12 ? (Time.clock.hours % 12).toString().padStart(2, "0") : 12
            color: Theme.rose
            font.family: Theme.font
            font.weight: Font.DemiBold
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: Time.clock.hours < 12 ? "AM" : "PM"
            font.family: Theme.font
            font.pointSize: 6
            color: Theme.subtle
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: Time.clock.minutes.toString().padStart(2, "0")
            color: Theme.rose
            font.family: Theme.font
            font.weight: Font.DemiBold
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
