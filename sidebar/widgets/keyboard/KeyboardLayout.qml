import Quickshell
import QtQuick
import qs
import qs.components.sidebar
import qs.services

SidebarThemeButton {
    text: Niri.shortenedKeyboardLayout.toUpperCase()

    normalFg: Theme.rose
    pressedFg: Theme.rose
    pointSize: 10.5

    // topPadding: 10
    // bottomPadding: 10

    // backgroundRadius: width / 2

    onPressed: {
        Niri.switchLayout()
    }
}
