pragma ComponentBehavior: Bound

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
    property real heightPadding: 20
    property real widthPadding: 0
    property bool autoImplicitHeight: false
    property bool autoImplicitWidth: false

    property bool useSymbolFont: false

    topPadding: heightPadding / 2
    bottomPadding: heightPadding / 2
    leftPadding: widthPadding / 2
    rightPadding: widthPadding / 2

    Component.onCompleted: {
        if (button.autoImplicitHeight) {
            button.implicitHeight = backgroundRect.implicitHeight
        }

        if (button.autoImplicitWidth) {
            button.implicitWidth = backgroundRect.implicitWidth
        }
    }
    
    contentItem: Text {
        id: contentText
        horizontalAlignment: Text.AlignHCenter
        
        text: button.text
        color: button.pressed ? button.pressedFg : button.normalFg

        font.family: button.useSymbolFont ? Theme.symbols : Theme.font
        font.pointSize: button.pointSize

        elide: Text.ElideRight
        wrapMode: Text.WordWrap
    }

    background: Rectangle {
        id: backgroundRect

        implicitHeight: parent.childrenRect.height + button.heightPadding
        implicitWidth: parent.childrenRect.width + button.widthPadding

        radius: button.backgroundRadius || width / 2

        color: button.pressed ? button.pressedBg : button.normalBg
    }
}
