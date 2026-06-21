pragma ComponentBehavior: Bound

import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import qs
import qs.components.general

Rectangle {
    id: root

    required property Notification modelData
    property bool hasImage: modelData.image || modelData.appIcon
    property list<NotificationAction> actualActions: modelData.actions.filter(action => action.text.trim() != "")

    implicitHeight: contentRow.height + Theme.generalPadding

    color: Theme.overlay
    radius: Theme.notifRadius

    border.color: modelData.urgency == NotificationUrgency.Critical ? Theme.love : root.modelData.urgency == NotificationUrgency.Low ? Theme.foam : Theme.rose
    border.width: Theme.generalBorder

    RowLayout {
        id: contentRow
        spacing: Theme.notifPaddingSize
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right

            topMargin: Theme.notifPaddingSize
            bottomMargin: Theme.notifPaddingSize
            leftMargin: Theme.notifPaddingSize
        }

        Image {
            visible: getImageSource(root.modelData)

            source: getImageSource(root.modelData)

            Layout.preferredHeight: Theme.notifIconSize
            Layout.preferredWidth: Theme.notifIconSize

            Component.onCompleted: {
                console.info(height.toString() + " " + width.toString());
            }

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignRight

            fillMode: Image.PreserveAspectFit
            mipmap: true

            MouseArea {
                anchors.fill: parent

                onClicked: root.modelData.dismiss()
            }

            function getImageSource(notif) {
                if (notif.image) {
                    return notif.image;
                } else if (notif.appIcon) {
                    return notif.appIcon;
                } else {
                    if (notif.urgency == NotificationUrgency.Low) {
                        return "../../assets/icons/niri-icons/niri-foam.svg"
                    } else if (notif.urgency == NotificationUrgency.Normal) {
                        return "../../assets/icons/niri-icons/niri-rose.svg"
                    } else if (notif.urgency == NotificationUrgency.Critical) {
                        return "../../assets/icons/niri-icons/niri-love.svg"
                    } else {
                        return false
                    }
                }
            }
        }

        ColumnLayout {
            spacing: 0
            Layout.fillHeight: true
            Layout.fillWidth: true

            Item {
                Layout.fillHeight: true
            }

            Text {
                text: root.modelData.summary
                font.family: Theme.boldFont
                color: root.modelData.urgency == NotificationUrgency.Critical ? Theme.love : root.modelData.urgency == NotificationUrgency.Low ? Theme.foam : Theme.rose

                Layout.fillWidth: true
                Layout.rightMargin: Theme.notifRightMargin * 2
                Layout.topMargin: 0

                wrapMode: Text.WordWrap
                elide: Text.ElideRight

                MouseArea {
                    anchors.fill: parent

                    onClicked: root.modelData.dismiss()
                }
            }

            Text {
                text: root.modelData.body
                font.family: Theme.font
                color: Theme.text

                Layout.fillWidth: true
                Layout.fillHeight: !root.hasImage ? true : false
                Layout.rightMargin: Theme.notifRightMargin

                maximumLineCount: Theme.notifMaxLines
                wrapMode: Text.Wrap
                elide: Text.ElideRight

                MouseArea {
                    anchors.fill: parent

                    onClicked: root.modelData.dismiss()
                }
            }

            RowLayout {
                id: actionRow
                spacing: Theme.notifPaddingSize

                Repeater {
                    id: actionButtons
                    model: root.actualActions

                    ThemeButton {
                        required property NotificationAction modelData
                        text: modelData.text
                        pointSize: 10

                        backgroundRadius: Theme.notifRadius
                        heightPadding: 0
                        widthPadding: 0

                        Layout.fillWidth: true
                        Layout.rightMargin: Theme.notifRightMargin

                        onClicked: modelData.invoke()
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}
