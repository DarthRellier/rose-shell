import QtQuick
import qs

Text {

    text: Qt.formatDate(new Date(), "dddd, MMMM d, yyyy")

    font.pointSize: 11
    font.family: Theme.font

    color: Theme.rose
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
}
