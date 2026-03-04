pragma ComponentBehavior: Bound

import Quickshell
import qs
import QtQuick
import QtQuick.Controls

Button {
    id: button

    property color pressedBg: Theme.highlightMed
    property color normalBg: Theme.overlay
    property color pressedFg: Theme.text
    property color normalFg: Theme.text

    property real pointSize: 12

    property real backgroundRadius

    contentItem: Text {
        id: contentText
        horizontalAlignment: Text.AlignHCenter

        text: button.text
        color: button.pressed ? button.pressedFg : button.normalFg

        font.family: Theme.varela
        font.pointSize: button.pointSize

        elide: Text.ElideRight
        wrapMode: Text.WordWrap
    }

    background: Rectangle {
        id: backgroundRect
        color: button.pressed ? button.pressedBg : button.normalBg
        radius: button.backgroundRadius || 8
    }
}
