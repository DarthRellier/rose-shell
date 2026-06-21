pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Shapes
import qs.sidebar.widgets.clock
import qs.sidebar.widgets.workspaces
import qs.sidebar.widgets.idleInhibit
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

    implicitWidth: Theme.fullSidebarWidth
    exclusiveZone: Theme.fullSidebarWidth - Theme.sidebarCurveSize

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
                relativeX: Theme.fullSidebarWidth
                relativeY: 0
            }
            PathArc {
                relativeX: -1 * Theme.sidebarCurveSize
                relativeY: -1 * Theme.sidebarCurveSize
                radiusX: Theme.sidebarCurveRadius
                radiusY: Theme.sidebarCurveRadius
            }
            PathLine {
                x: Theme.fullSidebarWidth - Theme.sidebarCurveSize
                y: Theme.sidebarCurveSize
            }
            PathArc {
                relativeX: Theme.sidebarCurveSize
                relativeY: -1 * Theme.sidebarCurveSize
                radiusX: Theme.sidebarCurveRadius
                radiusY: Theme.sidebarCurveRadius
            }
        }
    }

    // Top Widgets
    Column {
        spacing: 10
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -10
        anchors.topMargin: 20

        IdleInhibitButton  {
            inhibitWindow: root
        }
        WorkspaceIndicator {}
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

        BatteryMonitor {
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
