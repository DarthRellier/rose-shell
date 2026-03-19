pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import QtQuick.Controls.Fusion
import Quickshell.Wayland
import qs
import qs.services

WlSessionLockSurface {
    id: root
    required property LockContext context

    signal unlockAnimFinished

    color: Theme.surface

    Image {
        anchors.fill: parent
        source: getRandomPaper()
        fillMode: Qt.PreserveAspectCrop

        FolderListModel {
            id: folderListModel
            folder: Qt.resolvedUrl("../assets/lockscreen-papers")
            nameFilters: ["*.jpg", "*.png"]
            showDirs: false
        }

        function getRandomPaper() {
            var randomIndex = Math.floor(Math.random() * folderListModel.count);
            return folderListModel.get(randomIndex, "fileUrl");
        }
    }

    // Button {
    //     text: "help it doesn't work"

    //     onClicked: root.context.unlocked()
    // }

    ColumnLayout {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        // Time + Date
        Text {
            text: Qt.formatDate(new Date(), "dddd, MMMM d, yyyy")

            font.pointSize: 11
            font.family: Theme.varela

            color: Theme.rose
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            Layout.fillWidth: true
        }

        Text {
            id: clock

            text: Qt.formatDateTime(Time.clock.date, "h:mm AP")

            font.pointSize: 48
            font.family: Theme.varela

            color: Theme.rose
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            Layout.fillWidth: true
        }

        // Lock Indicator
        Rectangle {
            Layout.preferredHeight: 150
            Layout.preferredWidth: 150

            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 15
            Layout.bottomMargin: 15

            radius: width / 2
            color: Qt.alpha(Theme.surface, 0.65)

            Text {
                id: lockIcon
                text: ""

                font.pointSize: 55
                font.family: Theme.symbols

                color: root.context.showPamFprintAllowed ? Theme.text : Theme.gold
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                anchors.centerIn: parent

                SequentialAnimation {
                    id: failSequence

                    running: false

                    NumberAnimation {
                        target: lockIcon
                        property: "anchors.horizontalCenterOffset"
                        to: 10
                        duration: 75
                    }

                    NumberAnimation {
                        target: lockIcon
                        property: "anchors.horizontalCenterOffset"
                        to: -10
                        duration: 75
                    }

                    NumberAnimation {
                        target: lockIcon
                        property: "anchors.horizontalCenterOffset"
                        to: 10
                        duration: 75
                    }

                    NumberAnimation {
                        target: lockIcon
                        property: "anchors.horizontalCenterOffset"
                        to: -10
                        duration: 75
                    }

                    NumberAnimation {
                        target: lockIcon
                        property: "anchors.horizontalCenterOffset"
                        to: 10
                        duration: 75
                    }

                    NumberAnimation {
                        target: lockIcon
                        property: "anchors.horizontalCenterOffset"
                        to: -10
                        duration: 75
                    }

                    NumberAnimation {
                        target: lockIcon
                        property: "anchors.horizontalCenterOffset"
                        to: 0
                        duration: 75
                    }

                    onStarted: () => {
                        lockIcon.color = Theme.love;
                    }

                    onFinished: () => {
                        lockIcon.color = root.context.showPamFprintAllowed ? Theme.text : Theme.gold;
                    }
                }

                SequentialAnimation {
                    id: successSequence

                    onStarted: () => {
                        lockIcon.color = Theme.rose;
                        lockIcon.rotation = 0;
                    }

                    NumberAnimation {
                        target: lockIcon
                        property: "rotation"
                        to: 360
                        duration: 350
                    }

                    PropertyAction {
                        target: lockIcon
                        property: "text"
                        value: ""
                    }

                    PauseAnimation {
                        duration: 500
                    }

                    onFinished: () => {
                        root.unlockAnimFinished();
                    }
                }

                Connections {
                    target: root.context

                    function onFailed() {
                        failSequence.start();
                    }

                    function onFingerprintFailed() {
                        failSequence.start();
                    }

                    function onUnlocked() {
                        successSequence.start();
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    focusPolicy: Qt.NoFocus

                    enabled: !root.context.unlockInProgress && root.context.currentText !== ""
                    onClicked: root.context.tryUnlock()
                }
            }
        }

        // Instructions
        Text {
            text: root.context.showPamFprintAllowed ? "Enter password or\nfingerprint to unlock" : "Enter password\nto unlock"

            font.pointSize: 13
            font.family: Theme.varela

            color: Theme.rose
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            Layout.alignment: Qt.AlignHCenter
        }

        // Seperator
        Rectangle {
            Layout.preferredHeight: 25
            Layout.preferredWidth: 1
            color: "transparent"
        }

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

        Text {
            text: Niri.shortenedKeyboardLayout.toUpperCase()

            font.pointSize: 11
            font.family: Theme.varela

            color: passwordBox.text.length > 0 ? Theme.rose : "transparent"
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.topMargin: 6
        }
    }
}
