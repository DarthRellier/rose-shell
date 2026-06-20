pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs
import qs.services
import qs.components.sidebar
import qs.sidebar.widgets.workspaces

SidebarThemePill {
    height: ((rp.count + 1)  * 28.75) + 20
    
    ListView {
        id: rp
        model: Niri.workspaces
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        spacing: 10
        topMargin: 20
        bottomMargin: 20

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
