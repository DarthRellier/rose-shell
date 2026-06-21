pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs
import qs.services
import qs.components.sidebar
import qs.sidebar.widgets.workspaces

SidebarThemePill {
    height: ((rp.count - 1) * (ThemeMetrics.workspaceButtonHeightInactive + ThemeMetrics.generalSpacing)) + ThemeMetrics.workspaceButtonHeightActive + ThemeMetrics.sidebarPadding
    
    ListView {
        id: rp
        model: Niri.workspaces
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        spacing: ThemeMetrics.generalSpacing
        topMargin: ThemeMetrics.generalPadding / 2
        bottomMargin: ThemeMetrics.generalPadding / 2

        delegate: WorkspaceButton {
            required property var modelData

            workspaceId: modelData.id
            workspaceIdx: modelData.idx
            workspaceName: modelData.name
            
            count: rp.count

            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
