import Quickshell
import qs
import QtQuick

Column {
    id: root
    property real seperatorWidth
    property real seperatorHeight
    
    Item {
        implicitHeight: root.seperatorHeight
        implicitWidth: root.seperatorWidth
    }

    Rectangle {
        implicitHeight: root.seperatorHeight
        implicitWidth: root.seperatorWidth * 0.75
        radius: width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.muted
    }

    Item {
        implicitHeight: root.seperatorHeight * 2
        implicitWidth: root.seperatorWidth
    }
}
