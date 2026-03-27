import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs

PanelWindow {
    anchors {
        right: true
        bottom: true
    }

    margins.bottom: 10
    margins.right: 15

    implicitHeight: activateLinux.height
    implicitWidth: activateLinux.width

    color: "transparent"

    Component.onCompleted: {
        if (this.WlrLayershell != null) {
            this.WlrLayershell.layer = WlrLayer.Bottom;
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            Quickshell.execDetached(["xdg-open", "https://xkcd.com"])
        }
    }

    ColumnLayout {
        id: activateLinux

        spacing: -2

        Text {
            text: "Activate Linux"

            font.pointSize: 18
            color: Theme.text
            opacity: 0.75
        }

        Text {
            text: "or don't i guess"

            Layout.fillWidth: true

            font.pointSize: 8
            color: Theme.text
            horizontalAlignment: Text.AlignRight
        }
    }
}
