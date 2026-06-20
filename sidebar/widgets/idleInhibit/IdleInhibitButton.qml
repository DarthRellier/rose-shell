import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import qs
import qs.services
import qs.components.sidebar

SidebarThemeButton {
    id: button

    required property QtObject inhibitWindow
    property bool inhibit

    Image {
        source: button.inhibit ? Qt.resolvedUrl("../../../assets/icons/niri-icons/niri-rose.svg") : Qt.resolvedUrl("../../../assets/icons/niri-icons/niri-subtle.svg")

        width: 30
        height: 50
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        mipmap: true
        fillMode: Image.PreserveAspectFit
    }
    
    implicitWidth: 27.5
    implicitHeight: 45

    normalFg: Theme.rose
    pressedFg: Theme.rose
    pointSize: 10.5

    topPadding: 10
    bottomPadding: 10

    onPressed: {
        button.inhibit = !button.inhibit
    }

    IdleInhibitor {
        id: idleBlocker
        window: button.inhibitWindow
        enabled: button.inhibit
        onEnabledChanged: {
            console.info("button pressed")
            console.info(enabled.toString())
        }
    }

    IdleMonitor {
        timeout: 150
        respectInhibitors: false
        onIsIdleChanged: {
            if (isIdle && idleBlocker.enabled) {
                console.info("hi")
                inhibitNotification.running = true
            }
        }
    }
    
    Process {
        id: inhibitNotification
        running: false
        command: ["notify-send", "Idle Inhibitor", "The idle inhibitor is currently active. If this is unintended, please turn it off to save power.", "--wait", "--urgency=low"]
    }
}
