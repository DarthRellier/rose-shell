pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell.Wayland
import qs.lockscreen.widgets

WlSessionLockSurface {
    id: root
    required property LockContext context
    required property WlSessionLock lockscreen

    signal unlockAnimFinished

    LockWallpaper {}

    ColumnLayout {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        // Time + Date
        LockDate {
            Layout.fillWidth: true
        }

        LockClock {
            Layout.fillWidth: true
        }

        // Lock Indicator
        LockIcon {
            context: root.context

            Layout.preferredHeight: 150
            Layout.preferredWidth: 150

            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 15
            Layout.bottomMargin: 15

            onIconAnimFinished: {
                root.unlockAnimFinished();
            }
        }

        // Instructions
        LockInstructions {
            context: root.context

            Layout.alignment: Qt.AlignHCenter
        }

        // Seperator
        Rectangle {
            Layout.preferredHeight: 25
            Layout.preferredWidth: 1
            color: "transparent"
        }

        LockPasswordBox {
            id: passwordBox
            context: root.context
        }

        LockLayout {
            passwordBox: passwordBox

            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.topMargin: 6
        }
    }
}
