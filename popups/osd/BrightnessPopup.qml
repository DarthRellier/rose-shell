import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs
import qs.services
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

PanelWindow {
    // Settings

    id: root

    anchors.bottom: true
    implicitHeight: Theme.osdPopupHeight + Theme.osdPopupBottomPadding
    implicitWidth: Theme.osdPopupWidth

    color: "transparent"
    aboveWindows: true
    exclusionMode: ExclusionMode.Ignore

    property bool active: true

    Component.onCompleted: {
        if (this.WlrLayershell != null) {
            this.WlrLayershell.layer = WlrLayer.Overlay;
        }
    }

    // Content
    Rectangle {
        id: contentRect

        implicitHeight: Theme.osdPopupHeight
        implicitWidth: Theme.osdPopupWidth
        radius: Theme.osdPopupHeight / 2

        color: Theme.overlay

        border.width: Theme.generalBorder
        border.color: Theme.highlightMed

        y: Theme.osdPopupBottomPadding + height

        RowLayout {
            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter

            spacing: 5

            Text {
                text: getBrightnessSymbol(Brightness.brightnessPct)
                font.family: Theme.symbols
                font.pointSize: 12
                color: Theme.text

                Layout.leftMargin: 10

                function getBrightnessSymbol(brightness) {
                    if (brightness < 25) {
                        return "󰃞";
                    } else if (brightness < 75) {
                        return "󰃟";
                    } else {
                        return "󰃠";
                    }
                }
            }

            ProgressBar {
                id: progressBar
                Layout.preferredHeight: Theme.osdProgressBarHeight
                Layout.preferredWidth: Theme.osdProgressBarWidth

                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                contentItem: Item {
                    anchors.fill: parent
                    Rectangle {
                        anchors.fill: parent
                        color: Theme.surface
                        radius: height / 2
                    }
                    Rectangle {
                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                        }
                        width: progressBar.visualPosition * parent.width
                        radius: height / 2
                        color: Theme.rose
                    }
                }

                from: 0.0
                to: 100.0

                value: Brightness.brightnessPct

                Behavior on value {
                    NumberAnimation {
                        duration: 100
                    }
                }
            }
        }

        // Animations
        Timer {
            id: visibleTimer
            interval: 1000
            running: false

            onTriggered: {
                contentRect.y = Theme.osdPopupBottomPadding + root.height;
            }
        }

        Connections {
            target: Brightness

            function onBrightnessChanged() {
                contentRect.y = 0;
                visibleTimer.restart();
            }
        }

        Behavior on y {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutCubic
            }
        }
    }
}
