pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs
import qs.services

LazyLoader {
    active: !Notifications.empty 

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: list

            required property var modelData
            screen: modelData

            anchors {
                top: true
                right: true
                bottom: true
            }

            margins {
                top: Theme.notifPaddingSize
                right: Theme.notifPaddingSize
            }

            width: Theme.notifWidth

            color: "transparent"

            exclusionMode: ExclusionMode.Ignore

            mask: Region {item: column}

            Component.onCompleted: {
                if (this.WlrLayershell != null) {
                    this.WlrLayershell.layer = WlrLayer.Overlay;
                }
            }

            ColumnLayout {
                id: column
                spacing: Theme.notifPaddingSize

                Repeater {
                    model: Notifications.trackedNotifications

                    NotificationPopup {
                        width: list.width
                    }
                }
            }
        }
    }
}
