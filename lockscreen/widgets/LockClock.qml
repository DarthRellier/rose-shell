import QtQuick
import qs
import qs.services

Text {
    text: Qt.formatDateTime(Time.clock.date, "h:mm AP")

    font.pointSize: 48
    font.family: Theme.font

    color: Theme.rose
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
}
