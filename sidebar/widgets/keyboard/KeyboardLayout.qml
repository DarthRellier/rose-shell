import Quickshell
import QtQuick
import qs
import qs.components
import qs.services

ThemeButton {
    id: button
    text: Niri.shortenedKeyboardLayout.toUpperCase()

    implicitWidth: 27.5

    normalFg: Theme.rose
    pressedFg: Theme.rose
    pointSize: 10.5

    topPadding: 10
    bottomPadding: 10

    backgroundRadius: width / 2

    onPressed: {
        Niri.switchLayout()
    }
}
