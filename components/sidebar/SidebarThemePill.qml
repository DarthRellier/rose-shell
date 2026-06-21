import QtQuick
import qs

Rectangle {
    implicitWidth: Theme.sidebarPillWidth
    implicitHeight: childrenRect.height + Theme.sidebarPadding
    radius: width / 2

    color: Theme.overlay
}
