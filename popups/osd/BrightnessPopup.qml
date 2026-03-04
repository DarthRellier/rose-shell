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
    implicitHeight: 50
    implicitWidth: 200

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

        implicitHeight: 40
        implicitWidth: 200
        radius: 100

        color: Theme.overlay

        y: 50

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
                Layout.preferredHeight: 10
                Layout.preferredWidth: 150

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
                        radius: 100
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
                contentRect.y = 50;
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
