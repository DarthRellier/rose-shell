pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs

Button {
    id: root

    required property var parentWindowObject
    property bool active: false
    property bool loaded: true
    property bool closeTimerRunning: true

    contentItem: Text {
        text: ""
        font.family: Theme.symbols
        font.pointSize: 14
        verticalAlignment: Text.AlignHCenter

        color: Theme.rose
    }

    background: Rectangle {
        color: root.pressed ? Theme.highlightMed : Theme.overlay
        radius: width / 2
    }

    leftPadding: (27.5 - contentItem.implicitWidth) / 2
    rightPadding: (27.5 - contentItem.implicitWidth) / 2
    topPadding: 10
    bottomPadding: 10

    onPressed: {
        root.loaded = true;
        root.active = !root.active;
    }
    LazyLoader {
        active: root.loaded
        
        PopupWindow {
            id: popup

            anchor.window: root.parentWindowObject

            anchor.rect.x: root.parentWindowObject.width
            anchor.rect.y: root.parentWindowObject.height - root.y - 20

            implicitWidth: 36
            implicitHeight: column.height + 20

            visible: true
            color: "transparent"

            Rectangle {
                id: contentRect
                implicitWidth: 28
                implicitHeight: column.height + 20
                color: Theme.overlay
                radius: width / 2

                x: root.active ? 8 : -28

                Behavior on x {
                    NumberAnimation {
                        duration: 100
                        onRunningChanged: {
                            if (!root.active && !running) {
                                root.loaded = false
                            }
                        }
                    }
                }

                ColumnLayout {
                    id: column

                    anchors.centerIn: parent

                    Repeater {
                        model: SystemTray.items

                        Image {
                            id: image
                            required property var modelData

                            source: modelData.icon

                            Layout.preferredHeight: 24
                            Layout.preferredWidth: 24
                            mipmap: true

                            MouseArea {
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                                onClicked: mouse => {
                                    if (mouse.button === Qt.RightButton) {
                                        if (image.modelData.onlyMenu) {
                                            image.modelData.display(popup, 43, image.y + image.height);
                                        }
                                        image.modelData.activate();
                                    } else if (mouse.button === Qt.LeftButton) {
                                        image.modelData.display(popup, 43, image.y + image.height / 2);
                                    } else {
                                        image.modelData.secondaryActivate();
                                    }
                                }
                            }
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    hoverEnabled: true
                    acceptedButtons: Qt.NoButton
                    propagateComposedEvents: true

                    onContainsMouseChanged: {
                        if (containsMouse) {
                            closeTimer.stop()
                        } else {
                            closeTimer.start()
                        }
                    }

                    Timer {
                        id: closeTimer
                        interval: 10000
                        running: true

                        onTriggered: {
                            root.active = false
                        }
                    }
                }
            }
        }
    }

    Timer {
        id: startupLoadedTimer
        interval: 2000
        running: true

        onTriggered: {
            if (!root.active) {
                root.loaded = false
            }
        }
    }
}
