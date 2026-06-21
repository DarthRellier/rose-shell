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
                    this.WlrLayershell.keyboardFocus = WlrKeyboardFocus.Exclusive
                }
            }

            implicitWidth: ThemeMetrics.chordListWidth + ThemeMetrics.chordListPadding
            implicitHeight: listColumn.height + ThemeMetrics.generalPadding

            color: "transparent"

            Rectangle {
                width: parent.width - ThemeMetrics.chordListPadding
                height: parent.height
                anchors.rightMargin: ThemeMetrics.chordListPadding

                color: ThemeColors.surface
                radius: panel.width / 16

                border {
                    width: ThemeMetrics.generalBorder
                    color: ThemeColors.highlightMed
                }

                x: root.active ? 0 : ThemeMetrics.chordListWidth

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

                            Layout.leftMargin: ThemeMetrics.chordListLeftMargin
                            Layout.topMargin: ThemeMetrics.chordListVSpacing / 2
                            Layout.bottomMargin: ThemeMetrics.chordListVSpacing / 2

                            Text {
                                text: textRow.modelData.chordName.toUpperCase()

                                font.family: ThemeFonts.boldFont
                                font.pointSize: 12

                                color: textRow.modelData.modifiers ? ThemeColors.love : ThemeColors.rose

                                Layout.rightMargin: ThemeMetrics.chordListGapSize - width
                            }

                            Text {
                                text: textRow.modelData.description

                                font.family: ThemeFonts.font
                                font.pointSize: 12

                                color: ThemeColors.text
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
