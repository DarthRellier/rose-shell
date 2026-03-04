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
                text: getAudioSymbol(Audio.muted, Audio.volume * 100)
                font.family: Theme.symbols
                font.pointSize: 12
                color: Theme.text

                Layout.leftMargin: 10

                function getAudioSymbol(muted, volume) {
                    if (muted) {
                        return "";
                    } else if (volume < 25) {
                        return "";
                    } else if (volume < 75) {
                        return "";
                    } else {
                        return "";
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

                value: Audio.volume * 100

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
            target: Audio

            function onVolumeChanged() {
                contentRect.y = 0;
                visibleTimer.restart();
            }

            function onMutedChanged() {
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
