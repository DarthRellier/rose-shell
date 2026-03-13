pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import QtQuick.Controls.Fusion
import Quickshell.Wayland
import qs

WlSessionLockSurface {
    id: root
    required property LockContext context

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
            var randomIndex = Math.floor(Math.random() * folderListModel.count)
            return folderListModel.get(randomIndex, "fileUrl")
        }
    }

    Button {
        text: "It's not working, let me out!"
        onClicked: root.context.unlocked()
    }

    ColumnLayout {
        // Uncommenting this will make the password entry invisible except on the active monitor.
        // visible: Window.active

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.verticalCenter
        }

        RowLayout {
            TextField {
                id: passwordBox

                implicitWidth: 400
                padding: 10

                focus: true
                enabled: !root.context.unlockInProgress
                echoMode: TextInput.Password
                inputMethodHints: Qt.ImhSensitiveData

                // Update the text in the context when the text in the box changes.
                onTextChanged: root.context.currentText = this.text

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

            Button {
                text: "Unlock"
                padding: 10

                // don't steal focus from the text box
                focusPolicy: Qt.NoFocus

                enabled: !root.context.unlockInProgress && root.context.currentText !== ""
                onClicked: root.context.tryUnlock()
            }
        }

        Label {
            visible: root.context.showErrorMsg
            text: "Incorrect password"
            color: Theme.rose
        }
    }
}
