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

    implicitWidth: ThemeMetrics.fullSidebarWidth
    exclusiveZone: ThemeMetrics.fullSidebarWidth - ThemeMetrics.sidebarCurveSize

    color: "transparent"
    Shape {
        id: backgroundShape
        ShapePath {
            strokeWidth: 0
            fillColor: ThemeColors.surface
            startX: 0
            startY: 0
            PathLine {
                x: 0
                relativeY: root.height
            }
            PathLine {
                relativeX: ThemeMetrics.fullSidebarWidth
                relativeY: 0
            }
            PathArc {
                relativeX: -1 * ThemeMetrics.sidebarCurveSize
                relativeY: -1 * ThemeMetrics.sidebarCurveSize
                radiusX: ThemeMetrics.sidebarCurveRadius
                radiusY: ThemeMetrics.sidebarCurveRadius
            }
            PathLine {
                x: ThemeMetrics.fullSidebarWidth - ThemeMetrics.sidebarCurveSize
                y: ThemeMetrics.sidebarCurveSize
            }
            PathArc {
                relativeX: ThemeMetrics.sidebarCurveSize
                relativeY: -1 * ThemeMetrics.sidebarCurveSize
                radiusX: ThemeMetrics.sidebarCurveRadius
                radiusY: ThemeMetrics.sidebarCurveRadius
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
