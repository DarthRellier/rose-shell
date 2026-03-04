pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import qs.sidebar.widgets.clock
import qs.sidebar.widgets.workspaces
import qs.sidebar.widgets.battery
import qs.sidebar.widgets.system
import qs.sidebar.widgets.keyboard
import qs.popups.systray
import qs

PanelWindow {
    id: root

    anchors {
        left: true
        top: true
        bottom: true
    }

    implicitWidth: 40

    color: "transparent"

    Rectangle {
        anchors.fill: parent

        topRightRadius: 10
        bottomRightRadius: 10

        color: Theme.surface
    }

    // Top Widgets
    WorkspaceIndicator {}

    // Center Widgets
    Clock {
        anchors.centerIn: parent
    }

    // Bottom Widgets
    Column {
        spacing: 10
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 20

        SystemMonitor {
            anchors.horizontalCenter: parent.horizontalCenter
        }

        SystemTrayList {
            parentWindowObject: root
            anchors.horizontalCenter: parent.horizontalCenter
        }

        KeyboardLayout {
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Battery {
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }
}
