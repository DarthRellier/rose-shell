import Quickshell
import QtQuick
import qs
import qs.components.sidebar
import qs.services

SidebarThemeButton {
    text: Niri.shortenedKeyboardLayout.toUpperCase()

    normalFg: ThemeColors.rose
    pressedFg: ThemeColors.rose
    pointSize: 10.5

    onPressed: {
        Niri.switchLayout()
    }
}
