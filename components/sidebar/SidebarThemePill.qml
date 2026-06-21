import QtQuick
import qs

Rectangle {
    implicitWidth: ThemeMetrics.sidebarPillWidth
    implicitHeight: childrenRect.height + ThemeMetrics.sidebarPadding
    radius: width / 2

    color: ThemeColors.overlay
}
