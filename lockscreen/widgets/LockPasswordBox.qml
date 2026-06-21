pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import qs
import qs.lockscreen

ColumnLayout {
    id: root

    required property LockContext context

    property bool passwordCharsGreaterThanZero: passwordBox.text.length > 0
    
    TextInput {
        id: passwordBox

        focus: true
        enabled: !root.context.unlockInProgress
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhSensitiveData
        color: "transparent"
        Layout.preferredHeight: 0

        cursorDelegate: Rectangle {
            color: "transparent"
        }

        // Prevent Selection
        onSelectionStartChanged: () => {
            deselect();
            cursorPosition = displayText.length + 1;
        }

        onSelectionEndChanged: () => {
            deselect();
            cursorPosition = displayText.length + 1;
        }

        // Update the text in the context when the text in the box changes.
        onTextChanged: () => {
            root.context.currentText = this.text;
            deselect();
            cursorPosition = displayText.length + 1;
        }

        // Try to unlock when enter is pressed.
        onAccepted: root.context.tryUnlock()

        // Update the text in the box to match the text in the context.
        // This makes sure multiple monitors have the same text.
        Connections {
            target: root.context

            function onCurrentTextChanged() {
                passwordBox.text = root.context.currentText;
            }
        }
    }

    RowLayout {
        Item {
            Layout.fillWidth: true
        }

        ListView {
            spacing: 5
            orientation: Qt.Horizontal
            interactive: false

            Layout.preferredWidth: contentWidth
            Layout.preferredHeight: 24

            model: root.context.currentTextModel

            delegate: Text {
                id: dotText
                text: ""

                font.family: Theme.symbols
                font.pointSize: 16

                color: passwordBox.enabled ? Theme.rose : Theme.subtle

                ListView.onRemove: removeAnim.start()
                ListView.onAdd: addAnim.start()

                width: 10
                horizontalAlignment: Text.AlignHCenter
                transformOrigin: Item.Center

                SequentialAnimation {
                    id: removeAnim
                    PropertyAction {
                        target: dotText
                        property: "ListView.delayRemove"
                        value: true
                    }
                    ParallelAnimation {
                        NumberAnimation {
                            target: dotText
                            property: "scale"
                            to: 0
                            duration: 150
                        }

                        NumberAnimation {
                            target: dotText
                            property: "opacity"
                            to: 0
                            duration: 100
                        }
                    }
                    PropertyAction {
                        target: dotText
                        property: "ListView.delayRemove"
                        value: false
                    }
                }

                ParallelAnimation {
                    id: addAnim
                    NumberAnimation {
                        target: dotText
                        property: "scale"
                        from: 0
                        to: 1
                        duration: 100
                    }
                    NumberAnimation {
                        target: dotText
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 150
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
