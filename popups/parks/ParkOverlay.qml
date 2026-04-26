import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs
import qs.services

PanelWindow {
    anchors {
        right: true
        bottom: true
    }

    margins.bottom: 10
    margins.right: 15

    implicitHeight: parkNameText.height
    implicitWidth: parkNameText.width

    color: "transparent"

    Component.onCompleted: {
        if (this.WlrLayershell != null) {
            this.WlrLayershell.layer = WlrLayer.Bottom;
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            doubleClickTimer.restart()
        }

        onDoubleClicked: {
            doubleClickTimer.stop()
            Quickshell.execDetached(["xdg-open", "https://xkcd.com"]);
        }

        // Prevent Double Handling
        Timer {
            id: doubleClickTimer
            interval: 300
            onTriggered: Quickshell.execDetached(["xdg-open", "https://parks.wa.gov"]);
        }
    }

    Text {
        id: parkNameText
        text: Park.parkName

        font.pointSize: 18
        font.family: Theme.varela
        color: Park.isLight ? Theme.highlightMed : Theme.muted
    }
}
