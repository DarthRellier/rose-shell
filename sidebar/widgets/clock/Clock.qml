import Quickshell
import qs
import qs.services
import QtQuick
import QtQuick.Layouts

Rectangle {
    implicitWidth: 27.5
    implicitHeight: timeCol.height + 15
    radius: width / 2

    color: Theme.overlay

    Column {
        id: timeCol
        anchors.centerIn: parent

        spacing: 2
        Text {
            text: Time.clock.hours != 0 && Time.clock.hours != 12 ? (Time.clock.hours % 12).toString().padStart(2, "0") : 12
            color: Theme.rose
            font.family: Theme.winky
            font.weight: Font.DemiBold
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: Time.clock.hours < 12 ? "AM" : "PM"
            font.family: Theme.winky
            font.pointSize: 6
            color: Theme.subtle
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: Time.clock.minutes.toString().padStart(2, "0")
            color: Theme.rose
            font.family: Theme.winky
            font.weight: Font.DemiBold
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
