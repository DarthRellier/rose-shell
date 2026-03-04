pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs
import qs.services
import qs.sidebar.widgets.workspaces

Rectangle {
    width: rp.contentWidth + 25
    height: (rp.count  * 28.75) + 48.75
    anchors.horizontalCenter: parent.horizontalCenter
    radius: width / 2
    y: 20
    color: Theme.overlay
    
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
