pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs
import qs.services
import qs.components.sidebar
import qs.sidebar.widgets.workspaces

SidebarThemePill {
    height: ((rp.count - 1) * (Theme.workspaceButtonHeightInactive + Theme.generalSpacing)) + Theme.workspaceButtonHeightActive + Theme.sidebarPadding
    
    ListView {
        id: rp
        model: Niri.workspaces
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.generalSpacing
        topMargin: Theme.generalPadding / 2
        bottomMargin: Theme.generalPadding / 2

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
