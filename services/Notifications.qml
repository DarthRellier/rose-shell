pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

    readonly property var trackedNotifications: server.trackedNotifications
    readonly property bool empty: server.trackedNotifications.values.length == 0

    NotificationServer {
        id: server

        bodySupported: true
        actionsSupported: true
        imageSupported: true

        onNotification: (notification) => {
            notification.tracked = true
        }
    }
}
