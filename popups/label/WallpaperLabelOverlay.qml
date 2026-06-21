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

    margins.bottom: 3
    margins.right: 10

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
        text: Wallpaper.paperLabel

        font.pointSize: 18
        font.family: ThemeFonts.font
        color: Wallpaper.labelIsLight ? ThemeColors.highlightMed : ThemeColors.muted
    }
}
