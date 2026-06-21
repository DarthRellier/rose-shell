pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs
import qs.components.sidebar

SidebarThemeButton {
    id: root

    required property var parentWindowObject
    property bool active: false
    property bool loaded: true
    property bool closeTimerRunning: true

    text: ""
    useSymbolFont: true
    pointSize: 14

    normalFg: Theme.rose
    pressedFg: Theme.rose

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
            anchor.rect.y: root.parentWindowObject.height - root.y

            implicitWidth: Math.round(Theme.sidebarPillWidth)
            implicitHeight: column.height + Theme.generalPadding

            visible: true
            color: "transparent"

            Rectangle {
                id: contentRect
                implicitWidth: Math.ceil(Theme.sidebarPillWidth)
                implicitHeight: column.height + Theme.generalPadding
                color: Theme.overlay
                radius: width / 2

                x: root.active ? 0 : -1 * Math.ceil(Theme.sidebarPillWidth)

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

                            Layout.preferredHeight: Theme.systrayIconSize
                            Layout.preferredWidth: Theme.systrayIconSize
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
