pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Shapes
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

    implicitWidth: 60
    exclusiveZone: 40

    color: "transparent"
    Shape {
        id: backgroundShape
        ShapePath {
            strokeWidth: 0
            fillColor: Theme.surface
            startX: 0
            startY: 0
            PathLine {
                x: 0
                relativeY: root.height
            }
            PathLine {
                relativeX: 60
                relativeY: 0
            }
            PathArc {
                relativeX: -20
                relativeY: -20
                radiusX: 20
                radiusY: 20
            }
            PathLine {
                x: 40
                y: 20
            }
            PathArc {
                relativeX: 20
                relativeY: -20
                radiusX: 20
                radiusY: 20
            }
        }
    }

    // Top Widgets
    WorkspaceIndicator {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -10
    }

    // Center Widgets
    Clock {
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -10
    }

    // Bottom Widgets
    Column {
        spacing: 10
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -10
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
