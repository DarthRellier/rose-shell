pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    required property var chordList
    required property string targetName

    property bool active: false
    property bool loaded: false

    LazyLoader {
        active: root.loaded

        PanelWindow {
            id: panel

            focusable: true

            anchors {
                bottom: true
                right: true
            }

            Component.onCompleted: {
                if (this.WlrLayershell != null) {
                    this.WlrLayershell.layer = WlrLayer.Overlay;
                }
            }

            margins.bottom: 10

            implicitWidth: 260
            implicitHeight: listColumn.height + 20

            color: "transparent"

            Rectangle {
                width: parent.width - 10
                height: parent.height
                anchors.rightMargin: 10

                color: Theme.surface
                radius: panel.width / 16

                border {
                    width: 3
                    color: Theme.highlightMed
                }

                x: root.active ? 0 : 250

                Behavior on x {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutCubic
                        onRunningChanged: {
                            if (!running && !root.active) {
                                root.loaded = false;
                            }
                        }
                    }
                }

                ColumnLayout {
                    id: listColumn

                    anchors.verticalCenter: parent.verticalCenter

                    Repeater {
                        model: root.chordList.sort((a, b) => {
                            return a.chordName.localeCompare(b.chordName);
                        })

                        RowLayout {
                            id: textRow

                            required property var modelData

                            Layout.leftMargin: 25
                            Layout.topMargin: 7.5
                            Layout.bottomMargin: 7.5

                            Text {
                                text: textRow.modelData.chordName.toUpperCase()

                                font.family: Theme.varela
                                font.pointSize: 12
                                font.bold: true

                                color: textRow.modelData.modifiers ? Theme.love : Theme.rose

                                Layout.rightMargin: 35 - width
                            }

                            Text {
                                text: textRow.modelData.description

                                font.family: Theme.varela
                                font.pointSize: 12

                                color: Theme.text
                            }
                        }
                    }
                }
            }

            Item {
                anchors.fill: parent
                focus: true
                Keys.onPressed: event => {
                    root.chordList.forEach(element => {
                        if (element.chord == event.key) {
                            if (element.modifiers) {
                                if (event.modifiers == element.modifiers) {
                                    event.accepted = true;
                                    Quickshell.execDetached(["niri", "msg", "action", "spawn", "--", ...element.command.split(" ")]);
                                    root.active = false;
                                }
                            } else {
                                event.accepted = true;
                                Quickshell.execDetached(["niri", "msg", "action", "spawn", "--", ...element.command.split(" ")]);
                                root.active = false;
                            }
                        }
                    });

                    if (event.key == Qt.Key_Escape) {
                        event.accepted = true;
                        root.active = false;
                    }
                }
            }
        }
    }

    IpcHandler {
        target: root.targetName

        function flip() {
            root.loaded = true;
            root.active = !root.active;
        }
    }
}
