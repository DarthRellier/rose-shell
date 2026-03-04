pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs
import qs.services
import qs.components

Rectangle {
    id: root

    required property Notification modelData
    property bool hasImage: modelData.image || modelData.appIcon

    implicitHeight: contentRow.height + 16

    color: Theme.overlay
    radius: 8

    border.color: modelData.urgency == NotificationUrgency.Critical ? Theme.love : root.modelData.urgency == NotificationUrgency.Low ? Theme.foam : Theme.rose
    border.width: 2

    RowLayout {
        id: contentRow
        spacing: 8
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: actionRow.top

            topMargin: 8
            bottomMargin: 8
            leftMargin: 8
        }

        Image {
            visible: root.hasImage

            source: getImageSource(root.modelData)

            Layout.preferredHeight: 50
            Layout.preferredWidth: 50
            // Layout.preferredHeight: 100
            // Layout.preferredWidth: 100

            Component.onCompleted: {
                console.info(height.toString() + " " + width.toString());
            }

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignRight

            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent

                onClicked: root.modelData.dismiss()
            }

            function getImageSource(notif) {
                if (notif.image) {
                    return notif.image;
                } else if (notif.appIcon) {
                    return notif.appIcon;
                }
            }
        }

        ColumnLayout {
            spacing: 0
            Layout.fillHeight: true
            Layout.fillWidth: true

            Text {
                text: root.modelData.summary
                font.family: Theme.varela
                color: root.modelData.urgency == NotificationUrgency.Critical ? Theme.love : root.modelData.urgency == NotificationUrgency.Low ? Theme.foam : Theme.rose
                font.bold: true

                Layout.fillWidth: true
                Layout.rightMargin: 32
                Layout.topMargin: 0
                Layout.bottomMargin: 0

                wrapMode: Text.WordWrap
                elide: Text.ElideRight

                MouseArea {
                    anchors.fill: parent

                    onClicked: root.modelData.dismiss()
                }
            }

            Text {
                text: root.modelData.body
                font.family: Theme.varela
                color: Theme.text

                Layout.fillWidth: true
                Layout.fillHeight: !root.hasImage ? true : false
                Layout.rightMargin: 16
                Layout.bottomMargin: 2

                maximumLineCount: 4
                wrapMode: Text.Wrap
                elide: Text.ElideRight

                MouseArea {
                    anchors.fill: parent

                    onClicked: root.modelData.dismiss()
                }
            }

            RowLayout {
                id: actionRow
                spacing: 4
                // anchors {
                //     bottom: parent.bottom
                //     left: parent.left
                //     right: parent.right
                //     bottomMargin: actionButtons.height > 0 ? 8 : 0
                // }

                Repeater {
                    id: actionButtons
                    model: root.modelData.actions

                    ThemeButton {
                        required property NotificationAction modelData
                        text: modelData.text
                        pointSize: 10

                        backgroundRadius: 16

                        Layout.fillWidth: true
                        Layout.topMargin: 2
                        Layout.rightMargin: 8

                        onClicked: modelData.invoke()
                    }
                }
            }
        }
    }
}
