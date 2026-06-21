import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import qs
import qs.services

RoundButton {
    id: root

    required property var workspaceId
    required property var workspaceIdx
    required property var count
    required property string workspaceName
    property bool active: Niri.activeWorkspaceId === workspaceId
    property var color: Theme.subtle

    implicitWidth: Theme.sidebarPillWidth / 2
    radius: width / 2
    background: Rectangle {
        implicitWidth: root.width
        implicitHeight: root.height
        radius: root.radius
        color: root.color
    }

    states: [
        State {
            name: "active"
            when: root.active
            PropertyChanges {
                target: root

                height: Theme.workspaceButtonHeightActive
                color: workspaceName ? Theme.foam : Theme.rose
            }
        },
        State {
            name: "inactive"
            when: !root.active
            PropertyChanges {
                target: root

                height: Theme.workspaceButtonHeightInactive
                color: workspaceName ? Theme.foam : Theme.subtle
            }
        }
    ]

    transitions: [
        Transition {
            to: "active"

            NumberAnimation {
                property: "height"
                easing.type: Easing.OutCubic
                duration: 100
            }
        }
    ]

    Process {
        id: switchWorkspace
        running: false
        command: ["niri", "msg", "action", "focus-workspace", root.workspaceIdx]
    }

    onClicked: {
        switchWorkspace.running = true;
    }
}
